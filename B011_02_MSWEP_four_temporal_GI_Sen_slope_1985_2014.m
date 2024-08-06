%% 这个文件根据MSWEP数据，升尺度的结果，计算基尼系数的Sen斜率
%% 直接用paper2的结果

%% 3-hour

clear;clc;
path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')

load('F:\File_of_MATLAB\research_of_MSWEP\data\Full Gini index 3h preprocessing01.mat')
% 数据的时间尺度从1979-2015，所以只取出其中1985-2014部分
Full_Gini_3h_MWSEP_1985_2014 = Full_Gini_3h_MWSEP(:,:,7:end-1);
clear Full_Gini_3h_MWSEP

Gini_Sen_slope_3h = nan(size(Full_Gini_3h_MWSEP_1985_2014,1),size(Full_Gini_3h_MWSEP_1985_2014,2));
Gini_MK_3h = nan(size(Full_Gini_3h_MWSEP_1985_2014,1),size(Full_Gini_3h_MWSEP_1985_2014,2));
% 计算Sen趋势
for i = 1 : size(Full_Gini_3h_MWSEP_1985_2014,1)
    for j = 1 : size(Full_Gini_3h_MWSEP_1985_2014,2)
        a = reshape(Full_Gini_3h_MWSEP_1985_2014(i,j,:),[1,size(Full_Gini_3h_MWSEP_1985_2014,3)]);
        Gini_Sen_slope_3h(i,j) = Theil_Sen_Regress((1985:2014)',a');
        Gini_MK_3h(i,j) = MK(a');
        clear a
    end
end
clear filename2
filename2 = 'MSWEP_3h_Gini_MK_and_Sen_1985_2014_01mmh.mat';
save(['J:\6-硕士毕业论文\1-Data\MSWEP-V280-1985-2014\003-GI-Sen-slope\',filename2],'Gini_Sen_slope_3h','Gini_MK_3h')

%% 6-hour

clear;clc;
path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')

load('F:\File_of_MATLAB\research_of_MSWEP\data\Full Gini index 6h preprocessing01.mat')
% 数据的时间尺度从1979-2015，所以只取出其中1985-2014部分
Full_Gini_6h_MWSEP_1985_2014 = Full_Gini_6h_MWSEP(:,:,7:end-1);
clear Full_Gini_6h_MWSEP

Gini_Sen_slope_6h = nan(size(Full_Gini_6h_MWSEP_1985_2014,1),size(Full_Gini_6h_MWSEP_1985_2014,2));
Gini_MK_6h = nan(size(Full_Gini_6h_MWSEP_1985_2014,1),size(Full_Gini_6h_MWSEP_1985_2014,2));
% 计算Sen趋势
for i = 1 : size(Full_Gini_6h_MWSEP_1985_2014,1)
    for j = 1 : size(Full_Gini_6h_MWSEP_1985_2014,2)
        a = reshape(Full_Gini_6h_MWSEP_1985_2014(i,j,:),[1,size(Full_Gini_6h_MWSEP_1985_2014,3)]);
        Gini_Sen_slope_6h(i,j) = Theil_Sen_Regress((1985:2014)',a');
        Gini_MK_6h(i,j) = MK(a');
        clear a
    end
end
clear filename2
filename2 = 'MSWEP_6h_Gini_MK_and_Sen_1985_2014_01mmh.mat';
save(['J:\6-硕士毕业论文\1-Data\MSWEP-V280-1985-2014\003-GI-Sen-slope\',filename2],'Gini_Sen_slope_6h','Gini_MK_6h')

%% 12-hour

clear;clc;
path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')

load('F:\File_of_MATLAB\research_of_MSWEP\data\Full Gini index 12h preprocessing01.mat')

% 数据的时间尺度从1979-2015，所以只取出其中1985-2014部分
Full_Gini_12h_MWSEP_1985_2014 = Full_Gini_12h_MWSEP(:,:,7:end-1);

Gini_Sen_slope_12h = nan(size(Full_Gini_12h_MWSEP_1985_2014,1),size(Full_Gini_12h_MWSEP_1985_2014,2));
Gini_MK_12h = nan(size(Full_Gini_12h_MWSEP_1985_2014,1),size(Full_Gini_12h_MWSEP_1985_2014,2));
% 计算Sen趋势
for i = 1 : size(Full_Gini_12h_MWSEP_1985_2014,1)
    for j = 1 : size(Full_Gini_12h_MWSEP_1985_2014,2)
        a = reshape(Full_Gini_12h_MWSEP_1985_2014(i,j,:),[1,size(Full_Gini_12h_MWSEP_1985_2014,3)]);
        Gini_Sen_slope_12h(i,j) = Theil_Sen_Regress((1985:2014)',a');
        Gini_MK_12h(i,j) = MK(a');
        clear a
    end
end
clear filename2
filename2 = 'MSWEP_12h_Gini_MK_and_Sen_1985_2014_01mmh.mat';
save(['J:\6-硕士毕业论文\1-Data\MSWEP-V280-1985-2014\003-GI-Sen-slope\',filename2],'Gini_Sen_slope_12h','Gini_MK_12h')

%% 1-day

clear;clc;
path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')

load('F:\File_of_MATLAB\research_of_MSWEP\data\Full Gini index 1d preprocessing01.mat')

% 数据的时间尺度从1979-2015，所以只取出其中1985-2014部分
Full_Gini_1d_MWSEP_1985_2014 = Full_Gini_1d_MWSEP(:,:,7:end-1);
clear Full_Gini_1d_MWSEP

Gini_Sen_slope_1d = nan(size(Full_Gini_1d_MWSEP_1985_2014,1),size(Full_Gini_1d_MWSEP_1985_2014,2));
Gini_MK_1d = nan(size(Full_Gini_1d_MWSEP_1985_2014,1),size(Full_Gini_1d_MWSEP_1985_2014,2));
% 计算Sen趋势
for i = 1 : size(Full_Gini_1d_MWSEP_1985_2014,1)
    for j = 1 : size(Full_Gini_1d_MWSEP_1985_2014,2)
        a = reshape(Full_Gini_1d_MWSEP_1985_2014(i,j,:),[1,size(Full_Gini_1d_MWSEP_1985_2014,3)]);
        Gini_Sen_slope_1d(i,j) = Theil_Sen_Regress((1985:2014)',a');
        Gini_MK_1d(i,j) = MK(a');
        clear a
    end
end
clear filename2
filename2 = 'MSWEP_1d_Gini_MK_and_Sen_1985_2014_01mmh.mat';
save(['J:\6-硕士毕业论文\1-Data\MSWEP-V280-1985-2014\003-GI-Sen-slope\',filename2],'Gini_Sen_slope_1d','Gini_MK_1d')
