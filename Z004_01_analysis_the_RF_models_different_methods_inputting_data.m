%% 这个文件将根据处理得到的不同随机森林模型开展比较分析
%% 输入的变量主要有经纬度+年均温+年降水量（4个），后续考虑要不要去掉经纬度
%% 主要包括：
%% 1. 使用多年平均的全国数据构建的全国模型1 ✔
%% 2. 使用逐年全国数据构建的全国模型2 ×
%% 3. 使用多年平均的气候区数据构建的独立4气候模型 ✔
%% 4. 使用逐年气候区数据构建的独立4气候模型 ×

%% 1. 使用多年平均的全国数据构建的全国模型1
clear;clc;

RMSE_ALL_models = nan(10,2);

path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\RamdomForest-master\RamdomForest-master\')

load('J:\6-硕士毕业论文\1-Data\CMFD\10-3-Dataset-for-RF-regression-025-scale\multiyear_mean\RF_Dataset_for_1d_025_scale_multiyear_mean_GI_CN.mat')
load('J:\6-硕士毕业论文\1-Data\CMFD\10-4-RF-models-025-scale\multiyear_mean\RF_model_CN_1d_025_scale_multiyear_mean.mat')

% 训练期的X
Y_hat_train = regRF_predict(X_Train,model);
R2_train = 1 - (sum((Y_hat_train- Y_Train).^2) / sum((Y_Train - mean(Y_Train)).^2));

% 测试期的Y
Y_hat_test = regRF_predict(X_Test,model);
R2_test = 1 - (sum((Y_hat_test- Y_Test).^2) / sum((Y_Test - mean(Y_Test)).^2));

% 计算训练器的RMSE
RMSE_ALL_models(1,1) = sqrt(mean((Y_hat_train-Y_Train).^2));

% 计算测试期的RMSE
RMSE_ALL_models(1,2)  = sqrt(mean((Y_hat_test-Y_Test).^2));
% 
% % 模型计算中的错误率随着树的数量而变化图
% figure('Name','OOB error rate');
% plot(model.mse); title('OOB MSE error rate');  xlabel('iteration (# trees)'); ylabel('OOB error rate');
% cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\011-01-RF-models-for-1d-GI_025_regression\CN_big_multiyear_mean\')
% exportgraphics(gcf,'错误率随着树的数量而变化图.jpg')
% 
% % 特征重要性
% figure('Name','Importance Plots')
% bar(model.importance(:,end-1));xlabel('feature');ylabel('magnitude');
% title('Mean decrease in Accuracy');
% set(gca,'xticklabel',{'经度','纬度','年均温','年降水量'},'fontname','宋体')
% cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\011-01-RF-models-for-1d-GI_025_regression\CN_big_multiyear_mean\')
% exportgraphics(gcf,'特征重要性.jpg')

X = 0.65:0.01:1;
Y = 0.65:0.01:1;
figure1 = figure('Position', [1, 1, 1300, 1000],'paperpositionmode','auto');

% 训练期的散点图
ax1 = axes('pos',[0.12 0.3 0.37 0.5]);
plot(X,Y,'k-','linewidth',2)
hold on 
plot(Y_hat_train,Y_Train,'b.')
hold off
% title('训练集','fontname','宋体')

% 强制保留小数位数
cb_tick = get(ax1,'ytick');
Tick_label = cell(1,length(cb_tick));
for j = 1 : length(cb_tick)
    Tick_label{1,j} = num2str(roundn(cb_tick(j),-2),'%4.2f');
end
set(ax1,'yticklabel',Tick_label)

cb_tick = get(ax1,'xtick');
Tick_label = cell(1,length(cb_tick));
for j = 1 : length(cb_tick)
    Tick_label{1,j} = num2str(roundn(cb_tick(j),-2),'%4.2f');
end
set(ax1,'xticklabel',Tick_label)

% 测试期的散点图
ax2 = axes('pos',[0.55 0.3 0.37 0.5]);
plot(X,Y,'k-','linewidth',2)
hold on 
plot(Y_hat_test,Y_Test,'r.')
hold off
% title('测试集','fontname','宋体')

% 强制保留小数位数
cb_tick = get(ax2,'ytick');
Tick_label = cell(1,length(cb_tick));
for j = 1 : length(cb_tick)
    Tick_label{1,j} = num2str(roundn(cb_tick(j),-2),'%4.2f');
