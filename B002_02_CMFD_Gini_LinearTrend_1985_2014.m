%% 计算四个时间尺度基尼系数的线性趋势，其中3-hour以外的是升尺度降水数据得到的
%% 研究时段为1985-2014
%% 阈值为 0.1 mm/h
clear;clc;

% 3h
filename2 = 'CMFD_3h_Gini_1979_2018_01mmh.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\3-1-Gini&LinearTrend\',filename2])
% 统一选取年份范围为1985-2014
Gini_CMFD_3h_1985_2014 = Gini_CMFD_3h(:,:,7:end-4);
clear Gini_CMFD_3h

% 计算线性趋势
[Gini_LineTrend_3h,~,Gini_p_value_3h,~] = Line_Trend_time_3D(Gini_CMFD_3h_1985_2014,1985:2014);

clear filename2
filename2 = 'CMFD_3h_Gini_LinearTrend_1985_2014_01mmh.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\3-1-Gini&LinearTrend\',filename2],'Gini_LineTrend_3h','Gini_p_value_3h')

% 6h
path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')
clear filename2
filename2 = 'Full Gini index 6h.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\0-from-paper2\6h\full Gini\',filename2])
% 统一选取年份范围为1985-2014
Gini_CMFD_6h_1985_2014 = Full_Gini_6h_all(:,:,7:end-4);
clear Full_Gini_6h_all

% 计算线性趋势
[Gini_LineTrend_6h,~,Gini_p_value_6h,~] = Line_Trend_time_3D(Gini_CMFD_6h_1985_2014,1985:2014);

clear filename2
filename2 = 'CMFD_6h_Gini_LinearTrend_1985_2014_01mmh.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\3-1-Gini&LinearTrend\',filename2],'Gini_LineTrend_6h','Gini_p_value_6h')

clear;clc;

% 12h
path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')
clear filename2
filename2 = 'Full Gini index 12h.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\0-from-paper2\12h\full Gini\',filename2])
% 统一选取年份范围为1985-2014
Gini_CMFD_12h_1985_2014 = Full_Gini_12h_all(:,:,7:end-4);
clear Full_Gini_12h_all

% 计算线性趋势
[Gini_LineTrend_12h,~,Gini_p_value_12h,~] = Line_Trend_time_3D(Gini_CMFD_12h_1985_2014,1985:2014);

clear filename2
filename2 = 'CMFD_12h_Gini_LinearTrend_1985_2014_01mmh.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\3-1-Gini&LinearTrend\',filename2],'Gini_LineTrend_12h','Gini_p_value_12h')

% 1d
clear filename2
filename2 = 'Full Gini index 1d.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\0-from-paper2\1d\full Gini\',filename2])
% 统一选取年份范围为1985-2014
Gini_CMFD_1d_1985_2014 = Full_Gini_1d_all(:,:,7:end-4);
clear Gini_CMFD_1d

% 计算线性趋势
[Gini_LineTrend_1d,~,Gini_p_value_1d,~] = Line_Trend_time_3D(Gini_CMFD_1d_1985_2014,1985:2014);

clear filename2
filename2 = 'CMFD_1d_Gini_LinearTrend_1985_2014_01mmh.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\3-1-Gini&LinearTrend\',filename2],'Gini_LineTrend_1d','Gini_p_value_1d')

