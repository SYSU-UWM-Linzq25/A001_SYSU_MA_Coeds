%% 这个文件开始尝试建立随机森林回归模型
%% 使用的是时间分辨率为1d
%% 空间分辨率为0.25°
%% 逐年
%% 全国一整个模型

clear;clc;
cd('J:\6-硕士毕业论文\1-Data\CMFD\10-3-Dataset-for-RF-regression-025-scale\annual\')
load('RF_Dataset_for_1d_025_scale_GI_annual_CN.mat')

path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\RamdomForest-master\RamdomForest-master\')


% 尝试先用前面得10w个训练

X_Train_1 = X_Train(1:100000,:);
Y_Train_1 = Y_Train(1:100000);


clear extra_options
extra_options.importance = 1; %(0 = (Default) Don't, 1=calculate)
model = regRF_train(X_Train_1,Y_Train_1, 200, 4, extra_options); % 200颗差不多了
Y_hat = regRF_predict(X_Test,model);

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
% 
% filename2 = 'RF_model_CN_1d_025_scale_multiyear_mean.mat';
% save(['J:\6-硕士毕业论文\1-Data\CMFD\10-4-RF-models-025-scale\multiyear_mean\',filename2], 'model')
% 
figure
plot(Y_hat,Y_Test,'b.')




