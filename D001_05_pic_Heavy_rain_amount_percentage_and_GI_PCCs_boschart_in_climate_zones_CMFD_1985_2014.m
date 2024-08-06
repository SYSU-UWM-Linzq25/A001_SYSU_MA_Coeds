%% 这个文件根据CMFD历史时期（1985-2014年）计算得到的基尼系数和暴雨降水量占比的相关系数
%% 在气候区内的所有相关系数，箱型图

clear;clc;

% 读取四个气候区下，四个时间尺度下
% 基尼系数和暴雨降水量占比的数据
save_path = 'J:\6-硕士毕业论文\1-Data\PCCs-bewteen-Heavy-rain-features-and-GI\';
Temporal_scale_name = {'3h','6h','12h','1d'};
climate_zone_name = {'HR','TR','AR','TP'};

% 循环读取变量
for i = 1 : length(Temporal_scale_name)
    for j = 1 : length(climate_zone_name)
        filename2 = ['PCCs_GI_and_heavy_rain_amount_percentage_',Temporal_scale_name{i},'_',climate_zone_name{j},'.mat'];
        load([save_path,filename2])
    end
end

% 进行合并调整,按照气候区的放在一起
for j = 1 : length(climate_zone_name)
    for i = 1 : length(Temporal_scale_name)
        
        eval(['PCCs_',climate_zone_name{j},'_all(:,i) = PCCs_GI_and_heavy_rain_amount_percentage_',Temporal_scale_name{i},'_',climate_zone_name{j},''';'])
        eval(['P_',climate_zone_name{j},'_all(:,i) = P_GI_and_heavy_rain_amount_percentage_',Temporal_scale_name{i},'_',climate_zone_name{j},''';'])
    end
end
for j = 1 : length(climate_zone_name)
    eval(['PCCs_',climate_zone_name{j},'_all_mean = nanmean(PCCs_',climate_zone_name{j},'_all,1);'])
end
%% 直接画箱型图
%% 按照气候区的划分成四个小图
RGB = cbrewer('seq','YlOrRd',7,'linear');

plot_GAP_Len = 0.04; %图形之间的间隔
plot_GAP_High = 0.04; %图形之间的间隔
plot_Len = 0.4; % 图形的宽
plot_High = 0.3; % 图形的高

climate_zone_name_2 = {'HR','TR';'AR','TP'};
climate_zone_name_3 = {'湿润区','过渡区';'干旱区','高寒区'}
subplot_name = {'(a)','(b)';'(c)','(d)'};

figure1 = figure('Position', [1, 1, 1000, 1000],'paperpositionmode','auto');
Temporal_scale_name_2 = {'3-hour','6-hour','12-hour','1-day'};
for i = 1 : size(climate_zone_name_2,1)
    for j = 1 : size(climate_zone_name_2,1)
        eval(['B = rmoutliers(PCCs_',climate_zone_name_2{i,j},'_all,''percentiles'',[10 90]);'])
%         eval(['C = P_',climate_zone_name_2{i,j},'_all;'])
%         % B = rmoutliers(data1,"percentiles",[25 75]);
%         for m = 1 : size(C,2)
%             k1 = find(~isnan(C(:,m)));
%             k2 = find(C(:,m) < 0.05);
%             % 计算通过显著性检验的百分比
%             Percent_1(1,m) = length(k2)/length(k1) * 100;
%         end
        
        Bottom_pos = 0.55 - (i-1)*plot_High - (i-1)*plot_GAP_High;
        Left_pos = 0.1+(j-1)*plot_Len + (j-1)*plot_GAP_Len;
        % 先从底部的开始画
        ax1 = axes('pos',[Left_pos Bottom_pos plot_Len plot_High]);
        box_1 = boxplot(B,'positions',1:4,'colors',RGB(5,:),'width',0.18,'symbol','+','outliersize',3);
        box on
        set(gca,'linewidth',1)
        set(gca,'fontsize',13)
        set(gca,'fontname','Times new Roman')
        
        h = findobj(gca,'Tag','Box');
        set(h,'linewidth',1.5)
        LW = findobj(gca,'Tag','Lower Whisker');
        UW = findobj(gca,'Tag','Upper Whisker');
        Uav = findobj(gca,'Tag','Upper Adjacent Value');
        Lav = findobj(gca,'Tag','Lower Adjacent Value');
        M = findobj(gca,'Tag','Median');
        set(LW,'linewidth',1.5)
        set(UW,'linewidth',1.5)
        set(Uav,'linewidth',1.5)
        set(Lav,'linewidth',1.5)
        set(M,'linewidth',1.5)
        
        set(gca, 'YGrid', 'on')
        ylim([-1.1 1.1])
        set(gca,'ytick',-1:0.2:1)
        set(gca,'xticklabel',Temporal_scale_name_2)
        % 强制保留小数位数
        clear cb_tick Tick_label n
        cb_tick = get(gca,'ytick');
        Tick_label = cell(1,length(cb_tick));
        for n = 1 : length(cb_tick)
            Tick_label{1,n} = num2str(roundn(cb_tick(n),-1),'%4.1f');
        end
        set(gca,'yticklabel',Tick_label)
        
        % 右侧的列图不用纵坐标
        if j == 2
           set(gca,'yticklabel',[])
        end
        
        if i == 1
           set(gca,'xticklabel',[])
        end    
        
        
%         title(climate_zone_name_3{i,j},'fontname','宋体','fontsize',15,'HorizontalAlignment','left')
        text('string',subplot_name{i,j},'Units','normalized','position',[0.024,1.06],'fontsize',15,'FontName','times new Roman')
        text('string',climate_zone_name_3{i,j},'Units','normalized','position',[0.09,1.05],'fontsize',15,'FontName','宋体')
        clear b stats X1 Y1 xlim1 xlim2 X Y
    end
end



axes('visible','off');
% % 加底部横坐标
% text('string','年均温','Units','normalized','position',[0.44,-0.1],'fontsize',20,'FontName','宋体')
% text('string','(\circC)','Units','normalized','position',[0.55,-0.095],'fontsize',20,'FontName','Times new Roman')
% 加左侧横坐标
text('string','相关系数','Units','normalized','position',[-0.12,0.43],'fontsize',20,'FontName','宋体','Rotation',90)

% % 加左侧时间尺度标识
% text('string','3-hour','Units','normalized','position',[-0.13,0.85],'fontsize',25,'FontName','Times new Roman','Rotation',90)
% text('string','6-hour','Units','normalized','position',[-0.13,0.56],'fontsize',25,'FontName','Times new Roman','Rotation',90)
% text('string','12-hour','Units','normalized','position',[-0.13,0.27],'fontsize',25,'FontName','Times new Roman','Rotation',90)
% text('string','1-day','Units','normalized','position',[-0.13,0.01],'fontsize',25,'FontName','Times new Roman','Rotation',90)
%
%
% % 加顶部气候区标识
% text('string','湿润区','Units','normalized','position',[0.024,1.06],'fontsize',25,'FontName','宋体')
% text('string','过渡区','Units','normalized','position',[0.32,1.06],'fontsize',25,'FontName','宋体')
% text('string','干旱区','Units','normalized','position',[0.62,1.06],'fontsize',25,'FontName','宋体')
% text('string','高寒区','Units','normalized','position',[0.925,1.06],'fontsize',25,'FontName','宋体')
%
cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\008-03-PCCs-of-CMFD-heavy-rain-features-and-GI-1985-2014\')
exportgraphics(gcf,'历史时期基尼系数和暴雨降水量占比的相关系数箱形图.jpg')