end
set(ax2,'yticklabel',Tick_label)

cb_tick = get(ax2,'xtick');
Tick_label = cell(1,length(cb_tick));
for j = 1 : length(cb_tick)
    Tick_label{1,j} = num2str(roundn(cb_tick(j),-2),'%4.2f');
end
set(ax2,'xticklabel',Tick_label)

set(ax2,'fontsize',15)
set(ax1,'fontsize',15)
set(ax2,'linewidth',1.5)
set(ax1,'linewidth',1.5)


axes('visible','off');
text('string','(a)','Units','normalized','position',[0.009,0.8],'fontsize',20,'FontName','times new roman')
text('string','(b)','Units','normalized','position',[0.57,0.8],'fontsize',20,'FontName','times new roman')
text('string','训练集','Units','normalized','position',[0.04,0.797],'fontsize',20,'FontName','宋体')
text('string','测试集','Units','normalized','position',[0.605,0.797],'fontsize',20,'FontName','宋体')

text('string',['RMSE = ',num2str(roundn(RMSE_ALL_models(1,1),-3))],'Units','normalized','position',[0.27,0.32],'fontsize',20,'FontName','times new roman')
text('string',['RMSE = ',num2str(roundn(RMSE_ALL_models(1,2),-3))],'Units','normalized','position',[0.83,0.32],'fontsize',20,'FontName','times new roman')
text('string',['R^2 = ',num2str(roundn(R2_train,-3),'%4.3f')],'Units','normalized','position',[0.3,0.28],'fontsize',20,'FontName','times new roman')
text('string',['R^2 = ',num2str(roundn(R2_test,-3),'%4.3f')],'Units','normalized','position',[0.86,0.28],'fontsize',20,'FontName','times new roman')

text('string','基准值','Units','normalized','position',[-0.08,0.49],'fontsize',20,'FontName','宋体','rotation',90)
text('string','模拟值','Units','normalized','position',[0.46,0.17],'fontsize',20,'FontName','宋体')



cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\011-01-RF-models-for-1d-GI_025_regression\CN_big_multiyear_mean\')
exportgraphics(gcf,'历史时期模型在训练集和验证集的效果.jpg')

