# get_cited_bib
一个用于提取tex文件已引用bib的matlab脚本。

该脚本用于从原始bib中，快速提取具有期望名称的bib，并复制到新文件中。

其输入是
1. 原始bib文件名：inputBibFile，其格式为字符串
2. 输出bib文件名：outputBibFile，其格式为z字符串
3. 希望提取的bib名称：searchString，其格式为元胞数组

其调用过程为
extract_bib_entries_by_string(inputBibFile, searchString, outputBibFile);

注意事项：
1. 请保证该脚本和bib文件处于同一个目录下；
2. 请保证原有bib无格式错误；
3. 测试脚本及测试文件，见快速提取bib.zip 
