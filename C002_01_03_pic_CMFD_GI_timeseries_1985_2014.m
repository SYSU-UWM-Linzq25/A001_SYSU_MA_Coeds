%% 这个文件画CMFD数据四种时间尺度的全国平均时间序列
%% 原始空间尺度（0.1°）
%% 3-hour以外的时间尺度从3-hour升尺度而来

clear;clc;
% 3h
filename2 = 'CMFD_3h_Gini_1979_2018_01mmh.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\3-1-Gini&LinearTrend\',filename2])
% 统一选取年份范围为1985-2014
Gini_CMFD_3h_1985_2014 = Gini_CMFD_3h(:,:,7:end-4);
clear Gini_CMFD_3h
% 6-hour
clear filename2
filename2 = 'Full Gini index 6h.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\0-from-paper2\6h\full Gini\',filename2])
% 统一选取年份范围为1985-2014
Gini_CMFD_6h_1985_2014 = Full_Gini_6h_all(:,:,7:end-4);
clear Full_Gini_6h_all
% 12-hour
clear filename2
filename2 = 'Full Gini index 12h.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\0-from-paper2\12h\full Gini\',filename2])
% 统一选取年份范围为1985-2014
Gini_CMFD_12h_1985_2014 = Full_Gini_12h_all(:,:,7:end-4);
clear Full_Gini_12h_all
% 1-day
clear filename2
filename2 = 'Full Gini index 1d.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\0-from-paper2\1d\full Gini\',filename2])
% 统一选取年份范围为1985-2014
Gini_CMFD_1d_1985_2014 = Full_Gini_1d_all(:,:,7:end-4);
clear Full_Gini_1d_all

Gini_CMFD_3h_1985_2014_2D = reshape(Gini_CMFD_3h_1985_2014,[],size(Gini_CMFD_3h_1985_2014,3));
Gini_CMFD_6h_1985_2014_2D = reshape(Gini_CMFD_6h_1985_2014,[],size(Gini_CMFD_6h_1985_2014,3));
Gini_CMFD_12h_1985_2014_2D = reshape(Gini_CMFD_12h_1985_2014,[],size(Gini_CMFD_12h_1985_2014,3));
Gini_CMFD_1d_1985_2014_2D = reshape(Gini_CMFD_1d_1985_2014,[],size(Gini_CMFD_1d_1985_2014,3));

Z = nanmean(Gini_CMFD_3h_1985_2014_2D,1)';
Z1 = nanmean(Gini_CMFD_6h_1985_2014_2D,1)';
Z2 = nanmean(Gini_CMFD_12h_1985_2014_2D,1)';
Z3 = nanmean(Gini_CMFD_1d_1985_2014_2D,1)';
time_period = 1985:2014;

Timeseries_movmean_group2(Z,Z1,Z2,Z3,time_period,3)

cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\002-01-CMFD-3h-6h-12h-1d-GI-and-Sen-Trend\全国平均的时间序列\')
exportgraphics(gcf,['全国平均基尼系数的时间序列（滑动平均3年）.jpg'])