%% 计算四个时间尺度基尼系数的Sen趋势，其中3-hour以外的是升尺度降水数据得到的
%% 研究时段为1985-2014
%% 阈值为 0.1 mm/h

clear;clc;
path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')

% 3h
filename2 = 'CMFD_3h_Gini_1979_2018_01mmh.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\3-1-Gini&LinearTrend\',filename2])
% 统一选取年份范围为1985-2014
Gini_CMFD_3h_1985_2014 = Gini_CMFD_3h(:,:,7:end-4);
clear Gini_CMFD_3h

Gini_Sen_slope_3h = nan(size(Gini_CMFD_3h_1985_2014,1),size(Gini_CMFD_3h_1985_2014,2));
Gini_MK_3h = nan(size(Gini_CMFD_3h_1985_2014,1),size(Gini_CMFD_3h_1985_2014,2));
% 计算Sen趋势
for i = 1 : size(Gini_CMFD_3h_1985_2014,1)
    for j = 1 : size(Gini_CMFD_3h_1985_2014,2)
        a = reshape(Gini_CMFD_3h_1985_2014(i,j,:),[1,size(Gini_CMFD_3h_1985_2014,3)]);
        Gini_Sen_slope_3h(i,j) = Theil_Sen_Regress((1985:2014)',a');
        Gini_MK_3h(i,j) = MK(a');
        clear a
    end
end
clear filename2
filename2 = 'CMFD_3h_Gini_MK_Sen_1985_2014_01mmh.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\3-2-Sen-Trend\',filename2],'Gini_Sen_slope_3h','Gini_MK_3h','Lon','Lat')


% 6-hour
clear filename2
filename2 = 'Full Gini index 6h.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\0-from-paper2\6h\full Gini\',filename2])
% 统一选取年份范围为1985-2014
Gini_CMFD_6h_1985_2014 = Full_Gini_6h_all(:,:,7:end-4);
clear Full_Gini_6h_all

Gini_Sen_slope_6h = nan(size(Gini_CMFD_6h_1985_2014,1),size(Gini_CMFD_6h_1985_2014,2));
Gini_MK_6h = nan(size(Gini_CMFD_6h_1985_2014,1),size(Gini_CMFD_6h_1985_2014,2));
% 计算Sen趋势
for i = 1 : size(Gini_CMFD_6h_1985_2014,1)
    for j = 1 : size(Gini_CMFD_6h_1985_2014,2)
        a = reshape(Gini_CMFD_6h_1985_2014(i,j,:),[1,size(Gini_CMFD_6h_1985_2014,3)]);
        Gini_Sen_slope_6h(i,j) = Theil_Sen_Regress((1985:2014)',a');
        Gini_MK_6h(i,j) = MK(a');
        clear a
    end
end
clear filename2
filename2 = 'CMFD_6h_Gini_MK_Sen_1985_2014_01mmh.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\3-2-Sen-Trend\',filename2],'Gini_Sen_slope_6h','Gini_MK_6h')

% 12h
path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')
clear filename2
filename2 = 'Full Gini index 12h.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\0-from-paper2\12h\full Gini\',filename2])
% 统一选取年份范围为1985-2014
Gini_CMFD_12h_1985_2014 = Full_Gini_12h_all(:,:,7:end-4);
clear Full_Gini_12h_all

Gini_Sen_slope_12h = nan(size(Gini_CMFD_12h_1985_2014,1),size(Gini_CMFD_12h_1985_2014,2));
Gini_MK_12h = nan(size(Gini_CMFD_12h_1985_2014,1),size(Gini_CMFD_12h_1985_2014,2));
% 计算Sen趋势
for i = 1 : size(Gini_CMFD_12h_1985_2014,1)
    for j = 1 : size(Gini_CMFD_12h_1985_2014,2)
        a = reshape(Gini_CMFD_12h_1985_2014(i,j,:),[1,size(Gini_CMFD_12h_1985_2014,3)]);
        Gini_Sen_slope_12h(i,j) = Theil_Sen_Regress((1985:2014)',a');
        Gini_MK_12h(i,j) = MK(a');
        clear a
    end
end
clear filename2
filename2 = 'CMFD_12h_Gini_MK_Sen_1985_2014_01mmh.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\3-2-Sen-Trend\',filename2],'Gini_Sen_slope_12h','Gini_MK_12h')

% 1d
clear filename2
filename2 = 'Full Gini index 1d.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\0-from-paper2\1d\full Gini\',filename2])
% 统一选取年份范围为1985-2014
Gini_CMFD_1d_1985_2014 = Full_Gini_1d_all(:,:,7:end-4);
clear Gini_CMFD_1d

Gini_Sen_slope_1d = nan(size(Gini_CMFD_1d_1985_2014,1),size(Gini_CMFD_1d_1985_2014,2));
Gini_MK_1d = nan(size(Gini_CMFD_1d_1985_2014,1),size(Gini_CMFD_1d_1985_2014,2));
% 计算Sen趋势
for i = 1 : size(Gini_CMFD_1d_1985_2014,1)
    for j = 1 : size(Gini_CMFD_1d_1985_2014,2)
        a = reshape(Gini_CMFD_1d_1985_2014(i,j,:),[1,size(Gini_CMFD_1d_1985_2014,3)]);
        Gini_Sen_slope_1d(i,j) = Theil_Sen_Regress((1985:2014)',a');
        Gini_MK_1d(i,j) = MK(a');
        clear a
    end
end
clear filename2
filename2 = 'CMFD_1d_Gini_MK_Sen_1985_2014_01mmh.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\3-2-Sen-Trend\',filename2],'Gini_Sen_slope_1d','Gini_MK_1d')
