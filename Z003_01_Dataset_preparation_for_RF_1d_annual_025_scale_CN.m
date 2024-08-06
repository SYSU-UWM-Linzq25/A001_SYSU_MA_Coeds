%% 这个文件仍然是准备随机森林模型的数据
%% 考虑到未来模式，这里可以直接准备CMFD-1d-0.25°的数据
%% 逐年的数据
%% 时间尺度（基尼系数）-1d
%% 空间尺度-0.25°
%% 要分单双年

%% 先是全国的大模型
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

% 升尺度的CMFD-1d-GI-1985-2014-的多年平均
% 读取CMFD整合到0.25°上的经纬度坐标
filename2 = 'CMFD_1d_Gini_025_scale_01mmh_1979_2018_from_Paper2.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\0-from-paper2\',filename2])
Gini_CMFD_1d_025_scale_01mmh_1985_2014 = Gini_CMFD_1d_025_scale_01mmh(:,:,7:end-4);
clear Gini_CMFD_1d_025_scale_01mmh
Gini_CMFD_1d_025_scale_01mmh_1985_2014_rev = nan(length(Lon_025),length(Lat_025),size(Gini_CMFD_1d_025_scale_01mmh_1985_2014,3));
% 矩阵格式转置
for i = 1 : size(Gini_CMFD_1d_025_scale_01mmh_1985_2014,3)
    Gini_CMFD_1d_025_year = Gini_CMFD_1d_025_scale_01mmh_1985_2014(:,:,i);
    Gini_CMFD_1d_025_scale_01mmh_1985_2014_rev(:,:,i) = Gini_CMFD_1d_025_year';
    clear Gini_CMFD_1d_025_year
end
clear Gini_CMFD_1d_025_scale_01mmh_1985_2014

% 从3维降低到2维
Gini_1d_CMFD_01mmh_mean_line = reshape(Gini_CMFD_1d_025_scale_01mmh_1985_2014_rev,[],size(Gini_CMFD_1d_025_scale_01mmh_1985_2014_rev,3));
clear Gini_CMFD_1d_025_scale_01mmh_1985_2014_rev

% 根据中国地区索引，先缩小
Gini_1d_CMFD_01mmh_mean_line_CN = Gini_1d_CMFD_01mmh_mean_line(k,:);
clear Gini_1d_CMFD_01mmh_mean_line

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
clear xx_CMFD_025_line yy_CMFD_025_line

% 因为要对应15年，所以这里要重复复制
xx_CMFD_025_line_CN_15a = nan(length(xx_CMFD_025_line_CN),15);
yy_CMFD_025_line_CN_15a = nan(length(yy_CMFD_025_line_CN),15);
clear i 
for i = 1 : size(yy_CMFD_025_line_CN_15a,2)
    xx_CMFD_025_line_CN_15a(:,i) = xx_CMFD_025_line_CN;
    yy_CMFD_025_line_CN_15a(:,i) = yy_CMFD_025_line_CN;
end
clear xx_CMFD_025_line_CN yy_CMFD_025_line_CN
xx_CMFD_025_15a_line = reshape(xx_CMFD_025_line_CN_15a,[size(xx_CMFD_025_line_CN_15a,1)*size(xx_CMFD_025_line_CN_15a,2),1]);
yy_CMFD_025_15a_line = reshape(yy_CMFD_025_line_CN_15a,[size(yy_CMFD_025_line_CN_15a,1)*size(yy_CMFD_025_line_CN_15a,2),1]);
clear xx_CMFD_025_line_CN_15a yy_CMFD_025_line_CN_15a 

% 分单双年
xx_CMFD_025_line_CN_1 = xx_CMFD_025_15a_line;
xx_CMFD_025_line_CN_2 = xx_CMFD_025_15a_line;
yy_CMFD_025_line_CN_1 = yy_CMFD_025_15a_line;
yy_CMFD_025_line_CN_2 = yy_CMFD_025_15a_line;
clear xx_CMFD_025_15a_line yy_CMFD_025_15a_line 

% 提取年均温数据和年降水量数据
load('J:\6-硕士毕业论文\1-Data\CMFD\5-2-CMFD-025-scale-AP-and-MAT-01mmh\CMFD_3h_MAT_025_scale_in_1985_2014.mat');
load('J:\6-硕士毕业论文\1-Data\CMFD\5-2-CMFD-025-scale-AP-and-MAT-01mmh\CMFD_AP_1d_01mmh_1985_2014.mat');

% MAT要转数据格式
clear i
MAT_3h_1985_2014_025_scale_rev = nan(length(Lon_025),length(Lat_025),size(MAT_3h_1985_2014_025_scale,3));
for i = 1 : size(MAT_3h_1985_2014_025_scale,3)
    MAT_year = MAT_3h_1985_2014_025_scale(:,:,i);
    MAT_3h_1985_2014_025_scale_rev(:,:,i) = MAT_year';
    clear MAT_year
