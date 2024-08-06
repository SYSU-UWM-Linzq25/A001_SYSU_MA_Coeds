%% 这个图画年均温和年降水量的时间序列图
%% 使用滑动平均

clear;clc;

% 读取年均温和年降水量的数据
% 读取CMFD计算得到的MAT和年降水量，用基于3h尺度数据得到的
cd('J:\6-硕士毕业论文\1-Data\CMFD\5-1-CMFD-01-scale-AP-and-MAT-01mmh\')
load('MAT_3h_01mmh_1979_2018.mat')
load('AP_3h_01mmh_1979_2018.mat')

% 读取1985-2014年的数据
MAT_01mmh_1985_2014 = MAT_3h(:,:,7:end-4);
clear MAT_3h
AP_01mmh_1985_2014 = Annual_Pr_3h_01mmh(:,:,7:end-4);
clear Annual_Pr_3h_01mmh

% 转为2D矩阵
MAT_01mmh_1985_2014_line = reshape(MAT_01mmh_1985_2014,[],size(MAT_01mmh_1985_2014,3));
AP_01mmh_1985_2014_line = reshape(AP_01mmh_1985_2014,[],size(AP_01mmh_1985_2014,3));
clear MAT_01mmh_1985_2014 AP_01mmh_1985_2014

% 读取气候分区的index
load(['J:\6-硕士毕业论文\1-Data\Climate_zone_index\', 'Four_Climite_zone_index_01_scale.mat'])
Four_climate_zone_index_01_line = reshape(Four_climate_zone_index_01,[1,size(Four_climate_zone_index_01,1)*size(Four_climate_zone_index_01,2)]);
Four_climate_zone_index_01_line = Four_climate_zone_index_01_line';

% 提取气候区的索引
k_HR = find(Four_climate_zone_index_01_line == 1);
k_TR = find(Four_climate_zone_index_01_line == 2);
k_AR = find(Four_climate_zone_index_01_line == 3);
k_TP = find(Four_climate_zone_index_01_line == 4);

% 提取四个气候区的年均温和年降水量
MAT_01mmh_1985_2014_HR = MAT_01mmh_1985_2014_line(k_HR,:);
MAT_01mmh_1985_2014_TR = MAT_01mmh_1985_2014_line(k_TR,:);
MAT_01mmh_1985_2014_AR = MAT_01mmh_1985_2014_line(k_AR,:);
MAT_01mmh_1985_2014_TP = MAT_01mmh_1985_2014_line(k_TP,:);

AP_01mmh_1985_2014_HR = AP_01mmh_1985_2014_line(k_HR,:);
AP_01mmh_1985_2014_TR = AP_01mmh_1985_2014_line(k_TR,:);
AP_01mmh_1985_2014_AR = AP_01mmh_1985_2014_line(k_AR,:);
AP_01mmh_1985_2014_TP = AP_01mmh_1985_2014_line(k_TP,:);

Z = nanmean(MAT_01mmh_1985_2014_HR,1)';
Z1 = nanmean(MAT_01mmh_1985_2014_TR,1)';
Z2 = nanmean(MAT_01mmh_1985_2014_AR,1)';
Z3 = nanmean(MAT_01mmh_1985_2014_TP,1)';
time_period = 1985:2014;

Z4 = nanmean(AP_01mmh_1985_2014_HR,1)';
Z5 = nanmean(AP_01mmh_1985_2014_TR,1)';
Z6 = nanmean(AP_01mmh_1985_2014_AR,1)';
Z7 = nanmean(AP_01mmh_1985_2014_TP,1)';

Timeseries_movmean_group(Z,Z1,Z2,Z3,Z4,Z5,Z6,Z7,time_period,3)

cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\001-01-CMFD-CN051-1985-2014-AP-and-MAT\')
exportgraphics(gcf,['分气候区的区域平均年均温和年降水量时间序列（滑动平均3年）.jpg'])
