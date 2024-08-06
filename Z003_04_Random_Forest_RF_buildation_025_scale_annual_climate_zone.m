%% 这个文件开始尝试建立随机森林回归模型
%% 使用的是时间分辨率为1d
%% 空间分辨率为0.25°
%% 逐年
%% 气候区 4个模型

%% HR
clear;clc;
cd('J:\6-硕士毕业论文\1-Data\CMFD\10-3-Dataset-for-RF-regression-025-scale\annual\HR\')
load('RF_Dataset_for_1d_025_scale_GI_annual_HR.mat')

path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\RamdomForest-master\RamdomForest-master\')

clear extra_options
extra_options.importance = 1; %(0 = (Default) Don't, 1=calculate)
model_HR = regRF_train(X_Train,Y_Train, 200, 4, extra_options); % 200颗差不多了

filename2 = 'RF_model_HR_1d_025_scale_annual.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\10-3-Dataset-for-RF-regression-025-scale\annual\HR\',filename2], 'model_HR')

%% TR
clear;clc;
cd('J:\6-硕士毕业论文\1-Data\CMFD\10-3-Dataset-for-RF-regression-025-scale\annual\TR\')
load('RF_Dataset_for_1d_025_scale_GI_annual_TR.mat')

path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\RamdomForest-master\RamdomForest-master\')

clear extra_options
extra_options.importance = 1; %(0 = (Default) Don't, 1=calculate)
model_TR = regRF_train(X_Train,Y_Train, 200, 4, extra_options); % 200颗差不多了

filename2 = 'RF_model_TR_1d_025_scale_annual.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\10-3-Dataset-for-RF-regression-025-scale\annual\TR\',filename2], 'model_TR')

%% AR
clear;clc;
cd('J:\6-硕士毕业论文\1-Data\CMFD\10-3-Dataset-for-RF-regression-025-scale\annual\AR\')
load('RF_Dataset_for_1d_025_scale_GI_annual_AR.mat')

path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\RamdomForest-master\RamdomForest-master\')

clear extra_options
extra_options.importance = 1; %(0 = (Default) Don't, 1=calculate)
model_AR = regRF_train(X_Train,Y_Train, 200, 4, extra_options); % 200颗差不多了

filename2 = 'RF_model_AR_1d_025_scale_annual.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\10-3-Dataset-for-RF-regression-025-scale\annual\AR\',filename2], 'model_AR')

%% TP
clear;clc;
cd('J:\6-硕士毕业论文\1-Data\CMFD\10-3-Dataset-for-RF-regression-025-scale\annual\TP\')
load('RF_Dataset_for_1d_025_scale_GI_annual_TP.mat')

path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\RamdomForest-master\RamdomForest-master\')

clear extra_options
extra_options.importance = 1; %(0 = (Default) Don't, 1=calculate)
model_TP = regRF_train(X_Train,Y_Train, 200, 4, extra_options); % 200颗差不多了

filename2 = 'RF_model_TP_1d_025_scale_annual.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\10-3-Dataset-for-RF-regression-025-scale\annual\TP\',filename2], 'model_TP')

