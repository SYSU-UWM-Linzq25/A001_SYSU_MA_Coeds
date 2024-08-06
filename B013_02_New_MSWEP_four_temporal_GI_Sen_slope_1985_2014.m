%% 这个文件根据新的MSWEP数据，计算基尼系数的Sen斜率
%% 空间尺度为0.1°

%% 3-hour

clear;clc;
path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')

load('J:\6-硕士毕业论文\1-Data\MSWEP_Data_1979_2020\2-Gini-and-LinearTrend\1985-2014\MSWEP_3h_GI_CN_1985_2014.mat')

Gini_Sen_slope_3h = nan(size(Gini_MSWEP_3h_1985_2014,1),size(Gini_MSWEP_3h_1985_2014,2));
Gini_MK_3h = nan(size(Gini_MSWEP_3h_1985_2014,1),size(Gini_MSWEP_3h_1985_2014,2));
% 计算Sen趋势
for i = 1 : size(Gini_MSWEP_3h_1985_2014,1)
    for j = 1 : size(Gini_MSWEP_3h_1985_2014,2)
        a = reshape(Gini_MSWEP_3h_1985_2014(i,j,:),[1,size(Gini_MSWEP_3h_1985_2014,3)]);
        Gini_Sen_slope_3h(i,j) = Theil_Sen_Regress((1985:2014)',a');
        Gini_MK_3h(i,j) = MK(a');
        clear a
    end
end
clear filename2
filename2 = 'MSWEP_3h_Gini_MK_and_Sen_1985_2014_01mmh.mat';
save(['J:\6-硕士毕业论文\1-Data\MSWEP_Data_1979_2020\2-Gini-and-LinearTrend\1985-2014\',filename2],'Gini_Sen_slope_3h','Gini_MK_3h','Lon','Lat')

%% 6-hour

clear;clc;
path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')

load('J:\6-硕士毕业论文\1-Data\MSWEP_Data_1979_2020\2-Gini-and-LinearTrend\1985-2014\MSWEP_6h_GI_CN_1985_2014.mat')

Gini_Sen_slope_6h = nan(size(Gini_MSWEP_6h_1985_2014,1),size(Gini_MSWEP_6h_1985_2014,2));
Gini_MK_6h = nan(size(Gini_MSWEP_6h_1985_2014,1),size(Gini_MSWEP_6h_1985_2014,2));
% 计算Sen趋势
for i = 1 : size(Gini_MSWEP_6h_1985_2014,1)
    for j = 1 : size(Gini_MSWEP_6h_1985_2014,2)
        a = reshape(Gini_MSWEP_6h_1985_2014(i,j,:),[1,size(Gini_MSWEP_6h_1985_2014,3)]);
        Gini_Sen_slope_6h(i,j) = Theil_Sen_Regress((1985:2014)',a');
        Gini_MK_6h(i,j) = MK(a');
        clear a
    end
end
clear filename2
filename2 = 'MSWEP_6h_Gini_MK_and_Sen_1985_2014_01mmh.mat';
save(['J:\6-硕士毕业论文\1-Data\MSWEP_Data_1979_2020\2-Gini-and-LinearTrend\1985-2014\',filename2],'Gini_Sen_slope_6h','Gini_MK_6h','Lon','Lat')

%% 12-hour

clear;clc;
path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')

load('J:\6-硕士毕业论文\1-Data\MSWEP_Data_1979_2020\2-Gini-and-LinearTrend\1985-2014\MSWEP_12h_GI_CN_1985_2014.mat')

Gini_Sen_slope_12h = nan(size(Gini_MSWEP_12h_1985_2014,1),size(Gini_MSWEP_12h_1985_2014,2));
Gini_MK_12h = nan(size(Gini_MSWEP_12h_1985_2014,1),size(Gini_MSWEP_12h_1985_2014,2));
% 计算Sen趋势
for i = 1 : size(Gini_MSWEP_12h_1985_2014,1)
    for j = 1 : size(Gini_MSWEP_12h_1985_2014,2)
        a = reshape(Gini_MSWEP_12h_1985_2014(i,j,:),[1,size(Gini_MSWEP_12h_1985_2014,3)]);
        Gini_Sen_slope_12h(i,j) = Theil_Sen_Regress((1985:2014)',a');
        Gini_MK_12h(i,j) = MK(a');
        clear a
    end
end
clear filename2
filename2 = 'MSWEP_12h_Gini_MK_and_Sen_1985_2014_01mmh.mat';
save(['J:\6-硕士毕业论文\1-Data\MSWEP_Data_1979_2020\2-Gini-and-LinearTrend\1985-2014\',filename2],'Gini_Sen_slope_12h','Gini_MK_12h','Lon','Lat')

%% 1-day

clear;clc;
path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')

load('J:\6-硕士毕业论文\1-Data\MSWEP_Data_1979_2020\2-Gini-and-LinearTrend\1985-2014\MSWEP_1d_GI_CN_1985_2014.mat')

Gini_Sen_slope_1d = nan(size(Gini_MSWEP_1d_1985_2014,1),size(Gini_MSWEP_1d_1985_2014,2));
Gini_MK_1d = nan(size(Gini_MSWEP_1d_1985_2014,1),size(Gini_MSWEP_1d_1985_2014,2));
% 计算Sen趋势
for i = 1 : size(Gini_MSWEP_1d_1985_2014,1)
    for j = 1 : size(Gini_MSWEP_1d_1985_2014,2)
        a = reshape(Gini_MSWEP_1d_1985_2014(i,j,:),[1,size(Gini_MSWEP_1d_1985_2014,3)]);
        Gini_Sen_slope_1d(i,j) = Theil_Sen_Regress((1985:2014)',a');
        Gini_MK_1d(i,j) = MK(a');
        clear a
    end
end
clear filename2
filename2 = 'MSWEP_1d_Gini_MK_and_Sen_1985_2014_01mmh.mat';
save(['J:\6-硕士毕业论文\1-Data\MSWEP_Data_1979_2020\2-Gini-and-LinearTrend\1985-2014\',filename2],'Gini_Sen_slope_1d','Gini_MK_1d','Lon','Lat')
