%% 这个文件开始尝试建立随机森林回归模型
%% 使用的是时间分辨率为1d
%% 空间分辨率为0.25°
%% 多年平均值
%% 全国一整个模型
%% CMIP6四个情景下分别的模型

%% SSP126
clear;clc;
cd('J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\10-2-Dataset-for-RF-regression-025-scale\')
load('CMIP6_future_SSP126_RF_Dataset_for_1d_025_scale_multiyear_mean_GI_CN.mat')

path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\RamdomForest-master\RamdomForest-master\')

clear extra_options
extra_options.importance = 1; %(0 = (Default) Don't, 1=calculate)
model_ssp126 = regRF_train(X_Train,Y_Train, 200, 4, extra_options);

filename2 = 'RF_model_CN_1d_025_scale_multiyear_mean_CMIP6_SSP126.mat';
save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\10-3-RF-models-025-scale-CMIP6-2031-2060\',filename2], 'model_ssp126')

%% SSP245
clear;clc;
cd('J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\10-2-Dataset-for-RF-regression-025-scale\')
load('CMIP6_future_SSP245_RF_Dataset_for_1d_025_scale_multiyear_mean_GI_CN.mat')

path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\RamdomForest-master\RamdomForest-master\')

clear extra_options
extra_options.importance = 1; %(0 = (Default) Don't, 1=calculate)
model_ssp245 = regRF_train(X_Train,Y_Train, 200, 4, extra_options);

filename2 = 'RF_model_CN_1d_025_scale_multiyear_mean_CMIP6_SSP245.mat';
save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\10-3-RF-models-025-scale-CMIP6-2031-2060\',filename2], 'model_ssp245')

%% SSP370
clear;clc;
cd('J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\10-2-Dataset-for-RF-regression-025-scale\')
load('CMIP6_future_SSP370_RF_Dataset_for_1d_025_scale_multiyear_mean_GI_CN.mat')

path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\RamdomForest-master\RamdomForest-master\')

clear extra_options
extra_options.importance = 1; %(0 = (Default) Don't, 1=calculate)
model_ssp370 = regRF_train(X_Train,Y_Train, 200, 4, extra_options);

filename2 = 'RF_model_CN_1d_025_scale_multiyear_mean_CMIP6_SSP370.mat';
save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\10-3-RF-models-025-scale-CMIP6-2031-2060\',filename2], 'model_ssp370')

%% SSP585
clear;clc;
cd('J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\10-2-Dataset-for-RF-regression-025-scale\')
load('CMIP6_future_SSP585_RF_Dataset_for_1d_025_scale_multiyear_mean_GI_CN.mat')

path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\RamdomForest-master\RamdomForest-master\')

clear extra_options
extra_options.importance = 1; %(0 = (Default) Don't, 1=calculate)
model_ssp585 = regRF_train(X_Train,Y_Train, 200, 4, extra_options);

filename2 = 'RF_model_CN_1d_025_scale_multiyear_mean_CMIP6_SSP585.mat';
save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\10-3-RF-models-025-scale-CMIP6-2031-2060\',filename2], 'model_ssp585')
