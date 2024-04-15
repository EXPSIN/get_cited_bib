# get_cited_bib
一个用于提取tex文件已引用bib的matlab脚本。

运行脚本get_cited_bib.m，从原始bib中，快速提取具有期望名称的bib，并复制到新文件中。

其流程为
1. 获取已经引用的bib的名称，该过程通过读取latex编译生成的aux实现
[entry, entry_idx] = get_entry_from_aux('demo_aux.aux');
2. 定义bib的输入文件名：
inputBibFile       = 'demo_bib.bib';
3. 定义bib的输出文件名：
outputBibFile      = 'res.bib';
4. 提取引用的bib文件
extract_bib_entries_by_string(inputBibFile, entry, outputBibFile);


函数extract_bib_entries_by_string(inputBibFile, searchString, outputBibFile)其输入是，其输出为空，会生成一个存储了结果的名为outputBibFile的文件。
1. 原始bib文件名：inputBibFile，其格式为字符串
2. 输出bib文件名：outputBibFile，其格式为z字符串
3. 希望提取的bib名称：searchString，其格式为元胞数组

注意事项：
1. 请保证该脚本和bib文件以及aux文件处于同一个目录下；
2. 请保证原有bib无格式错误；
