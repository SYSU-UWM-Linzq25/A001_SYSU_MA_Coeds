%% 对中国数据进行预处理
clear;clc;
load('F:\File_of_MATLAB\research_of_MSWEP\data\range.mat')
cd('F:\File_of_MATLAB\research_of_MSWEP\data\Pre_China_orign\')
for year = 1985 : 2014 
    clear filename filename2 filename3  
    filename = ['Pre_China_in_',num2str(year)];
    load(filename)
    % 转换成降水率
    Pre_rate_China_year_3h = Pre_China_year ./3;
    clear Pre_China_year
    k = find(Pre_rate_China_year_3h(:,:,:) < 0.1 ); % 数据预处理，将小于0.1的均去掉
    Pre_rate_China_year_3h(k) = 0;
%     Pre_rate_China_year_sort = sort(Pre_rate_China_year,3);
%     filename2 = ['Pre_rate_China_sort_in_',num2str(year),'.mat'];
%     save(['J:\6-硕士毕业论文\1-Data\MSWEP-V280-1985-2014\001-Pre-data-processing01\3h\',filename2],'Pre_rate_China_year_sort');
    filename3 = ['Pre_China_in_',num2str(year),'.mat'];
    save(['J:\6-硕士毕业论文\1-Data\MSWEP-V280-1985-2014\001-Pre-data-processing01\3h\',filename3],'Pre_rate_China_year_3h');
    clear Pre_rate_China_year_sort Pre_rate_China_year
    disp([num2str(year),' of 3-hour scale is done!'])
end


%% 转换成6h尺度
clear;clc
cd('J:\6-硕士毕业论文\1-Data\MSWEP-V280-1985-2014\001-Pre-data-processing01\3h\');
path(path,'J:\4-论文备份\论文代码2021.4.14\tool');
for year = 1985 : 2014 
    clear filename filename2 filename3
    filename =  ['Pre_China_in_',num2str(year),'.mat'];
    load(filename)
    Pre_rate_China_year_6h = turn_3h_6h(Pre_rate_China_year); % 这里记得清除，不然容易数据的范围出错
    clear Pre_rate_China_year
%     Pre_rate_China_year_6h_sort = sort(Pre_rate_China_year_6h,3);
    filename2 = ['Pre_China_6h_in_',num2str(year),'.mat'];
    save(['J:\6-硕士毕业论文\1-Data\MSWEP-V280-1985-2014\001-Pre-data-processing01\6h\',filename2],'Pre_rate_China_year_6h');
%     filename3 = ['Pre_China_6h_sort_in_',num2str(year),'.mat'];
%     save(['J:\6-硕士毕业论文\1-Data\MSWEP-V280-1985-2014\001-Pre-data-processing01\6h\',filename3],'Pre_rate_China_year_6h_sort');
    disp([num2str(year),' of 6-hour scale is done!'])
    clear Pre_rate_China_year_6h_sort Pre_rate_China_year_6h
end

%% 将3h转成12h
clear;clc
cd('J:\6-硕士毕业论文\1-Data\MSWEP-V280-1985-2014\001-Pre-data-processing01\3h\');
path(path,'J:\4-论文备份\论文代码2021.4.14\tool');
for year = 1985 : 2014 
    clear filename filename2 filename3
    filename =  ['Pre_China_in_',num2str(year),'.mat'];
    load(filename)
    Pre_rate_China_year_12h = turn_3h_12h(Pre_rate_China_year); % 这里记得清除，不然容易数据的范围出错
    clear Pre_rate_China_year
%     Pre_rate_China_year_12h_sort = sort(Pre_rate_China_year_12h,3);
    filename2 = ['Pre_China_12h_in_',num2str(year),'.mat'];
    save(['J:\6-硕士毕业论文\1-Data\MSWEP-V280-1985-2014\001-Pre-data-processing01\12h\',filename2],'Pre_rate_China_year_12h');
%     filename3 = ['Pre_China_12h_sort_in_',num2str(year),'.mat'];
%     save(['J:\6-硕士毕业论文\1-Data\MSWEP-V280-1985-2014\001-Pre-data-processing01\12h\',filename3],'Pre_rate_China_year_12h_sort');
    disp([num2str(year),' of 12-hour scale is done!'])
    clear Pre_rate_China_year_12h_sort Pre_rate_China_year_12h
end

%% 将3h转成1d
clear;clc
cd('J:\6-硕士毕业论文\1-Data\MSWEP-V280-1985-2014\001-Pre-data-processing01\3h\');
path(path,'J:\4-论文备份\论文代码2021.4.14\tool');
for year = 1985 : 2014 
    clear filename filename2 filename3
    filename =  ['Pre_China_in_',num2str(year),'.mat'];
    load(filename)
    Pre_rate_China_year_1d = turn_3h_1d(Pre_rate_China_year); % 这里记得清除，不然容易数据的范围出错
    clear Pre_rate_China_year
%     Pre_rate_China_year_1d_sort = sort(Pre_rate_China_year_1d,3);
    filename2 = ['Pre_China_1d_in_',num2str(year),'.mat'];
    save(['J:\6-硕士毕业论文\1-Data\MSWEP-V280-1985-2014\001-Pre-data-processing01\1d\',filename2],'Pre_rate_China_year_1d');
%     filename3 = ['Pre_China_1d_sort_in_',num2str(year),'.mat'];
%     save(['J:\6-硕士毕业论文\1-Data\MSWEP-V280-1985-2014\001-Pre-data-processing01\1d\',filename3],'Pre_rate_China_year_1d_sort');
    disp([num2str(year),' of 1-day scale is done!'])
    clear Pre_rate_China_year_1d_sort Pre_rate_China_year_1d
end
