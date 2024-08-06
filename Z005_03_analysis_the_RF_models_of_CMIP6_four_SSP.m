%% 这个文件将根据处理得到的不同随机森林模型开展比较分析
%% 未来时期不同情景下的数据
%% 只有多年平均构建的全国模型

%% 1. 使用多年平均的全国数据构建的全国模型1
clear;clc;

path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\RamdomForest-master\RamdomForest-master\')

load('J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\10-2-Dataset-for-RF-regression-025-scale\CMIP6_future_SSP126_RF_Dataset_for_1d_025_scale_multiyear_mean_GI_CN.mat')
load('J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\10-3-RF-models-025-scale-CMIP6-2031-2060\RF_model_CN_1d_025_scale_multiyear_mean_CMIP6_SSP126.mat')

% 训练期的X
Y_hat_train = regRF_predict(X_Train,model_ssp126);

% 测试期的Y
Y_hat_test = regRF_predict(X_Test,model_ssp126);

% 计算训练器的RMSE
RMSE_ALL_models(1,1) = sqrt(mean((Y_hat_train-Y_Train).^2));

% 计算测试期的RMSE
RMSE_ALL_models(1,2)  = sqrt(mean((Y_hat_test-Y_Test).^2));

% 模型计算中的错误率随着树的数量而变化图
figure('Name','OOB error rate');
plot(model_ssp126.mse); title('OOB MSE error rate');  xlabel('iteration (# trees)'); ylabel('OOB error rate');
cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\012-01-RF-models-for-CMIP6-future\SSP126\')
exportgraphics(gcf,'错误率随着树的数量而变化图.jpg')

% 特征重要性
figure('Name','Importance Plots')
bar(model_ssp126.importance(:,end-1));xlabel('feature');ylabel('magnitude');
title('Mean decrease in Accuracy');
set(gca,'xticklabel',{'经度','纬度','年均温','年降水量'},'fontname','宋体')
cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\012-01-RF-models-for-CMIP6-future\SSP126\')
exportgraphics(gcf,'特征重要性.jpg')

% 训练期的散点图
figure
plot(Y_hat_train,Y_Train,'b.')
title('训练集','fontname','宋体')
cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\012-01-RF-models-for-CMIP6-future\SSP126\')
exportgraphics(gcf,'训练集效果.jpg')

% 测试期的散点图
figure
plot(Y_hat_test,Y_Test,'r.')
title('测试集','fontname','宋体')
cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\012-01-RF-models-for-CMIP6-future\SSP126\')
exportgraphics(gcf,'测试集效果.jpg')

%% SSP245
clear;clc;

path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\RamdomForest-master\RamdomForest-master\')

load('J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\10-2-Dataset-for-RF-regression-025-scale\CMIP6_future_SSP245_RF_Dataset_for_1d_025_scale_multiyear_mean_GI_CN.mat')
load('J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\10-3-RF-models-025-scale-CMIP6-2031-2060\RF_model_CN_1d_025_scale_multiyear_mean_CMIP6_SSP245.mat')

% 训练期的X
Y_hat_train = regRF_predict(X_Train,model_ssp245);

% 测试期的Y
Y_hat_test = regRF_predict(X_Test,model_ssp245);

% 计算训练器的RMSE
RMSE_ALL_models(1,1) = sqrt(mean((Y_hat_train-Y_Train).^2));

% 计算测试期的RMSE
RMSE_ALL_models(1,2)  = sqrt(mean((Y_hat_test-Y_Test).^2));

% 模型计算中的错误率随着树的数量而变化图
figure('Name','OOB error rate');
plot(model_ssp245.mse); title('OOB MSE error rate');  xlabel('iteration (# trees)'); ylabel('OOB error rate');
cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\012-01-RF-models-for-CMIP6-future\SSP245\')
exportgraphics(gcf,'错误率随着树的数量而变化图.jpg')

% 特征重要性
figure('Name','Importance Plots')
bar(model_ssp245.importance(:,end-1));xlabel('feature');ylabel('magnitude');
title('Mean decrease in Accuracy');
set(gca,'xticklabel',{'经度','纬度','年均温','年降水量'},'fontname','宋体')
cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\012-01-RF-models-for-CMIP6-future\SSP245\')
exportgraphics(gcf,'特征重要性.jpg')

% 训练期的散点图
figure
plot(Y_hat_train,Y_Train,'b.')
title('训练集','fontname','宋体')
cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\012-01-RF-models-for-CMIP6-future\SSP245\')
exportgraphics(gcf,'训练集效果.jpg')

