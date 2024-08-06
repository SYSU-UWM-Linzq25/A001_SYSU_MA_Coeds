%% 这个文件开始尝试建立随机森林回归模型
%% 使用的是时间分辨率为1d
%% 空间分辨率为0.25°
%% 多年平均值
%% 全国一整个模型

clear;clc;
cd('J:\6-硕士毕业论文\1-Data\CMFD\10-3-Dataset-for-RF-regression-025-scale\multiyear_mean\')
load('RF_Dataset_for_1d_025_scale_multiyear_mean_GI_CN.mat')

path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\RamdomForest-master\RamdomForest-master\')

clear extra_options
extra_options.importance = 1; %(0 = (Default) Don't, 1=calculate)
model = regRF_train(X_Train,Y_Train, 500, 4, extra_options);
Y_hat = regRF_predict(X_Test,model);
Y_hat_train = regRF_predict(X_Train,model);

fprintf('\nexample 14: MSE rate %f\n',   sum((Y_hat-Y_Test).^2));

figure('Name','OOB error rate');
plot(model.mse); title('OOB MSE error rate');  xlabel('iteration (# trees)'); ylabel('OOB error rate');
% cd('J:\6-硕士毕业论文\1-Data\CMFD\10-2-RF-models\Annual_data_CN_part_data_test\')
% exportgraphics(gcf,'MSE .jpg')
    
    
figure('Name','Importance Plots')
bar(model.importance(:,end-1));xlabel('feature');ylabel('magnitude');
title('Mean decrease in Accuracy');
set(gca,'xticklabel',{'经度','纬度','年均温','年降水量'},'fontname','宋体')
% cd('J:\6-硕士毕业论文\1-Data\CMFD\10-2-RF-models\Annual_data_CN_part_data_test\')
% exportgraphics(gcf,'特征重要性 .jpg')

filename2 = 'RF_model_CN_1d_025_scale_multiyear_mean_500_4.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\10-4-RF-models-025-scale\multiyear_mean\',filename2], 'model')

figure
plot(Y_hat,Y_Test,'b.')

figure
plot(Y_hat_train,Y_Train,'r.')

% %% 考虑不要加进去经纬度(效果很差)
% clear;clc;
% cd('J:\6-硕士毕业论文\1-Data\CMFD\10-3-Dataset-for-RF-regression-025-scale\multiyear_mean\')
% load('RF_Dataset_for_1d_025_scale_multiyear_mean_GI_CN.mat')
% 
% X_Train = X_Train(:,3:4);
% X_Test = X_Test(:,3:4);
% 
% path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\RamdomForest-master\RamdomForest-master\')
% 
% clear extra_options
% extra_options.importance = 1; %(0 = (Default) Don't, 1=calculate)
% model = regRF_train(X_Train,Y_Train, 500, 4, extra_options);
% Y_hat = regRF_predict(X_Test,model);
% 
% fprintf('\nexample 14: MSE rate %f\n',   sum((Y_hat-Y_Test).^2));
% 
% figure('Name','OOB error rate');
% plot(model.mse); title('OOB MSE error rate');  xlabel('iteration (# trees)'); ylabel('OOB error rate');
% % cd('J:\6-硕士毕业论文\1-Data\CMFD\10-2-RF-models\Annual_data_CN_part_data_test\')
% % exportgraphics(gcf,'MSE .jpg')
%     
%     
% figure('Name','Importance Plots')
% bar(model.importance(:,end-1));xlabel('feature');ylabel('magnitude');
% title('Mean decrease in Accuracy');
% set(gca,'xticklabel',{'年均温','年降水量'},'fontname','宋体')
% % cd('J:\6-硕士毕业论文\1-Data\CMFD\10-2-RF-models\Annual_data_CN_part_data_test\')
% % exportgraphics(gcf,'特征重要性 .jpg')
% 
% figure
% plot(Y_hat,Y_Test,'b.')

%% 利用相同的训练集和测试集
%% 使用单影响因素建立线性模型（年均温或年降水量）
%% 使用多元线性回归建立模型
%% 检验效果从而说明随机森林模型的优越性

clear;clc;
cd('J:\6-硕士毕业论文\1-Data\CMFD\10-3-Dataset-for-RF-regression-025-scale\multiyear_mean\')
load('RF_Dataset_for_1d_025_scale_multiyear_mean_GI_CN.mat')

path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\RamdomForest-master\RamdomForest-master\')

%% 只使用温度作为输入建立线性回归模型
Temp_Train = X_Train(:,3);
Temp_Test = X_Test(:,3);

X_Temp = [ones(length(Temp_Train),1),Temp_Train];

[b_Temp,~,~,~,stats_Temp] = regress(Y_Train,X_Temp);

Y_hat_Temp_Train = b_Temp(1) + b_Temp(2)*Temp_Train;
Y_hat_Temp_Test = b_Temp(1) + b_Temp(2)*Temp_Test;


figure
plot(Y_hat_Temp_Train,Y_Train,'.')

figure
plot(Y_hat_Temp_Test,Y_Test,'.')

% 计算训练期和测试期的RMSE
RMSE_Temp_linear_Train = sqrt(mean((Y_hat_Temp_Train-Y_Train).^2));
RMSE_Temp_linear_Test = sqrt(mean((Y_hat_Temp_Test-Y_Test).^2));

%% 只使用年降水量作为输入建立线性回归模型
AP_Train = X_Train(:,4);
AP_Test = X_Test(:,4);
X_AP = [ones(length(AP_Train),1),AP_Train];

[b_AP,~,~,~,stats_AP] = regress(Y_Train,X_AP);

Y_hat_AP_Train = b_AP(1) + b_AP(2)*AP_Train;
Y_hat_AP_Test = b_AP(1) + b_AP(2)*AP_Test;


figure
plot(Y_hat_AP_Train,Y_Train,'.')

figure
plot(Y_hat_AP_Test,Y_Test,'.')

% 计算训练期和测试期的RMSE
RMSE_AP_linear_Train = sqrt(mean((Y_hat_AP_Train-Y_Train).^2));
RMSE_AP_linear_Test = sqrt(mean((Y_hat_AP_Test-Y_Test).^2));

%% 多元线性回归
X_Multi_linear = [ones(length(X_Train),1),X_Train(:,1) X_Train(:,2) X_Train(:,3) X_Train(:,4)];

[b_Multi_linear,~,~,~,stats_Multi_linear] = regress(Y_Train,X_Multi_linear);



Y_hat_Multi_linear_Train = b_Multi_linear(1) + b_Multi_linear(2)*X_Train(:,1) + b_Multi_linear(3)*X_Train(:,2) + b_Multi_linear(4)*X_Train(:,3) + b_Multi_linear(5)*X_Train(:,4) ;
Y_hat_Multi_linea_Test = b_Multi_linear(1) + b_Multi_linear(2)*X_Test(:,1) + b_Multi_linear(3)*X_Test(:,2) + b_Multi_linear(4)*X_Test(:,3) + b_Multi_linear(5)*X_Test(:,4) ;


figure
plot(Y_hat_Multi_linear_Train,Y_Train,'.')

figure
plot(Y_hat_Multi_linea_Test,Y_Test,'.')

% 计算训练期和测试期的RMSE
RMSE_Multi_Linear_linear_Train = sqrt(mean((Y_hat_Multi_linear_Train-Y_Train).^2));
RMSE_Multi_Linear_linear_Test = sqrt(mean((Y_hat_Multi_linea_Test-Y_Test).^2));

