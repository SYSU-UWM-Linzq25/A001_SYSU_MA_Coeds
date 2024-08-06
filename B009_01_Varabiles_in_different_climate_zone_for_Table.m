%% 基于CMFD数据，统计四个气候区下的水热条件，降水集中度和其Sen趋势
%% 空间尺度都是0.1°，没有升尺度

clear;clc;

% 读取CMFD计算得到的MAT和年降水量，用基于3h尺度数据得到的
cd('J:\6-硕士毕业论文\1-Data\CMFD\5-1-CMFD-01-scale-AP-and-MAT-01mmh\')
load('MAT_3h_01mmh_1979_2018.mat')
load('AP_3h_01mmh_1979_2018.mat')

% 读取1985-2014年的数据
MAT_01mmh_1985_2014 = MAT_3h(:,:,7:end-4);
clear MAT_3h
AP_01mmh_1985_2014 = Annual_Pr_3h_01mmh(:,:,7:end-4);
clear Annual_Pr_3h_01mmh

% 计算多年平均
MAT_01mmh_1985_2014_mean = nanmean(MAT_01mmh_1985_2014,3);
AP_01mmh_1985_2014_mean = nanmean(AP_01mmh_1985_2014,3);
clear MAT_01mmh_1985_2014 AP_01mmh_1985_2014

% 读取四种时间尺度的基尼系数
% 3h
filename2 = 'CMFD_3h_Gini_1979_2018_01mmh.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\3-1-Gini&LinearTrend\',filename2])
% 统一选取年份范围为1985-2014
Gini_CMFD_3h_1985_2014 = Gini_CMFD_3h(:,:,7:end-4);
Gini_CMFD_3h_1985_2014_mean = nanmean(Gini_CMFD_3h_1985_2014,3);
clear Gini_CMFD_3h Gini_CMFD_3h_1985_2014

% 6h
path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')
clear filename2
filename2 = 'Full Gini index 6h.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\0-from-paper2\6h\full Gini\',filename2])
% 统一选取年份范围为1985-2014
Gini_CMFD_6h_1985_2014 = Full_Gini_6h_all(:,:,7:end-4);
Gini_CMFD_6h_1985_2014_mean = nanmean(Gini_CMFD_6h_1985_2014,3);
clear Full_Gini_6h_all Gini_CMFD_6h_1985_2014

% 12h
path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')
clear filename2
filename2 = 'Full Gini index 12h.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\0-from-paper2\12h\full Gini\',filename2])
% 统一选取年份范围为1985-2014
Gini_CMFD_12h_1985_2014 = Full_Gini_12h_all(:,:,7:end-4);
Gini_CMFD_12h_1985_2014_mean = nanmean(Gini_CMFD_12h_1985_2014,3);
clear Full_Gini_12h_all Gini_CMFD_12h_1985_2014

% 1d
clear filename2
filename2 = 'Full Gini index 1d.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\0-from-paper2\1d\full Gini\',filename2])
% 统一选取年份范围为1985-2014
Gini_CMFD_1d_1985_2014 = Full_Gini_1d_all(:,:,7:end-4);
Gini_CMFD_1d_1985_2014_mean = nanmean(Gini_CMFD_1d_1985_2014,3);
clear Gini_CMFD_1d Gini_CMFD_1d_1985_2014


% 读取四种时间尺度基尼系数的趋势
% 3-hour
filename2 = 'CMFD_3h_Gini_MK_Sen_1985_2014_01mmh.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\3-2-Sen-Trend\',filename2]);
% 6-hour
clear filename2
filename2 = 'CMFD_6h_Gini_MK_Sen_1985_2014_01mmh.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\3-2-Sen-Trend\',filename2]);
% 12-hour
clear filename2
filename2 = 'CMFD_12h_Gini_MK_Sen_1985_2014_01mmh.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\3-2-Sen-Trend\',filename2]);
% 1-day
clear filename2
filename2 = 'CMFD_1d_Gini_MK_Sen_1985_2014_01mmh.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\3-2-Sen-Trend\',filename2]);


%% 读取气候区的指引，分气候区进行统计

% 读取气候分区的index
load(['J:\6-硕士毕业论文\1-Data\Climate_zone_index\', 'Four_Climite_zone_index_01_scale.mat'])
% 提取气候区的索引
k_HR = find(Four_climate_zone_index_01 == 1);
k_TR = find(Four_climate_zone_index_01 == 2);
k_AR = find(Four_climate_zone_index_01 == 3);
k_TP = find(Four_climate_zone_index_01 == 4);

Temporal_scale_name = {'3h','6h','12h','1d'};
climate_zone_name = {'HR','TR','AR','TP'};

GI_Areamean = nan(4,4);
GI_Sen_slope_Areamean = nan(4,4);
MAT_01mmh_Areamean = nan(1,4); % 没有时间尺度的差别
AP_01mmh_Areamean = nan(1,4); % 没有时间尺度的差别
Percentage_significant_all = nan(4,4);

for i = 1 : length(climate_zone_name)
    for j = 1 : length(Temporal_scale_name)
    % GI分气候区
    eval(['GI_Areamean(j,i) = nanmean(Gini_CMFD_',Temporal_scale_name{j},'_1985_2014_mean(k_',climate_zone_name{i},'));'])
   
    % MAT和AP分气候区
    eval(['MAT_01mmh_Areamean(1,i) = nanmean(MAT_01mmh_1985_2014_mean(k_',climate_zone_name{i},'));'])
    eval(['AP_01mmh_Areamean(1,i) = nanmean(AP_01mmh_1985_2014_mean(k_',climate_zone_name{i},'));'])
    
    % GI的Sen斜率分气候区
    eval(['GI_Sen_slope_Areamean(j,i) = nanmean(Gini_Sen_slope_',Temporal_scale_name{j},'(k_',climate_zone_name{i},'));'])

    % GI MK趋势的分气候区(没有求区域平均)
    eval(['GI_',Temporal_scale_name{j},'_MK_',climate_zone_name{i},' = Gini_MK_',Temporal_scale_name{j},'(k_',climate_zone_name{i},');'])
    
    % 查找气候区内有趋势的网格数量
    eval(['kk_',Temporal_scale_name{j},'_',climate_zone_name{i},' = find(~isnan(GI_',Temporal_scale_name{j},'_MK_',climate_zone_name{i},'));'])

    % 查找气候区内显著趋势的网格数量
    eval(['kkk_',Temporal_scale_name{j},'_',climate_zone_name{i},' = find(abs(GI_',Temporal_scale_name{j},'_MK_',climate_zone_name{i},')>= 1.96 );'])

    % 计算显著趋势在四个气候区的占比
    eval(['Percentage_significant_all(j,i) = length(kkk_',Temporal_scale_name{j},'_',climate_zone_name{i},') /length(kk_',Temporal_scale_name{j},'_',climate_zone_name{i},') * 100;'])

    end
end

filename2 = 'His_CMFD_MAT_AP_GI_and_SenTrend_and_Trend_significant_climate_zone_Table_Data.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\8-1-Dataset-for-Table\',filename2],...
    'GI_Areamean','GI_Sen_slope_Areamean','MAT_01mmh_Areamean','AP_01mmh_Areamean',...
    'Percentage_significant_all','Lon','Lat')