% 测试期的散点图
figure
plot(Y_hat_test,Y_Test,'r.')
title('测试集','fontname','宋体')
cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\012-01-RF-models-for-CMIP6-future\SSP245\')
exportgraphics(gcf,'测试集效果.jpg')

%% SSP370
clear;clc;

path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\RamdomForest-master\RamdomForest-master\')

load('J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\10-2-Dataset-for-RF-regression-025-scale\CMIP6_future_SSP370_RF_Dataset_for_1d_025_scale_multiyear_mean_GI_CN.mat')
load('J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\10-3-RF-models-025-scale-CMIP6-2031-2060\RF_model_CN_1d_025_scale_multiyear_mean_CMIP6_SSP370.mat')

% 训练期的X
Y_hat_train = regRF_predict(X_Train,model_ssp370);

% 测试期的Y
Y_hat_test = regRF_predict(X_Test,model_ssp370);

% 计算训练器的RMSE
RMSE_ALL_models(1,1) = sqrt(mean((Y_hat_train-Y_Train).^2));

% 计算测试期的RMSE
RMSE_ALL_models(1,2)  = sqrt(mean((Y_hat_test-Y_Test).^2));

% 模型计算中的错误率随着树的数量而变化图
figure('Name','OOB error rate');
plot(model_ssp370.mse); title('OOB MSE error rate');  xlabel('iteration (# trees)'); ylabel('OOB error rate');
cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\012-01-RF-models-for-CMIP6-future\SSP370\')
exportgraphics(gcf,'错误率随着树的数量而变化图.jpg')

% 特征重要性
figure('Name','Importance Plots')
bar(model_ssp370.importance(:,end-1));xlabel('feature');ylabel('magnitude');
title('Mean decrease in Accuracy');
set(gca,'xticklabel',{'经度','纬度','年均温','年降水量'},'fontname','宋体')
cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\012-01-RF-models-for-CMIP6-future\SSP370\')
exportgraphics(gcf,'特征重要性.jpg')

% 训练期的散点图
figure
plot(Y_hat_train,Y_Train,'b.')
title('训练集','fontname','宋体')
cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\012-01-RF-models-for-CMIP6-future\SSP370\')
exportgraphics(gcf,'训练集效果.jpg')

% 测试期的散点图
figure
plot(Y_hat_test,Y_Test,'r.')
title('测试集','fontname','宋体')
cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\012-01-RF-models-for-CMIP6-future\SSP370\')
exportgraphics(gcf,'测试集效果.jpg')

%% SSP585
clear;clc;

path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\RamdomForest-master\RamdomForest-master\')

load('J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\10-2-Dataset-for-RF-regression-025-scale\CMIP6_future_SSP585_RF_Dataset_for_1d_025_scale_multiyear_mean_GI_CN.mat')
load('J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\10-3-RF-models-025-scale-CMIP6-2031-2060\RF_model_CN_1d_025_scale_multiyear_mean_CMIP6_SSP585.mat')

% 训练期的X
Y_hat_train = regRF_predict(X_Train,model_ssp585);

% 测试期的Y
Y_hat_test = regRF_predict(X_Test,model_ssp585);

% 计算训练器的RMSE
RMSE_ALL_models(1,1) = sqrt(mean((Y_hat_train-Y_Train).^2));

% 计算测试期的RMSE
RMSE_ALL_models(1,2)  = sqrt(mean((Y_hat_test-Y_Test).^2));

% 模型计算中的错误率随着树的数量而变化图
figure('Name','OOB error rate');
plot(model_ssp585.mse); title('OOB MSE error rate');  xlabel('iteration (# trees)'); ylabel('OOB error rate');
cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\012-01-RF-models-for-CMIP6-future\SSP585\')
exportgraphics(gcf,'错误率随着树的数量而变化图.jpg')

% 特征重要性
figure('Name','Importance Plots')
bar(model_ssp585.importance(:,end-1));xlabel('feature');ylabel('magnitude');
title('Mean decrease in Accuracy');
set(gca,'xticklabel',{'经度','纬度','年均温','年降水量'},'fontname','宋体')
cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\012-01-RF-models-for-CMIP6-future\SSP585\')
exportgraphics(gcf,'特征重要性.jpg')

% 训练期的散点图
figure
plot(Y_hat_train,Y_Train,'b.')
title('训练集','fontname','宋体')
cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\012-01-RF-models-for-CMIP6-future\SSP585\')
exportgraphics(gcf,'训练集效果.jpg')

% 测试期的散点图
figure
plot(Y_hat_test,Y_Test,'r.')
title('测试集','fontname','宋体')
cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\012-01-RF-models-for-CMIP6-future\SSP585\')
exportgraphics(gcf,'测试集效果.jpg')
