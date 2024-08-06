%% 准备未来时期不同情景下的数据
%% 重新建立随机森林模型
%% 并计算四个特征的重要性（主要）

clear;clc;

% 读取未来时期不同情景下的年均温和年降水量情况
% 直接读取气候态情况就可以
% 未来两个时期-四个情景
SSP_type = {'ssp126','ssp245','ssp370','ssp585'};
Time_period = {'2031_2060'};

for j = 1 : length(SSP_type)
    for m = 1 : length(Time_period)
        save_peth_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\6-2-future-025-scale-ensemble-climatic-MAT-AP\';
        cd(save_peth_1)
        filename_1 = [SSP_type{j},'_3_Model_ensemble_climatic_MAT_025_scale_CN_',Time_period{m},'.mat'];
        load(filename_1)
        
        eval(['Model_Future_climatic_MAT_',SSP_type{j},'_',Time_period{m},' = Model_MAT_ensemble_climatic_MAT;'])
        clear Model_MAT_ensemble_climatic_MAT
        
        eval(['Model_Future_climatic_MAT_',SSP_type{j},'_',Time_period{m},'_line = reshape(Model_Future_climatic_MAT_',SSP_type{j},'_',Time_period{m},',[size(xx_025,1)*size(xx_025,2),1]);'])
        eval(['clear Model_Future_climatic_MAT_',SSP_type{j},'_',Time_period{m},';']) 
    end
end

% 年降水量气候态情况
for j = 1 : length(SSP_type)
    for m = 1 : length(Time_period)
        save_peth_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\6-2-future-025-scale-ensemble-climatic-MAT-AP\';
        cd(save_peth_1)
        filename_1 = [SSP_type{j},'_3_Model_ensemble_climatic_AP_025_scale_CN_',Time_period{m},'.mat'];
        load(filename_1)
        
        eval(['Model_Future_climatic_AP_',SSP_type{j},'_',Time_period{m},' = Model_AP_ensemble_climatic_AP;'])
        clear Model_AP_ensemble_climatic_AP
        
        eval(['Model_Future_climatic_AP_',SSP_type{j},'_',Time_period{m},'_line = reshape(Model_Future_climatic_AP_',SSP_type{j},'_',Time_period{m},',[size(xx_025,1)*size(xx_025,2),1]);'])
        eval(['clear Model_Future_climatic_AP_',SSP_type{j},'_',Time_period{m},';']) 
    end
end

% 读取校正的矩阵
load('J:\6-硕士毕业论文\1-Data\Correcttion_matrix_for_CMIP6_future\Correction_matrix_from_His_for_future.mat')

% 基尼系数
for j = 1 : length(SSP_type)
    for m = 1 : length(Time_period)
        save_peth_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\7-3-future-025-scale-ensemble-climatic-GI\';
        cd(save_peth_1)
        filename_1 = [SSP_type{j},'_3_Model_ensemble_climatic_GI_025_scale_CN_',Time_period{m},'.mat'];
        load(filename_1)
        
        % 加上校正
        Model_GI_ensemble_climatic_GI = Model_GI_ensemble_climatic_GI + Correction_matrix_for_CMIP6_GI;
        
        eval(['Model_Future_climatic_GI_',SSP_type{j},'_',Time_period{m},'_line = reshape(Model_GI_ensemble_climatic_GI,[size(xx_025,1)*size(xx_025,2),1]);'])
        clear Model_GI_ensemble_climatic_GI
    end
end

% 经纬度转列
xx_025_line_ssp126 = reshape(xx_025,[size(xx_025,1)*size(xx_025,2),1]);
yy_025_line_ssp126 = reshape(yy_025,[size(yy_025,1)*size(yy_025,2),1]);
xx_025_line_ssp245 = reshape(xx_025,[size(xx_025,1)*size(xx_025,2),1]);
yy_025_line_ssp245 = reshape(yy_025,[size(yy_025,1)*size(yy_025,2),1]);
xx_025_line_ssp370 = reshape(xx_025,[size(xx_025,1)*size(xx_025,2),1]);
yy_025_line_ssp370 = reshape(yy_025,[size(yy_025,1)*size(yy_025,2),1]);
xx_025_line_ssp585 = reshape(xx_025,[size(xx_025,1)*size(xx_025,2),1]);
yy_025_line_ssp585 = reshape(yy_025,[size(yy_025,1)*size(yy_025,2),1]);