end
clear MAT_3h_1985_2014_025_scale

% 从3维转2维
MAT_025_scale_1985_2014_line = reshape(MAT_3h_1985_2014_025_scale_rev,[],size(MAT_3h_1985_2014_025_scale_rev,3));
AP_025_scale_1985_2014_line = reshape(AP_1d_01mmh_1985_2014,[],size(AP_1d_01mmh_1985_2014,3));
clear MAT_3h_1985_2014_025_scale_rev AP_1d_01mmh_1985_2014

% 根据中国地区索引，先缩小
MAT_025_scale_1985_2014_mean_line_CN = MAT_025_scale_1985_2014_line(k,:);
AP_025_scale_1985_2014_mean_line_CN = AP_025_scale_1985_2014_line(k,:);
clear MAT_025_scale_1985_2014_line AP_025_scale_1985_2014_line

% 划分单双年
Year_index_1 = 1:2:30; % 单年
Year_index_2 = 2:2:30; % 双年

Gini_1d_CMFD_01mmh_mean_line_CN_1 = Gini_1d_CMFD_01mmh_mean_line_CN(:,Year_index_1);
Gini_1d_CMFD_01mmh_mean_line_CN_2 = Gini_1d_CMFD_01mmh_mean_line_CN(:,Year_index_2);
clear Gini_1d_CMFD_01mmh_mean_line_CN
MAT_025_scale_1985_2014_mean_line_CN_1 = MAT_025_scale_1985_2014_mean_line_CN(:,Year_index_1);
MAT_025_scale_1985_2014_mean_line_CN_2 = MAT_025_scale_1985_2014_mean_line_CN(:,Year_index_2);
clear MAT_025_scale_1985_2014_mean_line_CN
AP_025_scale_1985_2014_mean_line_CN_1 = AP_025_scale_1985_2014_mean_line_CN(:,Year_index_1);
AP_025_scale_1985_2014_mean_line_CN_2 = AP_025_scale_1985_2014_mean_line_CN(:,Year_index_2);
clear AP_025_scale_1985_2014_mean_line_CN

% 转为单列
Gini_1d_CMFD_01mmh_mean_line_CN_1_line = reshape(Gini_1d_CMFD_01mmh_mean_line_CN_1,[size(Gini_1d_CMFD_01mmh_mean_line_CN_1,1)*size(Gini_1d_CMFD_01mmh_mean_line_CN_1,2),1]);
Gini_1d_CMFD_01mmh_mean_line_CN_2_line = reshape(Gini_1d_CMFD_01mmh_mean_line_CN_2,[size(Gini_1d_CMFD_01mmh_mean_line_CN_2,1)*size(Gini_1d_CMFD_01mmh_mean_line_CN_2,2),1]);
MAT_025_scale_1985_2014_mean_line_CN_1_line = reshape(MAT_025_scale_1985_2014_mean_line_CN_1,[size(MAT_025_scale_1985_2014_mean_line_CN_1,1)*size(MAT_025_scale_1985_2014_mean_line_CN_1,2),1]);
MAT_025_scale_1985_2014_mean_line_CN_2_line = reshape(MAT_025_scale_1985_2014_mean_line_CN_2,[size(MAT_025_scale_1985_2014_mean_line_CN_2,1)*size(MAT_025_scale_1985_2014_mean_line_CN_2,2),1]);
AP_025_scale_1985_2014_mean_line_CN_1_line = reshape(AP_025_scale_1985_2014_mean_line_CN_1,[size(AP_025_scale_1985_2014_mean_line_CN_1,1)*size(AP_025_scale_1985_2014_mean_line_CN_1,2),1]);
AP_025_scale_1985_2014_mean_line_CN_2_line = reshape(AP_025_scale_1985_2014_mean_line_CN_2,[size(AP_025_scale_1985_2014_mean_line_CN_2,1)*size(AP_025_scale_1985_2014_mean_line_CN_2,2),1]);
clear Gini_1d_CMFD_01mmh_mean_line_CN_1 Gini_1d_CMFD_01mmh_mean_line_CN_2 MAT_025_scale_1985_2014_mean_line_CN_1 MAT_025_scale_1985_2014_mean_line_CN_2
clear AP_025_scale_1985_2014_mean_line_CN_1 AP_025_scale_1985_2014_mean_line_CN_2
 

% 查找去除nan
% 查找变量中的nan
k_nan_1 = find(isnan(Gini_1d_CMFD_01mmh_mean_line_CN_1_line));
k_nan_2 = find(isnan(Gini_1d_CMFD_01mmh_mean_line_CN_2_line));
k_nan_3 = find(isnan(MAT_025_scale_1985_2014_mean_line_CN_1_line));
k_nan_4 = find(isnan(MAT_025_scale_1985_2014_mean_line_CN_2_line));
k_nan_5 = find(isnan(AP_025_scale_1985_2014_mean_line_CN_1_line));
k_nan_6 = find(isnan(AP_025_scale_1985_2014_mean_line_CN_2_line));

