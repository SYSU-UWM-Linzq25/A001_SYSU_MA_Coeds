%% 这个文件将综合性说明将选出来的三个最优模型集合平均后的结果明显更好
%% 使用到的方法包括：
%% 2.三个最优模型与CMFD基尼系数的RMSE+集合平均后的基尼系数与CMFD的RMSE（柱形图）
%% 有两种RMSE，一种是时间上的RMSE，另外一种是空间上的RMSE


clear;clc;

% 读取RMSE
clear filename2
filename2 = 'RMSE_of_CMFD_and_CMIP6_3_best_model_include_emsemble_GI_025_scale.mat';
load(['J:\6-硕士毕业论文\1-Data\RMSE_model_CMFD_CN051\',filename2])

% 把RMSE转为线型的
RMSE_model_1_line = reshape(RMSE_model_1,[1,size(RMSE_model_1,1)*size(RMSE_model_1,2)]);
RMSE_model_2_line = reshape(RMSE_model_2,[1,size(RMSE_model_2,1)*size(RMSE_model_2,2)]);
RMSE_model_3_line = reshape(RMSE_model_3,[1,size(RMSE_model_3,1)*size(RMSE_model_3,2)]);
RMSE_model_ensemble_line = reshape(RMSE_model_ensemble,[1,size(RMSE_model_ensemble,1)*size(RMSE_model_ensemble,2)]);

% 尝试绘制柱状图+误差棒

X = 1 : 1 : 4;
data1(:,1) = RMSE_model_1_line;
data1(:,2) = RMSE_model_2_line;
data1(:,3) = RMSE_model_3_line;
data1(:,4) = RMSE_model_ensemble_line;
data1_mean = nanmean(data1,1);

% 计算上下四分位数
data1_25(1,1) = prctile(data1(:,1),25);
data1_25(1,2) = prctile(data1(:,2),25);
data1_25(1,3) = prctile(data1(:,3),25);
data1_25(1,4) = prctile(data1(:,4),25);
data1_75(1,1) = prctile(data1(:,1),75);
data1_75(1,2) = prctile(data1(:,2),75);
data1_75(1,3) = prctile(data1(:,3),75);
data1_75(1,4) = prctile(data1(:,4),75);

AVG = data1_mean - data1_25;
STD = data1_75 - data1_mean;
data1_mean = data1_mean';
AVG = AVG';
STD = STD';

% 误差矩阵
% AVG = data1_mean/5; % 下方长度
% STD = data1_mean/7; % 上方长度
model_name_order = {'MPI-ESM1-2-HR','NorESM2-MM','MIROC6',''};


figure1 = figure('Position', [1, 1, 1000, 600],'paperpositionmode','auto');
GO = bar(X,data1_mean,1,'EdgeColor','k');
hold on

% 添加误差棒
[M,N] = size(data1_mean);
xpos = zeros(M,N);
for i = 1:N
    xpos(:,i) = GO(1,i).XEndPoints'; % v2019b
end
hE = errorbar(xpos, data1_mean, AVG, STD);
hold off
set(hE,'linestyle','none','linewidth',2)
set(GO,'Facecolor',[.1,.1,.2])
set(GO,'Barwidth',0.5,'linewidth',1)
set(gca, 'Box', 'on', ...                                         % 边框
         'XGrid', 'off', 'YGrid', 'off', ...                        % 网格
         'TickDir', 'in', 'TickLength', [.01 .01], ...            % 刻度
         'XMinorTick', 'off', 'YMinorTick', 'on', ...             % 小刻度
         'XColor', [.1 .1 .1],  'YColor', [.1 .1 .1],...           % 坐标轴颜色
         'YTick', 0:0.02:0.06,...                                      % 刻度位置、间隔
         'Ylim' , [0 0.06], ...                                     % 坐标轴范围
         'Xticklabel',model_name_order,...% X坐标轴刻度标签
         'fontname','Times new roman','fontsize',15,...
         'linewidth',2,...
         'Yticklabel',{[0:0.02:0.06]})    
ylabel('RMSE','fontname','Times new Roman','fontsize',20)     
text('string','集合平均','Units','normalized','position',[0.745,-0.038],  'FontSize',15,'FontName','宋体')


cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\002-04-02-Time-RMSE-Bar-CMIP6-His-and-CMFD\')
exportgraphics(gcf,'CMFD_and_Ensemble_average_His_GI_Latitude_Difference.jpg')