% % 查找变量中的nan
for j = 1 : length(SSP_type)
    eval(['k_nan_',num2str(j),'_1 = find(isnan(Model_Future_climatic_MAT_',SSP_type{j},'_2031_2060_line));'])
    eval(['k_nan_',num2str(j),'_2 = find(isnan(Model_Future_climatic_AP_',SSP_type{j},'_2031_2060_line));'])
    eval(['k_nan_',num2str(j),'_3 = find(isnan(Model_Future_climatic_GI_',SSP_type{j},'_2031_2060_line));'])
end

k_nan_1 = unique([k_nan_1_1;k_nan_1_2;k_nan_1_3]);
k_nan_2 = unique([k_nan_2_1;k_nan_2_2;k_nan_2_3]);
k_nan_3 = unique([k_nan_3_1;k_nan_3_2;k_nan_3_3]);
k_nan_4 = unique([k_nan_4_1;k_nan_4_2;k_nan_4_3]);


% % 查找变量中的nan
for j = 1 : length(SSP_type)
    eval(['Model_Future_climatic_MAT_',SSP_type{j},'_2031_2060_line(k_nan_',num2str(j),') = [];'])
    eval(['Model_Future_climatic_AP_',SSP_type{j},'_2031_2060_line(k_nan_',num2str(j),') = [];'])
    eval(['Model_Future_climatic_GI_',SSP_type{j},'_2031_2060_line(k_nan_',num2str(j),') = [];'])
    eval(['xx_025_line_',SSP_type{j},'(k_nan_',num2str(j),') = [];'])
    eval(['yy_025_line_',SSP_type{j},'(k_nan_',num2str(j),') = [];'])
end


% 整合成一个大的模型
for j = 1 : length(SSP_type)

eval(['X_Dataset_CN_1d_GI_Multiyera_mean_',SSP_type{j},' = nan(length(xx_025_line_',SSP_type{j},'),4);'])
eval(['Y_Dataset_CN_1d_GI_Multiyera_mean_',SSP_type{j},' = Model_Future_climatic_GI_',SSP_type{j},'_2031_2060_line;'])

eval(['X_Dataset_CN_1d_GI_Multiyera_mean_',SSP_type{j},'(:,1) = xx_025_line_',SSP_type{j},';'])
eval(['X_Dataset_CN_1d_GI_Multiyera_mean_',SSP_type{j},'(:,2) = yy_025_line_',SSP_type{j},';'])
eval(['X_Dataset_CN_1d_GI_Multiyera_mean_',SSP_type{j},'(:,3) = Model_Future_climatic_MAT_',SSP_type{j},'_2031_2060_line;'])
eval(['X_Dataset_CN_1d_GI_Multiyera_mean_',SSP_type{j},'(:,4) = Model_Future_climatic_AP_',SSP_type{j},'_2031_2060_line;'])
end

clearvars -except X_Dataset_CN_1d_GI_Multiyera_mean_ssp126 X_Dataset_CN_1d_GI_Multiyera_mean_ssp245...
    X_Dataset_CN_1d_GI_Multiyera_mean_ssp370 X_Dataset_CN_1d_GI_Multiyera_mean_ssp585...
    Y_Dataset_CN_1d_GI_Multiyera_mean_ssp126 Y_Dataset_CN_1d_GI_Multiyera_mean_ssp245...
    Y_Dataset_CN_1d_GI_Multiyera_mean_ssp370 Y_Dataset_CN_1d_GI_Multiyera_mean_ssp585

%% 从整合的部分进一步分出训练集和测试集

%% SSP126
% 分出训练集和测试集的规模
Data_all_size = length(Y_Dataset_CN_1d_GI_Multiyera_mean_ssp126);
Train_size = fix(Data_all_size*0.8);
Test_size = Data_all_size - Train_size;

% 随机-索引
aa = randperm(Data_all_size);
k_index_Train = aa(1:Train_size);
k_index_Test = aa(Train_size+1:end);

% 提取对应的训练集和测试集
Y_Train = Y_Dataset_CN_1d_GI_Multiyera_mean_ssp126(k_index_Train);
X_Train = X_Dataset_CN_1d_GI_Multiyera_mean_ssp126(k_index_Train,:);
Y_Test = Y_Dataset_CN_1d_GI_Multiyera_mean_ssp126(k_index_Test);
X_Test = X_Dataset_CN_1d_GI_Multiyera_mean_ssp126(k_index_Test,:);

% 由于是随机的，所以每次保存得到的数据并不一样
filename = 'CMIP6_future_SSP126_RF_Dataset_for_1d_025_scale_multiyear_mean_GI_CN.mat';
save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\10-2-Dataset-for-RF-regression-025-scale\',filename],...
    'X_Train','X_Test',...
    'Y_Train','Y_Test')


