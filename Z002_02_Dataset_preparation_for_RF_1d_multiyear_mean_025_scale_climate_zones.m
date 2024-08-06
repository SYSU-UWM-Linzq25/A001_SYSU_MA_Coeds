%% 这个文件仍然是准备随机森林模型的数据
%% 考虑到未来模式，这里可以直接准备CMFD-1d-0.25°的数据
%% 多年平均的数据
%% 时间尺度（基尼系数）-1d
%% 空间尺度-0.25°
%% 数据形式-多年平均值

%% 4个气候区的独立模型
clear;clc;

% 为了加快运算速度，可以根据之前的结果，将中国地区的pixel索引进行利用
filename2 = ['CMFD_1d_pre_025_scale_in_',num2str(2000),'.mat'];
load(['J:\6-硕士毕业论文\1-Data\CMFD\0-from-paper2\1d-025-scale\',filename2])
pre_year = sum(CMFD_025_scale_pre_1d_preprocessing01_year,3)';
clear CMFD_025_scale_pre_1d_preprocessing01_year
mask_China_line = reshape(pre_year,[length(Lon_CN051)*length(Lat_CN051),1]);
k = find(~isnan(mask_China_line));
k1 = find(isnan(mask_China_line));
clear mask_China_line pre_year

%读取气候区的索引，分开气候区
% 读取气候分区的index
load(['J:\6-硕士毕业论文\1-Data\Climate_zone_index\', 'Four_Climite_zone_index_025_scale.mat'])
Four_climate_zone_index_025_line = reshape(Four_climate_zone_index_025,[length(Lon_025)*length(Lat_025),1]);
clear Four_climate_zone_index_025
% 先用中国区域的索引进行缩小
Four_climate_zone_index_025_line_CN = Four_climate_zone_index_025_line(k);
clear Four_climate_zone_index_025_line
k_HR = find(Four_climate_zone_index_025_line_CN == 1);
k_TR = find(Four_climate_zone_index_025_line_CN == 2);
k_AR = find(Four_climate_zone_index_025_line_CN == 3);
k_TP = find(Four_climate_zone_index_025_line_CN == 4);
clear Four_climate_zone_index_025_line_CN

% 升尺度的CMFD-1d-GI-1985-2014-的多年平均
% 读取CMFD整合到0.25°上的经纬度坐标
filename2 = 'CMFD_1d_Gini_025_scale_01mmh_1979_2018_from_Paper2.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\0-from-paper2\',filename2])
Gini_CMFD_1d_025_scale_01mmh_1985_2014 = Gini_CMFD_1d_025_scale_01mmh(:,:,7:end-4);
clear Gini_CMFD_1d_025_scale_01mmh
Gini_CMFD_01mmh_mean = nanmean(Gini_CMFD_1d_025_scale_01mmh_1985_2014,3);
Gini_CMFD_01mmh_mean = Gini_CMFD_01mmh_mean';
clear Gini_CMFD_1d_025_scale_01mmh_1985_2014 

Gini_CMFD_01mmh_mean_line = reshape(Gini_CMFD_01mmh_mean,[size(Gini_CMFD_01mmh_mean,1)*size(Gini_CMFD_01mmh_mean,2),1]);
clear Gini_CMFD_01mmh_mean

% 根据中国地区索引，先缩小
Gini_CMFD_01mmh_mean_line_CN = Gini_CMFD_01mmh_mean_line(k);

% 根据气候区分开提取
Gini_CMFD_01mmh_mean_line_HR = Gini_CMFD_01mmh_mean_line_CN(k_HR);
Gini_CMFD_01mmh_mean_line_TR = Gini_CMFD_01mmh_mean_line_CN(k_TR);
Gini_CMFD_01mmh_mean_line_AR = Gini_CMFD_01mmh_mean_line_CN(k_AR);
Gini_CMFD_01mmh_mean_line_TP = Gini_CMFD_01mmh_mean_line_CN(k_TP);
clear Gini_CMFD_01mmh_mean_line_CN

[xx_CMFD_025,yy_CMFD_025] = meshgrid(Lon_025,Lat_025);
xx_CMFD_025 = xx_CMFD_025';
yy_CMFD_025 = yy_CMFD_025';

% 转为单列
xx_CMFD_025_line = reshape(xx_CMFD_025,[size(xx_CMFD_025,1)*size(xx_CMFD_025,2),1]);
yy_CMFD_025_line = reshape(yy_CMFD_025,[size(yy_CMFD_025,1)*size(yy_CMFD_025,2),1]);
clear xx_CMFD_025 yy_CMFD_025

% 根据中国地区索引，先缩小
xx_CMFD_025_line_CN = xx_CMFD_025_line(k);
yy_CMFD_025_line_CN = yy_CMFD_025_line(k);

% 根据气候区提取
xx_CMFD_025_line_HR = xx_CMFD_025_line_CN(k_HR);
xx_CMFD_025_line_TR = xx_CMFD_025_line_CN(k_TR);
xx_CMFD_025_line_AR = xx_CMFD_025_line_CN(k_AR);
xx_CMFD_025_line_TP = xx_CMFD_025_line_CN(k_TP);
clear xx_CMFD_025_line_CN

yy_CMFD_025_line_HR = yy_CMFD_025_line_CN(k_HR);
yy_CMFD_025_line_TR = yy_CMFD_025_line_CN(k_TR);
yy_CMFD_025_line_AR = yy_CMFD_025_line_CN(k_AR);
yy_CMFD_025_line_TP = yy_CMFD_025_line_CN(k_TP);
clear yy_CMFD_025_line_CN

% 提取年均温数据和年降水量数据
load('J:\6-硕士毕业论文\1-Data\CMFD\5-2-CMFD-025-scale-AP-and-MAT-01mmh\CMFD_3h_MAT_025_scale_in_1985_2014.mat');
load('J:\6-硕士毕业论文\1-Data\CMFD\5-2-CMFD-025-scale-AP-and-MAT-01mmh\CMFD_AP_1d_01mmh_1985_2014.mat');

% 计算多年平均值
MAT_025_scale_1985_2014_mean = nanmean(MAT_3h_1985_2014_025_scale,3)';
AP_025_scale_1985_2014_mean = nanmean(AP_1d_01mmh_1985_2014,3);
clear MAT_3h_1985_2014_025_scale AP_1d_01mmh_1985_2014

% 转为单列
MAT_025_scale_1985_2014_mean_line = reshape(MAT_025_scale_1985_2014_mean,[size(MAT_025_scale_1985_2014_mean,1)*size(MAT_025_scale_1985_2014_mean,2),1]);
AP_025_scale_1985_2014_mean_line = reshape(AP_025_scale_1985_2014_mean,[size(AP_025_scale_1985_2014_mean,1)*size(AP_025_scale_1985_2014_mean,2),1]);
clear MAT_025_scale_1985_2014_mean AP_025_scale_1985_2014_mean

% 根据中国地区索引，先缩小
MAT_025_scale_1985_2014_mean_line_CN = MAT_025_scale_1985_2014_mean_line(k);
AP_025_scale_1985_2014_mean_line_CN = AP_025_scale_1985_2014_mean_line(k);

%根据气候区提取
MAT_025_scale_1985_2014_mean_line_HR = MAT_025_scale_1985_2014_mean_line_CN(k_HR);
MAT_025_scale_1985_2014_mean_line_TR = MAT_025_scale_1985_2014_mean_line_CN(k_TR);
MAT_025_scale_1985_2014_mean_line_AR = MAT_025_scale_1985_2014_mean_line_CN(k_AR);
MAT_025_scale_1985_2014_mean_line_TP = MAT_025_scale_1985_2014_mean_line_CN(k_TP);
clear MAT_025_scale_1985_2014_mean_line_CN

AP_025_scale_1985_2014_mean_line_HR = AP_025_scale_1985_2014_mean_line_CN(k_HR);
AP_025_scale_1985_2014_mean_line_TR = AP_025_scale_1985_2014_mean_line_CN(k_TR);
AP_025_scale_1985_2014_mean_line_AR = AP_025_scale_1985_2014_mean_line_CN(k_AR);
AP_025_scale_1985_2014_mean_line_TP = AP_025_scale_1985_2014_mean_line_CN(k_TP);
clear AP_025_scale_1985_2014_mean_line_CN

% 查找变量中的nan
k_nan_1 = find(isnan(Gini_CMFD_01mmh_mean_line_HR));
k_nan_2 = find(isnan(Gini_CMFD_01mmh_mean_line_TR));
k_nan_3 = find(isnan(Gini_CMFD_01mmh_mean_line_AR));
k_nan_4 = find(isnan(Gini_CMFD_01mmh_mean_line_TP));

k_nan_5 = find(isnan(MAT_025_scale_1985_2014_mean_line_HR));
k_nan_6 = find(isnan(MAT_025_scale_1985_2014_mean_line_TR));
k_nan_7 = find(isnan(MAT_025_scale_1985_2014_mean_line_AR));
k_nan_8 = find(isnan(MAT_025_scale_1985_2014_mean_line_TP));

k_nan_9 = find(isnan(AP_025_scale_1985_2014_mean_line_HR));
k_nan_10 = find(isnan(AP_025_scale_1985_2014_mean_line_TR));
k_nan_11 = find(isnan(AP_025_scale_1985_2014_mean_line_AR));
k_nan_12 = find(isnan(AP_025_scale_1985_2014_mean_line_TP));


%% 整合成一个大的模型
X_Dataset_HR_1d_GI_Multiyera_mean = nan(length(Gini_CMFD_01mmh_mean_line_HR),4);
Y_Dataset_HR_1d_GI_Multiyera_mean = Gini_CMFD_01mmh_mean_line_HR;

X_Dataset_HR_1d_GI_Multiyera_mean(:,1) = xx_CMFD_025_line_HR;
X_Dataset_HR_1d_GI_Multiyera_mean(:,2) = yy_CMFD_025_line_HR;
X_Dataset_HR_1d_GI_Multiyera_mean(:,3) = MAT_025_scale_1985_2014_mean_line_HR;
X_Dataset_HR_1d_GI_Multiyera_mean(:,4) = AP_025_scale_1985_2014_mean_line_HR;

X_Dataset_TR_1d_GI_Multiyera_mean = nan(length(Gini_CMFD_01mmh_mean_line_TR),4);
Y_Dataset_TR_1d_GI_Multiyera_mean = Gini_CMFD_01mmh_mean_line_TR;

X_Dataset_TR_1d_GI_Multiyera_mean(:,1) = xx_CMFD_025_line_TR;
X_Dataset_TR_1d_GI_Multiyera_mean(:,2) = yy_CMFD_025_line_TR;
X_Dataset_TR_1d_GI_Multiyera_mean(:,3) = MAT_025_scale_1985_2014_mean_line_TR;
X_Dataset_TR_1d_GI_Multiyera_mean(:,4) = AP_025_scale_1985_2014_mean_line_TR;

X_Dataset_AR_1d_GI_Multiyera_mean = nan(length(Gini_CMFD_01mmh_mean_line_AR),4);
Y_Dataset_AR_1d_GI_Multiyera_mean = Gini_CMFD_01mmh_mean_line_AR;

X_Dataset_AR_1d_GI_Multiyera_mean(:,1) = xx_CMFD_025_line_AR;
X_Dataset_AR_1d_GI_Multiyera_mean(:,2) = yy_CMFD_025_line_AR;
X_Dataset_AR_1d_GI_Multiyera_mean(:,3) = MAT_025_scale_1985_2014_mean_line_AR;
X_Dataset_AR_1d_GI_Multiyera_mean(:,4) = AP_025_scale_1985_2014_mean_line_AR;

X_Dataset_TP_1d_GI_Multiyera_mean = nan(length(Gini_CMFD_01mmh_mean_line_TP),4);
Y_Dataset_TP_1d_GI_Multiyera_mean = Gini_CMFD_01mmh_mean_line_TP;

X_Dataset_TP_1d_GI_Multiyera_mean(:,1) = xx_CMFD_025_line_TP;
X_Dataset_TP_1d_GI_Multiyera_mean(:,2) = yy_CMFD_025_line_TP;
X_Dataset_TP_1d_GI_Multiyera_mean(:,3) = MAT_025_scale_1985_2014_mean_line_TP;
X_Dataset_TP_1d_GI_Multiyera_mean(:,4) = AP_025_scale_1985_2014_mean_line_TP;


clearvars -except X_Dataset_HR_1d_GI_Multiyera_mean Y_Dataset_HR_1d_GI_Multiyera_mean...
X_Dataset_TR_1d_GI_Multiyera_mean Y_Dataset_TR_1d_GI_Multiyera_mean...
X_Dataset_AR_1d_GI_Multiyera_mean Y_Dataset_AR_1d_GI_Multiyera_mean...
X_Dataset_TP_1d_GI_Multiyera_mean Y_Dataset_TP_1d_GI_Multiyera_mean

%% 从整合的部分进一步分出训练集和测试集
%% HR
% 分出训练集和测试集的规模
Data_all_size = length(Y_Dataset_HR_1d_GI_Multiyera_mean);
Train_size = fix(Data_all_size*0.8);
Test_size = Data_all_size - Train_size;

% 随机-索引
aa = randperm(Data_all_size);
k_index_Train = aa(1:Train_size);
k_index_Test = aa(Train_size+1:end);

% 提取对应的训练集和测试集
Y_Train = Y_Dataset_HR_1d_GI_Multiyera_mean(k_index_Train);
X_Train = X_Dataset_HR_1d_GI_Multiyera_mean(k_index_Train,:);
Y_Test = Y_Dataset_HR_1d_GI_Multiyera_mean(k_index_Test);
X_Test = X_Dataset_HR_1d_GI_Multiyera_mean(k_index_Test,:);

% 由于是随机的，所以每次保存得到的数据并不一样
filename = 'RF_Dataset_for_1d_025_scale_multiyear_mean_GI_HR.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\10-3-Dataset-for-RF-regression-025-scale\multiyear_mean\HR\',filename],...
    'X_Train','X_Test',...
    'Y_Train','Y_Test')


%% TR

clear Data_all_size Train_size Test_size aa k_index_Train k_index_Test Y_Train X_Train Y_Test X_Test
% 分出训练集和测试集的规模
Data_all_size = length(Y_Dataset_TR_1d_GI_Multiyera_mean);
Train_size = fix(Data_all_size*0.8);
Test_size = Data_all_size - Train_size;

% 随机-索引
aa = randperm(Data_all_size);
k_index_Train = aa(1:Train_size);
k_index_Test = aa(Train_size+1:end);

% 提取对应的训练集和测试集
Y_Train = Y_Dataset_TR_1d_GI_Multiyera_mean(k_index_Train);
X_Train = X_Dataset_TR_1d_GI_Multiyera_mean(k_index_Train,:);
Y_Test = Y_Dataset_TR_1d_GI_Multiyera_mean(k_index_Test);
X_Test = X_Dataset_TR_1d_GI_Multiyera_mean(k_index_Test,:);

% 由于是随机的，所以每次保存得到的数据并不一样
filename = 'RF_Dataset_for_1d_025_scale_multiyear_mean_GI_TR.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\10-3-Dataset-for-RF-regression-025-scale\multiyear_mean\TR\',filename],...
    'X_Train','X_Test',...
    'Y_Train','Y_Test')

%% AR

clear Data_all_size Train_size Test_size aa k_index_Train k_index_Test Y_Train X_Train Y_Test X_Test
% 分出训练集和测试集的规模
Data_all_size = length(Y_Dataset_AR_1d_GI_Multiyera_mean);
Train_size = fix(Data_all_size*0.8);
Test_size = Data_all_size - Train_size;

% 随机-索引
aa = randperm(Data_all_size);
k_index_Train = aa(1:Train_size);
k_index_Test = aa(Train_size+1:end);

% 提取对应的训练集和测试集
Y_Train = Y_Dataset_AR_1d_GI_Multiyera_mean(k_index_Train);
X_Train = X_Dataset_AR_1d_GI_Multiyera_mean(k_index_Train,:);
Y_Test = Y_Dataset_AR_1d_GI_Multiyera_mean(k_index_Test);
X_Test = X_Dataset_AR_1d_GI_Multiyera_mean(k_index_Test,:);

% 由于是随机的，所以每次保存得到的数据并不一样
filename = 'RF_Dataset_for_1d_025_scale_multiyear_mean_GI_AR.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\10-3-Dataset-for-RF-regression-025-scale\multiyear_mean\AR\',filename],...
    'X_Train','X_Test',...
    'Y_Train','Y_Test')

%% TP

clear Data_all_size Train_size Test_size aa k_index_Train k_index_Test Y_Train X_Train Y_Test X_Test
% 分出训练集和测试集的规模
Data_all_size = length(Y_Dataset_TP_1d_GI_Multiyera_mean);
Train_size = fix(Data_all_size*0.8);
Test_size = Data_all_size - Train_size;

% 随机-索引
aa = randperm(Data_all_size);
k_index_Train = aa(1:Train_size);
k_index_Test = aa(Train_size+1:end);

% 提取对应的训练集和测试集
Y_Train = Y_Dataset_TP_1d_GI_Multiyera_mean(k_index_Train);
X_Train = X_Dataset_TP_1d_GI_Multiyera_mean(k_index_Train,:);
Y_Test = Y_Dataset_TP_1d_GI_Multiyera_mean(k_index_Test);
X_Test = X_Dataset_TP_1d_GI_Multiyera_mean(k_index_Test,:);

% 由于是随机的，所以每次保存得到的数据并不一样
filename = 'RF_Dataset_for_1d_025_scale_multiyear_mean_GI_TP.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\10-3-Dataset-for-RF-regression-025-scale\multiyear_mean\TP\',filename],...
    'X_Train','X_Test',...
    'Y_Train','Y_Test')