% %% 2. 使用逐年全国数据构建的全国模型2
% 
% clearvars -except RMSE_ALL_models
% clc;
% 
% path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\RamdomForest-master\RamdomForest-master\')
% 
% load('J:\6-硕士毕业论文\1-Data\CMFD\10-3-Dataset-for-RF-regression-025-scale\annual\RF_Dataset_for_1d_025_scale_GI_annual_CN.mat')
% load('J:\6-硕士毕业论文\1-Data\CMFD\10-4-RF-models-025-scale\annual\RF_model_CN_1d_025_scale_annual.mat')
% 
% % 训练期的X
% Y_hat_train = regRF_predict(X_Train,model);
% 
% % 测试期的Y
% Y_hat_test = regRF_predict(X_Test,model);
% 
% % 计算训练器的RMSE
% RMSE_ALL_models(2,1) = sqrt(mean((Y_hat_train-Y_Train).^2));
% 
% % 计算测试期的RMSE
% RMSE_ALL_models(2,2) = sqrt(mean((Y_hat_test-Y_Test).^2));
% 
% % 模型计算中的错误率随着树的数量而变化图
% figure('Name','OOB error rate');
% plot(model.mse); title('OOB MSE error rate');  xlabel('iteration (# trees)'); ylabel('OOB error rate');
% cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\011-01-RF-models-for-1d-GI_025_regression\CN_big_annual\')
% exportgraphics(gcf,'错误率随着树的数量而变化图.jpg')
% 
% % 特征重要性
% figure('Name','Importance Plots')
% bar(model.importance(:,end-1));xlabel('feature');ylabel('magnitude');
% title('Mean decrease in Accuracy');
% set(gca,'xticklabel',{'经度','纬度','年均温','年降水量'},'fontname','宋体')
% cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\011-01-RF-models-for-1d-GI_025_regression\CN_big_annual\')
% exportgraphics(gcf,'特征重要性.jpg')
% 
% % 训练期的散点图
% figure
% plot(Y_hat_train,Y_Train,'b.')
% title('训练集','fontname','宋体')
% cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\011-01-RF-models-for-1d-GI_025_regression\CN_big_annual\')
% exportgraphics(gcf,'训练集效果.jpg')
% 
% % 测试期的散点图
% figure
% plot(Y_hat_test,Y_Test,'r.')
% title('测试集','fontname','宋体')
% cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\011-01-RF-models-for-1d-GI_025_regression\CN_big_annual\')
% exportgraphics(gcf,'测试集效果.jpg')
% 
% 
% %% 3. 使用多年平均的气候区数据构建的独立4气候模型
% 
% %% HR 气候区
% 
% clearvars -except RMSE_ALL_models;
% clc;
% 
% path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\RamdomForest-master\RamdomForest-master\')
% 
% load('J:\6-硕士毕业论文\1-Data\CMFD\10-3-Dataset-for-RF-regression-025-scale\multiyear_mean\HR\RF_Dataset_for_1d_025_scale_multiyear_mean_GI_HR.mat')
% load('J:\6-硕士毕业论文\1-Data\CMFD\10-4-RF-models-025-scale\multiyear_mean\HR\RF_model_HR_1d_025_scale_multiyear_mean.mat')
% 
% % 训练期的X
% Y_hat_train = regRF_predict(X_Train,model_HR);
% 
% % 测试期的Y
% Y_hat_test = regRF_predict(X_Test,model_HR);
% 
% % 计算训练器的RMSE
% RMSE_ALL_models(3,1) = sqrt(mean((Y_hat_train-Y_Train).^2));
% 
% % 计算测试期的RMSE
% RMSE_ALL_models(3,2) = sqrt(mean((Y_hat_test-Y_Test).^2));
% 
% % 模型计算中的错误率随着树的数量而变化图
% figure('Name','OOB error rate');
% plot(model_HR.mse); title('OOB MSE error rate');  xlabel('iteration (# trees)'); ylabel('OOB error rate');
% cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\011-01-RF-models-for-1d-GI_025_regression\climate_multiyear_mean\')
% exportgraphics(gcf,'HR-错误率随着树的数量而变化图.jpg')
% 
% % 特征重要性
% figure('Name','Importance Plots')
% bar(model_HR.importance(:,end-1));xlabel('feature');ylabel('magnitude');
% title('Mean decrease in Accuracy');
% set(gca,'xticklabel',{'经度','纬度','年均温','年降水量'},'fontname','宋体')
% cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\011-01-RF-models-for-1d-GI_025_regression\climate_multiyear_mean\')
% exportgraphics(gcf,'HR-特征重要性.jpg')
% 
% % 训练期的散点图
% figure
% plot(Y_hat_train,Y_Train,'b.')
% title('训练集','fontname','宋体')
% cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\011-01-RF-models-for-1d-GI_025_regression\climate_multiyear_mean\')
% exportgraphics(gcf,'HR-训练集效果.jpg')
% 
% % 测试期的散点图
% figure
% plot(Y_hat_test,Y_Test,'r.')
% title('测试集','fontname','宋体')
% cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\011-01-RF-models-for-1d-GI_025_regression\climate_multiyear_mean\')
% exportgraphics(gcf,'HR-测试集效果.jpg')
% 
% %% TR 气候区
% clearvars -except RMSE_ALL_models;
% clc;
% 
% path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\RamdomForest-master\RamdomForest-master\')
% 
% load('J:\6-硕士毕业论文\1-Data\CMFD\10-3-Dataset-for-RF-regression-025-scale\multiyear_mean\TR\RF_Dataset_for_1d_025_scale_multiyear_mean_GI_TR.mat')
% load('J:\6-硕士毕业论文\1-Data\CMFD\10-4-RF-models-025-scale\multiyear_mean\TR\RF_model_TR_1d_025_scale_multiyear_mean.mat')
% 
% % 训练期的X
% Y_hat_train = regRF_predict(X_Train,model_TR);
% 
% % 测试期的Y
% Y_hat_test = regRF_predict(X_Test,model_TR);
% 
% % 计算训练器的RMSE
% RMSE_ALL_models(4,1) = sqrt(mean((Y_hat_train-Y_Train).^2));
% 
% % 计算测试期的RMSE
% RMSE_ALL_models(4,2) = sqrt(mean((Y_hat_test-Y_Test).^2));
% 
% % 模型计算中的错误率随着树的数量而变化图
% figure('Name','OOB error rate');
% plot(model_TR.mse); title('OOB MSE error rate');  xlabel('iteration (# trees)'); ylabel('OOB error rate');
% cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\011-01-RF-models-for-1d-GI_025_regression\climate_multiyear_mean\')
% exportgraphics(gcf,'TR-错误率随着树的数量而变化图.jpg')
% 
% % 特征重要性
% figure('Name','Importance Plots')
% bar(model_TR.importance(:,end-1));xlabel('feature');ylabel('magnitude');
% title('Mean decrease in Accuracy');
% set(gca,'xticklabel',{'经度','纬度','年均温','年降水量'},'fontname','宋体')
% cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\011-01-RF-models-for-1d-GI_025_regression\climate_multiyear_mean\')
% exportgraphics(gcf,'TR-特征重要性.jpg')
% 
% % 训练期的散点图
% figure
% plot(Y_hat_train,Y_Train,'b.')
% title('训练集','fontname','宋体')
% cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\011-01-RF-models-for-1d-GI_025_regression\climate_multiyear_mean\')
% exportgraphics(gcf,'TR-训练集效果.jpg')
% 
% % 测试期的散点图
% figure
% plot(Y_hat_test,Y_Test,'r.')
% title('测试集','fontname','宋体')
% cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\011-01-RF-models-for-1d-GI_025_regression\climate_multiyear_mean\')
% exportgraphics(gcf,'TR-测试集效果.jpg')
% 
% 
% %% AR 气候区
% clearvars -except RMSE_ALL_models;
% clc;
% 
% path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\RamdomForest-master\RamdomForest-master\')
% 
% load('J:\6-硕士毕业论文\1-Data\CMFD\10-3-Dataset-for-RF-regression-025-scale\multiyear_mean\AR\RF_Dataset_for_1d_025_scale_multiyear_mean_GI_AR.mat')
% load('J:\6-硕士毕业论文\1-Data\CMFD\10-4-RF-models-025-scale\multiyear_mean\AR\RF_model_AR_1d_025_scale_multiyear_mean.mat')
% 
% % 训练期的X
% Y_hat_train = regRF_predict(X_Train,model_AR);
% 
% % 测试期的Y
% Y_hat_test = regRF_predict(X_Test,model_AR);
% 
% % 计算训练器的RMSE
% RMSE_ALL_models(5,1) = sqrt(mean((Y_hat_train-Y_Train).^2));
% 
% % 计算测试期的RMSE
% RMSE_ALL_models(5,2) = sqrt(mean((Y_hat_test-Y_Test).^2));
% 
% % 模型计算中的错误率随着树的数量而变化图
% figure('Name','OOB error rate');
% plot(model_AR.mse); title('OOB MSE error rate');  xlabel('iteration (# trees)'); ylabel('OOB error rate');
% cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\011-01-RF-models-for-1d-GI_025_regression\climate_multiyear_mean\')
% exportgraphics(gcf,'AR-错误率随着树的数量而变化图.jpg')
% 
% % 特征重要性
% figure('Name','Importance Plots')
% bar(model_AR.importance(:,end-1));xlabel('feature');ylabel('magnitude');
% title('Mean decrease in Accuracy');
% set(gca,'xticklabel',{'经度','纬度','年均温','年降水量'},'fontname','宋体')
% cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\011-01-RF-models-for-1d-GI_025_regression\climate_multiyear_mean\')
% exportgraphics(gcf,'AR-特征重要性.jpg')
% 
% % 训练期的散点图
% figure
% plot(Y_hat_train,Y_Train,'b.')
% title('训练集','fontname','宋体')
% cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\011-01-RF-models-for-1d-GI_025_regression\climate_multiyear_mean\')
% exportgraphics(gcf,'AR-训练集效果.jpg')
% 
% % 测试期的散点图
% figure
% plot(Y_hat_test,Y_Test,'r.')
% title('测试集','fontname','宋体')
% cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\011-01-RF-models-for-1d-GI_025_regression\climate_multiyear_mean\')
% exportgraphics(gcf,'AR-测试集效果.jpg')
% 
% %% TP 气候区
% clearvars -except RMSE_ALL_models;
% clc;
% 
% path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\RamdomForest-master\RamdomForest-master\')
% 
% load('J:\6-硕士毕业论文\1-Data\CMFD\10-3-Dataset-for-RF-regression-025-scale\multiyear_mean\TP\RF_Dataset_for_1d_025_scale_multiyear_mean_GI_TP.mat')
% load('J:\6-硕士毕业论文\1-Data\CMFD\10-4-RF-models-025-scale\multiyear_mean\TP\RF_model_TP_1d_025_scale_multiyear_mean.mat')
% 
% % 训练期的X
% Y_hat_train = regRF_predict(X_Train,model_TP);
% 
% % 测试期的Y
% Y_hat_test = regRF_predict(X_Test,model_TP);
% 
% % 计算训练器的RMSE
% RMSE_ALL_models(6,1) = sqrt(mean((Y_hat_train-Y_Train).^2));
% 
% % 计算测试期的RMSE
% RMSE_ALL_models(6,2) = sqrt(mean((Y_hat_test-Y_Test).^2));
% 
% % 模型计算中的错误率随着树的数量而变化图
% figure('Name','OOB error rate');
% plot(model_TP.mse); title('OOB MSE error rate');  xlabel('iteration (# trees)'); ylabel('OOB error rate');
% cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\011-01-RF-models-for-1d-GI_025_regression\climate_multiyear_mean\')
% exportgraphics(gcf,'TP-错误率随着树的数量而变化图.jpg')
% 
% % 特征重要性
% figure('Name','Importance Plots')
% bar(model_TP.importance(:,end-1));xlabel('feature');ylabel('magnitude');
% title('Mean decrease in Accuracy');
% set(gca,'xticklabel',{'经度','纬度','年均温','年降水量'},'fontname','宋体')
% cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\011-01-RF-models-for-1d-GI_025_regression\climate_multiyear_mean\')
% exportgraphics(gcf,'TP-特征重要性.jpg')
% 
% % 训练期的散点图
% figure
% plot(Y_hat_train,Y_Train,'b.')
% title('训练集','fontname','宋体')
% cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\011-01-RF-models-for-1d-GI_025_regression\climate_multiyear_mean\')
% exportgraphics(gcf,'TP-训练集效果.jpg')
% 
% % 测试期的散点图
% figure
% plot(Y_hat_test,Y_Test,'r.')
% title('测试集','fontname','宋体')
% cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\011-01-RF-models-for-1d-GI_025_regression\climate_multiyear_mean\')
% exportgraphics(gcf,'TP-测试集效果.jpg')
% 
% %% 4. 使用逐年气候区数据构建的独立4气候模型
% 
% 
% %% HR 气候区
% 
% clearvars -except RMSE_ALL_models;
% clc;
% 
% path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\RamdomForest-master\RamdomForest-master\')
% 
% load('J:\6-硕士毕业论文\1-Data\CMFD\10-3-Dataset-for-RF-regression-025-scale\annual\HR\RF_Dataset_for_1d_025_scale_GI_annual_HR.mat')
% load('J:\6-硕士毕业论文\1-Data\CMFD\10-4-RF-models-025-scale\annual\HR\RF_model_HR_1d_025_scale_multiyear_mean.mat')
% 
% % 训练期的X
% Y_hat_train = regRF_predict(X_Train,model_HR);
% 
% % 测试期的Y
% Y_hat_test = regRF_predict(X_Test,model_HR);
% 
% % 计算训练器的RMSE
% RMSE_ALL_models(7,1) = sqrt(mean((Y_hat_train-Y_Train).^2));
% 
% % 计算测试期的RMSE
% RMSE_ALL_models(7,2) = sqrt(mean((Y_hat_test-Y_Test).^2));
% 
% % 模型计算中的错误率随着树的数量而变化图
% figure('Name','OOB error rate');
% plot(model_HR.mse); title('OOB MSE error rate');  xlabel('iteration (# trees)'); ylabel('OOB error rate');
% set(gca,'xticklabel',{'经度','纬度','年均温','年降水量'},'fontname','宋体')
% cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\011-01-RF-models-for-1d-GI_025_regression\climate_annual\')
% exportgraphics(gcf,'HR-错误率随着树的数量而变化图.jpg')
% 
% % 特征重要性
% figure('Name','Importance Plots')
% bar(model_HR.importance(:,end-1));xlabel('feature');ylabel('magnitude');
% title('Mean decrease in Accuracy');
% set(gca,'xticklabel',{'经度','纬度','年均温','年降水量'},'fontname','宋体')
% cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\011-01-RF-models-for-1d-GI_025_regression\climate_annual\')
% exportgraphics(gcf,'HR-特征重要性.jpg')
% 
% % 训练期的散点图
% figure
% plot(Y_hat_train,Y_Train,'b.')
% title('训练集','fontname','宋体')
% cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\011-01-RF-models-for-1d-GI_025_regression\climate_annual\')
% exportgraphics(gcf,'HR-训练集效果.jpg')
% 
% % 测试期的散点图
% figure
% plot(Y_hat_test,Y_Test,'r.')
% title('测试集','fontname','宋体')
% cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\011-01-RF-models-for-1d-GI_025_regression\climate_annual\')
% exportgraphics(gcf,'HR-测试集效果.jpg')
% 
% %% TR 气候区
% clearvars -except RMSE_ALL_models;
% clc;
% 
% path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\RamdomForest-master\RamdomForest-master\')
% 
% load('J:\6-硕士毕业论文\1-Data\CMFD\10-3-Dataset-for-RF-regression-025-scale\annual\TR\RF_Dataset_for_1d_025_scale_GI_annual_TR.mat')
% load('J:\6-硕士毕业论文\1-Data\CMFD\10-4-RF-models-025-scale\annual\TR\RF_model_TR_1d_025_scale_multiyear_mean.mat')
% 
% % 训练期的X
% Y_hat_train = regRF_predict(X_Train,model_TR);
% 
% % 测试期的Y
% Y_hat_test = regRF_predict(X_Test,model_TR);
% 
% % 计算训练器的RMSE
% RMSE_ALL_models(8,1) = sqrt(mean((Y_hat_train-Y_Train).^2));
% 
% % 计算测试期的RMSE
% RMSE_ALL_models(8,2) = sqrt(mean((Y_hat_test-Y_Test).^2));
% 
% % 模型计算中的错误率随着树的数量而变化图
% figure('Name','OOB error rate');
% plot(model_TR.mse); title('OOB MSE error rate');  xlabel('iteration (# trees)'); ylabel('OOB error rate');
% cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\011-01-RF-models-for-1d-GI_025_regression\climate_annual\')
% exportgraphics(gcf,'TR-错误率随着树的数量而变化图.jpg')
% 
% % 特征重要性
% figure('Name','Importance Plots')
% bar(model_TR.importance(:,end-1));xlabel('feature');ylabel('magnitude');
% title('Mean decrease in Accuracy');
% set(gca,'xticklabel',{'经度','纬度','年均温','年降水量'},'fontname','宋体')
% cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\011-01-RF-models-for-1d-GI_025_regression\climate_annual\')
% exportgraphics(gcf,'TR-特征重要性.jpg')
% 
% % 训练期的散点图
% figure
% plot(Y_hat_train,Y_Train,'b.')
% title('训练集','fontname','宋体')
% cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\011-01-RF-models-for-1d-GI_025_regression\climate_annual\')
% exportgraphics(gcf,'TR-训练集效果.jpg')
% 
% % 测试期的散点图
% figure
% plot(Y_hat_test,Y_Test,'r.')
% title('测试集','fontname','宋体')
% cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\011-01-RF-models-for-1d-GI_025_regression\climate_annual\')
% exportgraphics(gcf,'TR-测试集效果.jpg')
% 
% 
% %% AR 气候区
% clearvars -except RMSE_ALL_models;
% clc;
% 
% path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\RamdomForest-master\RamdomForest-master\')
% 
% load('J:\6-硕士毕业论文\1-Data\CMFD\10-3-Dataset-for-RF-regression-025-scale\annual\AR\RF_Dataset_for_1d_025_scale_GI_annual_AR.mat')
% load('J:\6-硕士毕业论文\1-Data\CMFD\10-4-RF-models-025-scale\annual\AR\RF_model_AR_1d_025_scale_multiyear_mean.mat')
% 
% % 训练期的X
% Y_hat_train = regRF_predict(X_Train,model_AR);
% 
% % 测试期的Y
% Y_hat_test = regRF_predict(X_Test,model_AR);
% 
% % 计算训练器的RMSE
% RMSE_ALL_models(9,1) = sqrt(mean((Y_hat_train-Y_Train).^2));
% 
% % 计算测试期的RMSE
% RMSE_ALL_models(9,2) = sqrt(mean((Y_hat_test-Y_Test).^2));
% 
% % 模型计算中的错误率随着树的数量而变化图
% figure('Name','OOB error rate');
% plot(model_AR.mse); title('OOB MSE error rate');  xlabel('iteration (# trees)'); ylabel('OOB error rate');
% cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\011-01-RF-models-for-1d-GI_025_regression\climate_annual\')
% exportgraphics(gcf,'AR-错误率随着树的数量而变化图.jpg')
% 
% % 特征重要性
% figure('Name','Importance Plots')
% bar(model_AR.importance(:,end-1));xlabel('feature');ylabel('magnitude');
% title('Mean decrease in Accuracy');
% set(gca,'xticklabel',{'经度','纬度','年均温','年降水量'},'fontname','宋体')
% cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\011-01-RF-models-for-1d-GI_025_regression\climate_annual\')
% exportgraphics(gcf,'AR-特征重要性.jpg')
% 
% % 训练期的散点图
% figure
% plot(Y_hat_train,Y_Train,'b.')
% title('训练集','fontname','宋体')
% cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\011-01-RF-models-for-1d-GI_025_regression\climate_annual\')
% exportgraphics(gcf,'AR-训练集效果.jpg')
% 
% % 测试期的散点图
% figure
% plot(Y_hat_test,Y_Test,'r.')
% title('测试集','fontname','宋体')
% cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\011-01-RF-models-for-1d-GI_025_regression\climate_annual\')
% exportgraphics(gcf,'AR-测试集效果.jpg')
% 
% %% TP 气候区
% clearvars -except RMSE_ALL_models;
% clc;
% 
% path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\RamdomForest-master\RamdomForest-master\')
% 
% load('J:\6-硕士毕业论文\1-Data\CMFD\10-3-Dataset-for-RF-regression-025-scale\annual\TP\RF_Dataset_for_1d_025_scale_GI_annual_TP.mat')
% load('J:\6-硕士毕业论文\1-Data\CMFD\10-4-RF-models-025-scale\annual\TP\RF_model_TP_1d_025_scale_multiyear_mean.mat')
% 
% % 训练期的X
% Y_hat_train = regRF_predict(X_Train,model_TP);
% 
% % 测试期的Y
% Y_hat_test = regRF_predict(X_Test,model_TP);
% 
% % 计算训练器的RMSE
% RMSE_ALL_models(10,1) = sqrt(mean((Y_hat_train-Y_Train).^2));
% 
% % 计算测试期的RMSE
% RMSE_ALL_models(10,2) = sqrt(mean((Y_hat_test-Y_Test).^2));
% 
% % 模型计算中的错误率随着树的数量而变化图
% figure('Name','OOB error rate');
% plot(model_TP.mse); title('OOB MSE error rate');  xlabel('iteration (# trees)'); ylabel('OOB error rate');
% cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\011-01-RF-models-for-1d-GI_025_regression\climate_annual\')
% exportgraphics(gcf,'TP-错误率随着树的数量而变化图.jpg')
% 
% % 特征重要性
% figure('Name','Importance Plots')
% bar(model_TP.importance(:,end-1));xlabel('feature');ylabel('magnitude');
% title('Mean decrease in Accuracy');
% set(gca,'xticklabel',{'经度','纬度','年均温','年降水量'},'fontname','宋体')
% cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\011-01-RF-models-for-1d-GI_025_regression\climate_annual\')
% exportgraphics(gcf,'TP-特征重要性.jpg')
% 
% % 训练期的散点图
% figure
% plot(Y_hat_train,Y_Train,'b.')
% title('训练集','fontname','宋体')
% cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\011-01-RF-models-for-1d-GI_025_regression\climate_annual\')
% exportgraphics(gcf,'TP-训练集效果.jpg')
% 
% % 测试期的散点图
% figure
% plot(Y_hat_test,Y_Test,'r.')
% title('测试集','fontname','宋体')
% cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\011-01-RF-models-for-1d-GI_025_regression\climate_annual\')
% exportgraphics(gcf,'TP-测试集效果.jpg')
% 
% 
% 
% 
% 
% 
% 
% 