%% SSP245
clearvars -except X_Dataset_CN_1d_GI_Multiyera_mean_ssp245...
    X_Dataset_CN_1d_GI_Multiyera_mean_ssp370 X_Dataset_CN_1d_GI_Multiyera_mean_ssp585...
    Y_Dataset_CN_1d_GI_Multiyera_mean_ssp245...
    Y_Dataset_CN_1d_GI_Multiyera_mean_ssp370 Y_Dataset_CN_1d_GI_Multiyera_mean_ssp585

% 分出训练集和测试集的规模
Data_all_size = length(Y_Dataset_CN_1d_GI_Multiyera_mean_ssp245);
Train_size = fix(Data_all_size*0.8);
Test_size = Data_all_size - Train_size;

% 随机-索引
aa = randperm(Data_all_size);
k_index_Train = aa(1:Train_size);
k_index_Test = aa(Train_size+1:end);

% 提取对应的训练集和测试集
Y_Train = Y_Dataset_CN_1d_GI_Multiyera_mean_ssp245(k_index_Train);
X_Train = X_Dataset_CN_1d_GI_Multiyera_mean_ssp245(k_index_Train,:);
Y_Test = Y_Dataset_CN_1d_GI_Multiyera_mean_ssp245(k_index_Test);
X_Test = X_Dataset_CN_1d_GI_Multiyera_mean_ssp245(k_index_Test,:);

% 由于是随机的，所以每次保存得到的数据并不一样
filename = 'CMIP6_future_SSP245_RF_Dataset_for_1d_025_scale_multiyear_mean_GI_CN.mat';
save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\10-2-Dataset-for-RF-regression-025-scale\',filename],...
    'X_Train','X_Test',...
    'Y_Train','Y_Test')

%% SSP370
clearvars -except X_Dataset_CN_1d_GI_Multiyera_mean_ssp370 X_Dataset_CN_1d_GI_Multiyera_mean_ssp585...
    Y_Dataset_CN_1d_GI_Multiyera_mean_ssp370 Y_Dataset_CN_1d_GI_Multiyera_mean_ssp585


% 分出训练集和测试集的规模
Data_all_size = length(Y_Dataset_CN_1d_GI_Multiyera_mean_ssp370);
Train_size = fix(Data_all_size*0.8);
Test_size = Data_all_size - Train_size;

% 随机-索引
aa = randperm(Data_all_size);
k_index_Train = aa(1:Train_size);
k_index_Test = aa(Train_size+1:end);

% 提取对应的训练集和测试集
Y_Train = Y_Dataset_CN_1d_GI_Multiyera_mean_ssp370(k_index_Train);
X_Train = X_Dataset_CN_1d_GI_Multiyera_mean_ssp370(k_index_Train,:);
Y_Test = Y_Dataset_CN_1d_GI_Multiyera_mean_ssp370(k_index_Test);
X_Test = X_Dataset_CN_1d_GI_Multiyera_mean_ssp370(k_index_Test,:);

% 由于是随机的，所以每次保存得到的数据并不一样
filename = 'CMIP6_future_SSP370_RF_Dataset_for_1d_025_scale_multiyear_mean_GI_CN.mat';
save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\10-2-Dataset-for-RF-regression-025-scale\',filename],...
    'X_Train','X_Test',...
    'Y_Train','Y_Test')

%% SSP585
clearvars -except X_Dataset_CN_1d_GI_Multiyera_mean_ssp585...
    Y_Dataset_CN_1d_GI_Multiyera_mean_ssp585


% 分出训练集和测试集的规模
Data_all_size = length(Y_Dataset_CN_1d_GI_Multiyera_mean_ssp585);
Train_size = fix(Data_all_size*0.8);
Test_size = Data_all_size - Train_size;

% 随机-索引
aa = randperm(Data_all_size);
k_index_Train = aa(1:Train_size);
k_index_Test = aa(Train_size+1:end);

% 提取对应的训练集和测试集
Y_Train = Y_Dataset_CN_1d_GI_Multiyera_mean_ssp585(k_index_Train);
X_Train = X_Dataset_CN_1d_GI_Multiyera_mean_ssp585(k_index_Train,:);
Y_Test = Y_Dataset_CN_1d_GI_Multiyera_mean_ssp585(k_index_Test);
X_Test = X_Dataset_CN_1d_GI_Multiyera_mean_ssp585(k_index_Test,:);

% 由于是随机的，所以每次保存得到的数据并不一样
filename = 'CMIP6_future_SSP585_RF_Dataset_for_1d_025_scale_multiyear_mean_GI_CN.mat';
save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\10-2-Dataset-for-RF-regression-025-scale\',filename],...
    'X_Train','X_Test',...
    'Y_Train','Y_Test')
