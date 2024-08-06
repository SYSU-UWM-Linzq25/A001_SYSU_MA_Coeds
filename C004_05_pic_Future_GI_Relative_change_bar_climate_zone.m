%% 这个文件根据前面计算的未来时期不同情景下降水基尼系数的相对变化率
%% 在不同的气候区，画柱状组合图

clear;clc;
path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')

% % 读取年降水量相对变化在4个气候区的情况（未×100）
% for j = 1 : length(SSP_type)
%     clear filename2
%     filename2 = ['Percentage_change_',SSP_type{j},'_2031_2060_025_scale_climatic_AP_climate_zone.mat'];
%     load(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\9-6-Relative-cahnge-of-Future-and-His-AP\分气候区\',filename2])
% end
% 
% % 读取年均温相对变化在4个气候区的情况（未×100）
% for j = 1 : length(SSP_type)
%     clear filename2
%     filename2 = ['MAT_Percentage_change_',SSP_type{j},'_2031_2060_025_scale_climatic_MAT_climate_zone.mat'];
%     load(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\9-5-Relative-change-of-Future-and-His-MAT\分气候区\',filename2])
% end
Climate_zone = {'HR','TR','AR','TP'};
SSP_type = {'ssp126','ssp245','ssp370','ssp585'};

% GI的相对变化
for j = 1 : length(SSP_type)
    save_peth_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\9-1-Relative-change-percent-of-Future-and-His_Gi\分气候区\';
    cd(save_peth_1)
    filename_1 = ['Relative_change_percent_',SSP_type{j},'_2031_2060_025_scale_climatic_GI_climate_zone.mat'];
    load(filename_1)
end

% 按照不同情景合并在一起
for j = 1 : length(SSP_type)
    for i = 1 : length(Climate_zone)
        eval(['data_',SSP_type{j},'(:,i) = nanmean(GI_Relative_change_percent_',SSP_type{j},'_2031_2060_',Climate_zone{i},'*100);'])
    end
end

% 计算上下四分位数
for j = 1 : length(SSP_type)
    for i = 1 : length(Climate_zone)
        eval(['data_',SSP_type{j},'_25(:,i) = prctile(GI_Relative_change_percent_',SSP_type{j},'_2031_2060_',Climate_zone{i},'*100,25);'])
        eval(['data_',SSP_type{j},'_75(:,i) = prctile(GI_Relative_change_percent_',SSP_type{j},'_2031_2060_',Climate_zone{i},'*100,75);'])
    end
end

% AVG1 = data_ssp126 - data_ssp126_25;
% STD1 = data_ssp126_75 - data_ssp126;
% AVG2 = data_ssp245 - data_ssp245_25;
% STD2 = data_ssp245_75 - data_ssp245;
% AVG3 = data_ssp370 - data_ssp370_25;
% STD3 = data_ssp370_75 - data_ssp370;
% AVG4 = data_ssp585 - data_ssp585_25;
% STD4 = data_ssp585_75 - data_ssp585;
% 
% data_ssp126 = data_ssp126';
% data_ssp245 = data_ssp245';
% data_ssp370 = data_ssp370';
% data_ssp585 = data_ssp585';
% 
% AVG1 = AVG1';
% STD1 = STD1';
% AVG2 = AVG2';
% STD2 = STD2';
% AVG3 = AVG3';
% STD3 = STD3';
% AVG4 = AVG4';
% STD4 = STD4';

X1 = 1 : 2.5 : 8.5;
X2 = 1.5 : 2.5 : 9;
X3 = 2 : 2.5 : 9.5;
X4 = 2.5 : 2.5 : 10;

% 
figure1 = figure('Position', [1, 1, 1000, 600],'paperpositionmode','auto');
GO1 = bar(X1,data_ssp126,1,'EdgeColor','k');
hold on
GO2 = bar(X2,data_ssp245,1,'EdgeColor','k');
hold on
GO3 = bar(X3,data_ssp370,1,'EdgeColor','k');
hold on
GO4 = bar(X4,data_ssp585,1,'EdgeColor','k');
hold off

xlim([0.3 10.7])
set(gca, 'XTick', []); 
set(gca, 'XColor', 'none');
set(GO1,'Barwidth',0.2,'linewidth',1)
set(GO2,'Barwidth',0.2,'linewidth',1)
set(GO3,'Barwidth',0.2,'linewidth',1)
set(GO4,'Barwidth',0.2,'linewidth',1)

set(GO1,'Facecolor',[107, 174, 214]/255)
set(GO2,'Facecolor',[ 66, 146, 198]/255)
set(GO3,'Facecolor',[33, 113, 181]/255)
set(GO4,'Facecolor',[8, 69, 148]/255)

legend([GO1,GO2,GO3,GO4],'SSP1-2.6','SSP2-4.5','SSP3-7.0','SSP5-8.5', 'FontSize',20,'FontName','Times new roman')

box off

text('string','湿润区','position',[1.4,-0.08], 'FontSize',20,'FontName','宋体')
text('string','过渡区','position',[3.7,0.08], 'FontSize',20,'FontName','宋体')
text('string','干旱区','position',[6.2,0.08], 'FontSize',20,'FontName','宋体')
text('string','高寒区','position',[8.7,0.08], 'FontSize',20,'FontName','宋体')

% 强制保留小数位数
clear cb_tick Tick_label n
cb_tick = get(gca,'ytick');
Tick_label = cell(1,length(cb_tick));
for n = 1 : length(cb_tick)
    Tick_label{1,n} = num2str(roundn(cb_tick(n),-2),'%4.2f');
end
set(gca,'yticklabel',Tick_label,'fontname','Times new roman','fontsize',15)
set(gca,'Linewidth',1.5)

ylabel('相对变化率','fontname','宋体', 'FontSize',20)
text('string','(e)','Units','normalized','position',[0.02,0.95],'fontsize',25,'FontName','Times new Roman')
text('string','(%)','Units','normalized','position',[-0.094,0.64],'fontsize',20,'FontName','Times new Roman','Rotation',90)

cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\004-01-CMIP6-Future-and-His-GI-Relative-change-percent\')
exportgraphics(gcf,'未来时期和历史时期对比的降水集中度相对变化率.jpg')

% close all