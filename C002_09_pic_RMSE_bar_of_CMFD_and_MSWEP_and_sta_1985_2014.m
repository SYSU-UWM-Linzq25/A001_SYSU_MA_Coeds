%% 根据三种不同来源的基尼系数，计算得到逐个站点的RMSE
%% 根据RMSE进行画图

clear;clc;
filename2 = 'RMSE_of_sta_and_CMFD_MSWEP_1985_2014.mat';
load(['J:\6-硕士毕业论文\1-Data\Sta_Data_from_V3.0\',filename2])


color1=[46, 114, 188]/255;
color2=[0.9290 0.6940 0.1250];
color3 = [240, 60, 30]/255;

data_CMFD = nan(length(RMSE_sta_and_CMFD_12h),2);
data_CMFD(:,1) = RMSE_sta_and_CMFD_12h;
data_CMFD(:,2) = RMSE_sta_and_CMFD_1d;
data_MSWEP = nan(length(RMSE_sta_and_CMFD_12h),2);
data_MSWEP(:,1) = RMSE_sta_and_MSWEP_12h;
data_MSWEP(:,2) = RMSE_sta_and_MSWEP_1d;

figure('Position', [1, 1, 600, 600],'paperpositionmode','auto');
set (gca,'position',[0.18,0.18,0.77,0.77] );
position1 = [0.4:0.6:1];
position2 = [0.6:0.6:1.2];
box_1 = boxplot(data_CMFD,'positions',position1,'colors',color1,'width',0.1,'symbol','+','outliersize',3);
hold on
box_2 = boxplot(data_MSWEP,'positions',position2,'colors',color2,'width',0.1,'symbol','+','outliersize',3);
hold off
set(box_1,'LineWidth',2)
set(box_2,'LineWidth',2)

set(gca,'XTick',1.2:1.4:5.4,'ytick',0:0.05:0.25,'Xlim',[0 1.6],'Ylim',[-0.01 0.25]);
leg = findobj(gca,'Tag','Box'); % add legend
lgd = legend([box_1(3),box_2(3)], ["CMFD","MSWEP"]);
set(lgd,...
    'Location','north',...
    'LineWidth',2,...
    'FontSize',15,...
    'box','off',...
    'NumColumnsMode','manual','NumColumns',3,...
    'FontName','times new roman');
    %     'Position',[0.278472224867182 0.0333333427899832 0.519999988302589 0.08],...

set(gca,'linewidth',2)
set(gca,'fontsize',15)
set(gca,'xtick',[0.5,1.1])
set(gca,'xticklabel',{'12-hour','1-day'},'FontSize',20,'fontname','times new roman')
% openExample('graphics/UpdateColorOfBoxChartObjectExample')
% 强制保留纵坐标为1位小数
tick2 = get(gca,'ytick');
ticklabel2 = cell(1,length(tick2));
for i = 1 : length(ticklabel2)
ticklabel2{1,i} = num2str(roundn(tick2(i),-2),'%4.2f');
end
set(gca,'yticklabel',ticklabel2)

ylabel('RMSE','FontSize',20,'fontname','times new roman')
% xlabel('year','FontSize',40,'fontname','微软雅黑')

% % text('string','(a)12h','Units','normalized','position',[0.02,0.94],'fontsize',45,'FontName','微软雅黑')
cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\002-07-RMSE-of-CMFD-MSWEP-and-Sta\')
exportgraphics(gcf,'RMSE.jpg')