%% 这个文件根据CMFD历史时期（1985-2014年）计算的中雨时段数和年降水量的关系
%% 画散点关系图
%% 在四个气候区分别画

clear;clc;

% 读取四个时间尺度下
% 中雨时段数的数据
% 四个时间尺度+四个气候区
cd('J:\6-硕士毕业论文\1-Data\CMFD\9-4-GI-and-Moderate-rain-features-in-climate-zones\')
Temporal_scale_name = {'3h','6h','12h','1d'};
climate_zone_name = {'HR','TR','AR','TP'};
for i = 1 : length(Temporal_scale_name)
    for j = 1 : length(climate_zone_name)
        filename = ['GI_and_Moderate_rain_intervals_',Temporal_scale_name{i},'_',climate_zone_name{j}];
        load(filename)
        clear filename
        
        % 计算区域平均
        eval(['Moderate_rain_intervals_Areamean_',Temporal_scale_name{i},'_',climate_zone_name{j},' = nanmean(Moderate_rain_intervals_',Temporal_scale_name{i},'_',climate_zone_name{j},',2);'])
    end
end

% 根据气候区进行划分
% 读取气候分区的index
load(['J:\6-硕士毕业论文\1-Data\Climate_zone_index\', 'Four_Climite_zone_index_01_scale.mat'])
% 提取气候区的索引
k_HR = find(Four_climate_zone_index_01 == 1);
k_TR = find(Four_climate_zone_index_01 == 2);
k_AR = find(Four_climate_zone_index_01 == 3);
k_TP = find(Four_climate_zone_index_01 == 4);

% 读取年降水量数据集
clear filename2
filename2 = 'AP_3h_01mmh_1979_2018.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\5-1-CMFD-01-scale-AP-and-MAT-01mmh\',filename2]);
AP_01mmh_1985_2014 = Annual_Pr_3h_01mmh(:,:,7:end-4);
clear Annual_Pr_3h_01mmh

AP_HR_Areamean_all = nan(size(AP_01mmh_1985_2014,3),1);
AP_TR_Areamean_all = nan(size(AP_01mmh_1985_2014,3),1);
AP_AR_Areamean_all = nan(size(AP_01mmh_1985_2014,3),1);
AP_TP_Areamean_all = nan(size(AP_01mmh_1985_2014,3),1);
% 计算年降水量的区域平均
for year = 1 : size(AP_01mmh_1985_2014,3)
    AP_year = AP_01mmh_1985_2014(:,:,year);
    
    AP_HR_year = AP_year(k_HR);
    AP_TR_year = AP_year(k_TR);
    AP_AR_year = AP_year(k_AR);
    AP_TP_year = AP_year(k_TP);
    
    % 求区域平均
    AP_HR_Areamean_all(year,1) = nanmean(nanmean(AP_HR_year,1));
    AP_TR_Areamean_all(year,1) = nanmean(nanmean(AP_TR_year,1));
    AP_AR_Areamean_all(year,1) = nanmean(nanmean(AP_AR_year,1));
    AP_TP_Areamean_all(year,1) = nanmean(nanmean(AP_TP_year,1));
    clear AP_HR_year AP_TR_year AP_AR_year AP_TP_year
end


%% 直接画散点图
%% 按照时间尺度和气候区划分成16个小图
%% 再根据结果进行筛选
RGB = cbrewer('seq','YlOrRd',7,'linear');

Temp_CN_limit = [150 220];

plot_GAP_Len = 0.06; %图形之间的间隔
plot_GAP_High = 0.04; %图形之间的间隔
plot_Len = 0.17; % 图形的宽
plot_High = 0.16; % 图形的高

% 设置横纵坐标轴的范围
Temp_HR_limit = [1000 1470];
Temp_TR_limit = [400 700];
Temp_AR_limit = [100 250];
Temp_TP_limit = [200 400];

GI_limit = cell(4,4);
GI_limit{1,1} = [200,280];
GI_limit{2,1} = [150,220];
GI_limit{3,1} = [100,160];
GI_limit{4,1} = [60,120];

GI_limit{1,2} = [95,150];
GI_limit{2,2} = [60,120];
GI_limit{3,2} = [40,100];
GI_limit{4,2} = [20,80];

GI_limit{1,3} = [180,360];
GI_limit{2,3} = [150,250];
GI_limit{3,3} = [100,160];
GI_limit{4,3} = [75,110];

GI_limit{1,4} = [300,700];
GI_limit{2,4} = [250,500];
GI_limit{3,4} = [170,300];
GI_limit{4,4} = [130,185];

subplot_name = cell(4,4);
subplot_name{1,1} = '(d)';
subplot_name{2,1} = '(h)';
subplot_name{3,1} = '(l)';
subplot_name{4,1} = '(p)';

subplot_name{1,2} = '(c)';
subplot_name{2,2} = '(g)';
subplot_name{3,2} = '(k)';
subplot_name{4,2} = '(o)';

subplot_name{1,3} = '(b)';
subplot_name{2,3} = '(f)';
subplot_name{3,3} = '(j)';
subplot_name{4,3} = '(n)';

subplot_name{1,4} = '(a)';
subplot_name{2,4} = '(e)';
subplot_name{3,4} = '(i)';
subplot_name{4,4} = '(m)';

figure1 = figure('Position', [1, 1, 1000, 1000],'paperpositionmode','auto');
for i = 1 : 4 % 行
    for j = 1 : 4 % 列
        
%         % 做拟合线
        eval(['xlim1 = min(Temp_',climate_zone_name{5-j},'_limit);'])
        eval(['xlim2 = max(Temp_',climate_zone_name{5-j},'_limit);'])
        eval(['X = [ones(length(AP_',climate_zone_name{5-j},'_Areamean_all),1),AP_',climate_zone_name{5-j},'_Areamean_all];'])
        eval(['Y = Moderate_rain_intervals_Areamean_',Temporal_scale_name{i},'_',climate_zone_name{5-j},';'])
        [b,~,~,~,stats] = regress(Y,X,0.05);
        % 设定x轴范围
        X1 = xlim1 : 10 : xlim2;
        Y1 = b(1) + b(2)*X1;

        Bottom_pos = 0.07+(4-i)*plot_High + (4-i)*plot_GAP_High;
        Left_pos = 0.12+(4-j)*plot_Len + (4-j)*plot_GAP_Len;
        % 先从底部的开始画
        ax1 = axes('pos',[Left_pos Bottom_pos plot_Len plot_High]);
%         eval(['plot(AP_',climate_zone_name{5-j},',GI_',Temporal_scale_name{i},'_',climate_zone_name{5-j},',''k.'')'])
        eval(['scatter(AP_',climate_zone_name{5-j},'_Areamean_all,Moderate_rain_intervals_Areamean_',Temporal_scale_name{i},'_',climate_zone_name{5-j},',15,''k'',''filled'')'])
        hold on
        if b(2) > 0
        plot(X1,Y1,'r--','linewidth',2);
        elseif b(2) < 0
        plot(X1,Y1,'b--','linewidth',2);
        end
        hold off
        box on
        set(gca,'linewidth',1)
        set(gca,'fontsize',13)
        set(gca,'fontname','Times new Roman')
        
        % 设置横纵坐标限制
        if j == 4 % HR
           xlim(Temp_HR_limit)
        elseif j == 3 % TR
           xlim(Temp_TR_limit)
        elseif j == 2 % AR
           xlim(Temp_AR_limit)
        elseif j == 1 % TP
           xlim(Temp_TP_limit)
        end
        ylim(GI_limit{i,j})
        
        % 强制保留小数位数
        clear cb_tick Tick_label n
        cb_tick = get(ax1,'ytick');
        Tick_label = cell(1,length(cb_tick));
        for n = 1 : length(cb_tick)
            Tick_label{1,n} = num2str(roundn(cb_tick(n),0),'%4.0f');
        end
        set(ax1,'yticklabel',Tick_label)
        
        clear cb_tick Tick_label n
        cb_tick = get(ax1,'xtick');
        Tick_label = cell(1,length(cb_tick));
        for n = 1 : length(cb_tick)
            Tick_label{1,n} = num2str(roundn(cb_tick(n),0),'%4.0f');
        end
        set(ax1,'xticklabel',Tick_label)
        
        if i ~= 4
            set(gca,'xticklabel',[])
        end
%         
        % 加title，标子图标题+拟合线
        if stats(3) < 0.05
            text('string',[' K* = ',num2str(roundn(b(2),-2),'%4.2f'),'mm^{-1}'],'Units','normalized','position',[0.17,1.11],'fontsize',15,'FontName','times new Roman')
        else
            text('string',[' K = ',num2str(roundn(b(2),-2),'%4.2f'),'mm^{-1}'],'Units','normalized','position',[0.17,1.11],'fontsize',15,'FontName','times new Roman')
        end
        text('string',subplot_name{i,j},'Units','normalized','position',[-0.015,1.11],'fontsize',15,'FontName','times new Roman')
%             text('string',num2str(roundn(stats(3),-2),'%4.2f'),'Units','normalized','position',[0.12,0.5],'fontsize',15,'FontName','times new Roman')
%             text('string',num2str(roundn(stats(1),-4),'%4.4f'),'Units','normalized','position',[0.12,0.3],'fontsize',15,'FontName','times new Roman')
        clear b stats X1 Y1 xlim1 xlim2 X Y
    end
end
axes('visible','off');
% 加底部横坐标
text('string','年降水量','Units','normalized','position',[0.42,-0.1],'fontsize',20,'FontName','宋体')
text('string','(mm)','Units','normalized','position',[0.56,-0.095],'fontsize',20,'FontName','Times new Roman')
% 加左侧横坐标
text('string','中等程度降雨年时段数','Units','normalized','position',[-0.08,0.26],'fontsize',20,'FontName','宋体','Rotation',90)

% 加左侧时间尺度标识
text('string','3-hour','Units','normalized','position',[-0.13,0.73],'fontsize',25,'FontName','Times new Roman','Rotation',90)
text('string','6-hour','Units','normalized','position',[-0.13,0.48],'fontsize',25,'FontName','Times new Roman','Rotation',90)
text('string','12-hour','Units','normalized','position',[-0.13,0.23],'fontsize',25,'FontName','Times new Roman','Rotation',90)
text('string','1-day','Units','normalized','position',[-0.13,0.001],'fontsize',25,'FontName','Times new Roman','Rotation',90)


% 加顶部气候区标识
text('string','湿润区','Units','normalized','position',[0.024,0.94],'fontsize',25,'FontName','宋体')
text('string','过渡区','Units','normalized','position',[0.33,0.94],'fontsize',25,'FontName','宋体')
text('string','干旱区','Units','normalized','position',[0.62,0.94],'fontsize',25,'FontName','宋体')
text('string','高寒区','Units','normalized','position',[0.925,0.94],'fontsize',25,'FontName','宋体')

cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\008-05-scatter-of-moderate-rain-features-and-AP-in-climate-zones-1985-2014\')
exportgraphics(gcf,'历史时期中等程度降雨时段数和年降水量的散点拟合关系图.jpg')