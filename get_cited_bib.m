clear all; clc; close all;

[entry, entry_idx] = get_entry_from_aux('demo_aux.aux');
inputBibFile       = 'demo_bib.bib';
outputBibFile      = 'res.bib';

extract_bib_entries_by_string(inputBibFile, entry, outputBibFile);


function extract_bib_entries_by_string(input_bib_file, search_string, output_bib_file)
    % extract_bib_entries_by_string: Extract BibTeX entries containing specific strings
    % Usage: extract_bib_entries_by_string(input_bib_file, search_string, output_bib_file)
    % Check if input BibTeX file exists
    if ~exist(input_bib_file, 'file')
        error('Error: Cannot open input file');
    end

    % Read input BibTeX file
    fid = fopen(input_bib_file, 'r');
    bib_data = textscan(fid, '%s', 'Delimiter', '\n');
    fclose(fid);
    bib_data = bib_data{1};

    % Create output BibTeX file
    fid = fopen(output_bib_file, 'w');
    if fid == -1
        error('Error: Cannot create output file');
    end

    % Find BibTeX entries containing specific strings and write to output file
    found_entry = false;
    in_entry = false;
    brace_cnt = 0;
    entry_lines = {};
    for j = 1:numel(bib_data)
        line = bib_data{j};
        if in_entry
            brace_cnt = brace_cnt + count(line, '{');
            brace_cnt = brace_cnt - count(line, '}');
            entry_lines{end+1} = line;
            if is_end_of_entry(line) && brace_cnt == 0
                in_entry = false;
                found_entry = true;
                % Write complete BibTeX entry
                for k = 1:numel(entry_lines)
                    fprintf(fid, '%s\n', entry_lines{k});
                end
                fprintf(fid, '\n'); % Add empty line to separate different BibTeX entries
                entry_lines = {}; % Reset entry_lines
            end
        elseif startsWith(line, '@')
            for k = 1:numel(search_string)
                if contains(line, search_string{k})
                    in_entry = true;
                    brace_cnt = count(line, '{');
                    entry_lines{end+1} = line;
                    break;
                end
            end
        end
    end

    % If no matching BibTeX entry found, display message
    if ~found_entry
        disp('No matching BibTeX entry found');
    end

    fclose(fid);
end

function result = is_end_of_entry(line)
    % is_end_of_entry: Check if it is the end of a BibTeX entry
    result = contains(line, '}');
end



function [strings, numbers] = get_entry_from_aux(filePath)
    % 读取文件内容
    fileID = fopen(filePath, 'r');
    fileContent = fscanf(fileID, '%c');
    fclose(fileID);

    % 使用正则表达式提取\bibcite{*}{*}中的字符串和数字
    pattern = '\\bibcite\{([^}]*)\}\{(\d+)\}';
    matches = regexp(fileContent, pattern, 'tokens');

    % 初始化字符串和数字数组
    strings = {};
    numbers = [];

    % 提取字符串和数字
    for i = 1:numel(matches)
        match = matches{i};
        strings{end+1,1} = match{1};
        numbers(end+1,1) = str2double(match{2});
    end
end