% 去除nan
Gini_1d_CMFD_01mmh_mean_line_CN_1_line(k_nan_1) = [];
MAT_025_scale_1985_2014_mean_line_CN_1_line(k_nan_1) = [];
AP_025_scale_1985_2014_mean_line_CN_1_line(k_nan_1) = [];
yy_CMFD_025_line_CN_1(k_nan_1) = [];
xx_CMFD_025_line_CN_1(k_nan_1) = [];



Gini_1d_CMFD_01mmh_mean_line_CN_2_line(k_nan_2) = [];
MAT_025_scale_1985_2014_mean_line_CN_2_line(k_nan_2) = [];
AP_025_scale_1985_2014_mean_line_CN_2_line(k_nan_2) = [];
yy_CMFD_025_line_CN_2(k_nan_2) = [];
xx_CMFD_025_line_CN_2(k_nan_2) = [];

% 整合成单双年分开
X_Dataset_CN_1d_GI_1 = nan(length(Gini_1d_CMFD_01mmh_mean_line_CN_1_line),4);
Y_Dataset_CN_1d_GI_1 = Gini_1d_CMFD_01mmh_mean_line_CN_1_line;

X_Dataset_CN_1d_GI_1(:,1) = xx_CMFD_025_line_CN_1;
X_Dataset_CN_1d_GI_1(:,2) = yy_CMFD_025_line_CN_1;
X_Dataset_CN_1d_GI_1(:,3) = MAT_025_scale_1985_2014_mean_line_CN_1_line;
X_Dataset_CN_1d_GI_1(:,4) = AP_025_scale_1985_2014_mean_line_CN_1_line;

X_Dataset_CN_1d_GI_2 = nan(length(Gini_1d_CMFD_01mmh_mean_line_CN_2_line),4);
Y_Dataset_CN_1d_GI_2 = Gini_1d_CMFD_01mmh_mean_line_CN_2_line;

X_Dataset_CN_1d_GI_2(:,1) = xx_CMFD_025_line_CN_2;
X_Dataset_CN_1d_GI_2(:,2) = yy_CMFD_025_line_CN_2;
X_Dataset_CN_1d_GI_2(:,3) = MAT_025_scale_1985_2014_mean_line_CN_2_line;
X_Dataset_CN_1d_GI_2(:,4) = AP_025_scale_1985_2014_mean_line_CN_2_line;

%% 从整合的部分进一步分出训练集和测试集
%% 单年
% 分出训练集和测试集的规模
Data_all_size_1 = length(Gini_1d_CMFD_01mmh_mean_line_CN_1_line);
Train_size_1 = fix(Data_all_size_1*0.8);
Test_size_1 = Data_all_size_1 - Train_size_1;

% 随机-索引
aa_1 = randperm(Data_all_size_1);
k_index_Train_1 = aa_1(1:Train_size_1);
k_index_Test_1 = aa_1(Train_size_1+1:end);

% 提取对应的训练集和测试集
Y_Train_1 = Y_Dataset_CN_1d_GI_1(k_index_Train_1);
X_Train_1 = X_Dataset_CN_1d_GI_1(k_index_Train_1,:);
Y_Test_1 = Y_Dataset_CN_1d_GI_1(k_index_Test_1);
X_Test_1 = X_Dataset_CN_1d_GI_1(k_index_Test_1,:);

% 双年
% 分出训练集和测试集的规模
Data_all_size_2 = length(Gini_1d_CMFD_01mmh_mean_line_CN_2_line);
Train_size_2 = fix(Data_all_size_2*0.8);
Test_size_2 = Data_all_size_2 - Train_size_2;

% 随机-索引
aa_2 = randperm(Data_all_size_2);
k_index_Train_2 = aa_2(1:Train_size_2);
k_index_Test_2 = aa_2(Train_size_2+1:end);

% 提取对应的训练集和测试集
Y_Train_2 = Y_Dataset_CN_1d_GI_2(k_index_Train_2);
X_Train_2 = X_Dataset_CN_1d_GI_2(k_index_Train_2,:);
Y_Test_2 = Y_Dataset_CN_1d_GI_2(k_index_Test_2);
X_Test_2 = X_Dataset_CN_1d_GI_2(k_index_Test_2,:);

%% 整合成一整个

X_Train = [X_Train_1;X_Train_2];
Y_Train = [Y_Train_1;Y_Train_2];
X_Test = [X_Test_1;X_Test_2];
Y_Test = [Y_Test_1;Y_Test_2];


% 由于是随机的，所以每次保存得到的数据并不一样
filename = 'RF_Dataset_for_1d_025_scale_GI_annual_CN_test2.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\10-3-Dataset-for-RF-regression-025-scale\annual\',filename],...
    'X_Train','X_Test',...
    'Y_Train','Y_Test')
