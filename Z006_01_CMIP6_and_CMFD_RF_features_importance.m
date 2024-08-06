
%% 这个文件根据CMIP6和CMFD建立的随机森林模型
%% 画出4个特征的重要性
%% 进行比较

clear;clc;
path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\RamdomForest-master\RamdomForest-master\')

% 历史时期的模型
load('J:\6-硕士毕业论文\1-Data\CMFD\10-4-RF-models-025-scale\multiyear_mean\RF_model_CN_1d_025_scale_multiyear_mean.mat')
model_His = model;
clearvars -except model_His

% SSP126
load('J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\10-3-RF-models-025-scale-CMIP6-2031-2060\RF_model_CN_1d_025_scale_multiyear_mean_CMIP6_SSP126.mat')

% SSP245
load('J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\10-3-RF-models-025-scale-CMIP6-2031-2060\RF_model_CN_1d_025_scale_multiyear_mean_CMIP6_SSP245.mat')

% SSP370
load('J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\10-3-RF-models-025-scale-CMIP6-2031-2060\RF_model_CN_1d_025_scale_multiyear_mean_CMIP6_SSP370.mat')

% SSP585
load('J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\10-3-RF-models-025-scale-CMIP6-2031-2060\RF_model_CN_1d_025_scale_multiyear_mean_CMIP6_SSP585.mat')

%% 特征重要性

X_His = 1 : 6 : 19;
X_SSP126 = 2 : 6 : 20;
X_SSP245 = 3 : 6 : 21;
X_SSP370 = 4 : 6 : 22;
X_SSP585 = 5 : 6 : 23;
model_name_order = {'经度','纬度','年均温','年降水量'};

figure1 = figure('Position', [1, 1, 1000, 600],'paperpositionmode','auto');
GO_His = bar(X_His,model_His.importance(:,end-1),1,'EdgeColor','k');
hold on
GO_SSP126 = bar(X_SSP126,model_ssp126.importance(:,end-1),1,'EdgeColor','k');
hold on
GO_SSP245 = bar(X_SSP245,model_ssp245.importance(:,end-1),1,'EdgeColor','k');
hold on
GO_SSP370 = bar(X_SSP370,model_ssp370.importance(:,end-1),1,'EdgeColor','k');
hold on
GO_SSP585 = bar(X_SSP585,model_ssp585.importance(:,end-1),1,'EdgeColor','k');
hold off

RGB = cbrewer('seq','Purples',8,'linear');

set(GO_His, 'Facecolor', RGB(3,:)) % 橙色
set(GO_SSP126, 'Facecolor', RGB(4,:)) % 深橙色
set(GO_SSP245, 'Facecolor', RGB(5,:)) % 红色
set(GO_SSP370, 'Facecolor', RGB(6,:)) % 深红色
set(GO_SSP585, 'Facecolor', RGB(7,:)) % 深红色

set(GO_His,'Barwidth',0.163,'linewidth',1)
set(GO_SSP126,'Barwidth',0.163,'linewidth',1)
set(GO_SSP245,'Barwidth',0.163,'linewidth',1)
set(GO_SSP370,'Barwidth',0.163,'linewidth',1)
set(GO_SSP585,'Barwidth',0.163,'linewidth',1)

set(gca, 'Box', 'on', ...                                         % 边框
    'XGrid', 'off', 'YGrid', 'on', ...                        % 网格
    'TickDir', 'in', 'TickLength', [.01 .01], ...            % 刻度
    'XMinorTick', 'off', 'YMinorTick', 'on', ...             % 小刻度
    'XColor', [.1 .1 .1],  'YColor', [.1 .1 .1],...           % 坐标轴颜色
    'XTick', 3:6:21,...                                      % 刻度位置、间隔
    'Xlim' , [-1 25], ...                                     % 坐标轴范围
    'fontname','Times new roman','fontsize',15,...
    'linewidth',2)

lgd = legend([GO_His,GO_SSP126,GO_SSP245,GO_SSP370,GO_SSP585],'CMFD','SSP126','SSP245','SSP370','SSP585','fontname','Times new roman','fontsize',20,'location','northwest');
set(lgd,'box','on')

set(gca,'Xticklabel',model_name_order,'fontname','宋体','fontsize',15)

% 强制保留小数位数
clear cb_tick Tick_label n
cb_tick = get(gca,'ytick');
Tick_label = cell(1,length(cb_tick));
for n = 1 : length(cb_tick)
    Tick_label{1,n} = num2str(roundn(cb_tick(n)*1000,-1),'%4.1f');
end
set(gca,'yticklabel',Tick_label)
text('string','×10^{-3}','Units','normalized','position',[0.008,1.04],'fontsize',15,'FontName','Times new Roman')

ylabel('重要性程度','fontname','宋体','fontsize',20)
xlabel('特征','fontname','宋体','fontsize',20)

cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\013-01-importance-of-features\')
exportgraphics(gcf,'不同随机森林模型下的特征重要性.jpg')