%% 这个文件分析年降水量对降水集中度的影响实现途径
%% 中雨降水时段数
%% 对象为CMIP6未来时期，2031-2060年
%% 首先是不同情境下，不同气候区的年降水量和中雨时段数的关系散点图

clear;clc;

SSP_type = {'ssp126','ssp245','ssp370','ssp585'};

% 读取中雨时段数(逐年取集合平均)
cd('J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\10-1-30a-all-pre-R95\Model_ensemble_Heavy_rain_percentage_and_Moderate_rain_intervals_3D_matrix\annual\')

for j = 1 : length(SSP_type)
    
    filename2 = [SSP_type{j},'three_models_ensemble_yearly_moderate_rain_intervals_025_scale_pre_event_thresold_5_95_matrix.mat'];
    load(filename2)
    
    eval(['Moderate_rain_intervals_year_ensemble_',SSP_type{j},'_2D = reshape(Moderate_rain_intervals_year_ensemble,[],size(Moderate_rain_intervals_year_ensemble,3));']);
    clear heavy_rain_amount_percentage_year_ensemble
    
    % 计算全国区域平均
    eval(['Moderate_rain_intervals_year_',SSP_type{j},'_Areamean = nanmean(Moderate_rain_intervals_year_ensemble_',SSP_type{j},'_2D,1)'';'])
    %     eval(['clear Moderate_rain_intervals_year_ensemble_',SSP_type{j},'_2D'])
end

% 读取不同情景下的基尼系数逐年集合平均
for j = 1 : length(SSP_type)
    filename2 = [SSP_type{j},'_3_Model_ensemble_annual_GI_025_scale_CN_2031_2060.mat'];
    load(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\7-4-future-025-ensemble-annual-GI\',filename2])
    
    eval(['GI_ensemble_',SSP_type{j},'_2D = reshape(Model_GI_3_model_ensemble_annual,[],size(Model_GI_3_model_ensemble_annual,3));'])
    clear Model_GI_3_model_ensemble_annual
    
    % 计算全国区域平均
    eval(['GI_ensemble_',SSP_type{j},'_Areamean = nanmean(GI_ensemble_',SSP_type{j},'_2D,1)'';'])
    %     eval(['clear GI_ensemble_',SSP_type{j},'_2D'])
end

% 在全国的区域平均求基尼系数和中等程度降雨时段数的相关系数
for j = 1 : length(SSP_type)
    eval(['[PCCs_1,P_1] = corrcoef(Moderate_rain_intervals_year_',SSP_type{j},'_Areamean,GI_ensemble_',SSP_type{j},'_Areamean);'])
    eval(['PCCs_CN_',SSP_type{j},' = PCCs_1(2);'])
    eval(['P_CN_',SSP_type{j},' = P_1(2);'])
end


% 读取未来时期不同情景下的年降水量逐年集合平均结果

for j = 1 : length(SSP_type)
    filename2 = [SSP_type{j},'_3_Model_ensemble_annual_AP_025_scale_CN_2031_2060.mat'];
    load(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\6-3-future-025-scale-ensemble-annual-MAT-AP\',filename2])
    
    eval(['AP_ensemble_',SSP_type{j},'_2D = reshape(Model_AP_3_model_ensemble_annual,[],size(Model_AP_3_model_ensemble_annual,3));'])
    clear Model_AP_3_model_ensemble_annual
    
    % 计算全国区域平均
    %     eval(['AP_ensemble_',SSP_type{j},'_Areamean = nanmean(AP_ensemble_',SSP_type{j},'_2D,1)'';'])
    %     eval(['clear AP_ensemble_',SSP_type{j},'_2D'])
end

% 划分气候区

% 读取气候分区信息，重新划分
% 读取气候分区的index
load(['J:\6-硕士毕业论文\1-Data\Climate_zone_index\', 'Four_Climite_zone_index_025_scale.mat'])
Four_climate_zone_index_025_line = reshape(Four_climate_zone_index_025,[length(Lon_025)*length(Lat_025),1]);
% 提取气候区的索引(按单列的做)
k_HR = find(Four_climate_zone_index_025_line == 1);
k_TR = find(Four_climate_zone_index_025_line == 2);
k_AR = find(Four_climate_zone_index_025_line == 3);
k_TP = find(Four_climate_zone_index_025_line == 4);
% clear Four_climate_zone_index_025_line

climate_zone_name = {'HR','TR','AR','TP'};

for j = 1 : length(SSP_type)
    for i = 1 : length(climate_zone_name)
        eval(['AP_ebsemble_',SSP_type{j},'_',climate_zone_name{i},'_Areamean = nanmean(AP_ensemble_',SSP_type{j},'_2D(k_',climate_zone_name{i},',:),1)'';'])
        eval(['Moderate_rain_intervals_',SSP_type{j},'_',climate_zone_name{i},'_Areamean = nanmean(Moderate_rain_intervals_year_ensemble_',SSP_type{j},'_2D(k_',climate_zone_name{i},',:),1)'';'])
    end
end

%% 直接画散点图
%% 按照时间尺度和气候区划分成16个小图
%% 再根据结果进行筛选
RGB = cbrewer('seq','YlOrRd',7,'linear');

plot_GAP_Len = 0.06; %图形之间的间隔
plot_GAP_High = 0.06; %图形之间的间隔
plot_Len = 0.17; % 图形的宽
plot_High = 0.16; % 图形的高

% 设置横纵坐标轴的范围

AP_limit = cell(4,4);
AP_limit{1,1} = [790,880];
AP_limit{2,1} = [780,870];
AP_limit{3,1} = [750,890];
AP_limit{4,1} = [780,930];

AP_limit{1,2} = [280,380];
AP_limit{2,2} = [280,380];
AP_limit{3,2} = [280,380];
AP_limit{4,2} = [300,380];

AP_limit{1,3} = [730,920];
AP_limit{2,3} = [730,900];
AP_limit{3,3} = [700,900];
AP_limit{4,3} = [700,1000];

AP_limit{1,4} = [1400,1900];
AP_limit{2,4} = [1400,1800];
AP_limit{3,4} = [1360,1700];
AP_limit{4,4} = [1400,1750];


GI_limit = cell(4,4);
GI_limit{1,1} = [76,84];
GI_limit{2,1} = [75,82];
GI_limit{3,1} = [73,85];
GI_limit{4,1} = [73,87];

GI_limit{1,2} = [30,37];
GI_limit{2,2} = [28,38];
GI_limit{3,2} = [29,38];
GI_limit{4,2} = [30,39];

GI_limit{1,3} = [57,72];
GI_limit{2,3} = [60,72];
GI_limit{3,3} = [55,70];
GI_limit{4,3} = [57,73];

GI_limit{1,4} = [105,125];
GI_limit{2,4} = [100,120];
GI_limit{3,4} = [100,117];
GI_limit{4,4} = [103,122];

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
        
        % 做拟合线
        eval(['xlim1 = min(AP_limit{i,j});'])
        eval(['xlim2 = max(AP_limit{i,j});'])
        eval(['X = [ones(length(AP_ebsemble_',SSP_type{i},'_',climate_zone_name{5-j},'_Areamean),1),AP_ebsemble_',SSP_type{i},'_',climate_zone_name{5-j},'_Areamean];'])
        eval(['Y = Moderate_rain_intervals_',SSP_type{i},'_',climate_zone_name{5-j},'_Areamean;'])
        [b,~,~,~,stats] = regress(Y,X,0.05);
        % 设定x轴范围
        X1 = xlim1 : 10 : xlim2;
        Y1 = b(1) + b(2)*X1;
        
        Bottom_pos = 0.07+(4-i)*plot_High + (4-i)*plot_GAP_High;
        Left_pos = 0.12+(4-j)*plot_Len + (4-j)*plot_GAP_Len;
        % 先从底部的开始画
        ax1 = axes('pos',[Left_pos Bottom_pos plot_Len plot_High]);
        %         eval(['plot(AP_',climate_zone_name{5-j},',GI_',Temporal_scale_name{i},'_',climate_zone_name{5-j},',''k.'')'])
        eval(['scatter(AP_ebsemble_',SSP_type{i},'_',climate_zone_name{5-j},'_Areamean,Moderate_rain_intervals_',SSP_type{i},'_',climate_zone_name{5-j},'_Areamean,15,''k'',''filled'')'])
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
        
        %         % 强制保留小数位数
        %         clear cb_tick Tick_label n
        %         cb_tick = get(ax1,'ytick');
        %         Tick_label = cell(1,length(cb_tick));
        %         for n = 1 : length(cb_tick)
        %             Tick_label{1,n} = num2str(roundn(cb_tick(n),0),'%4.0f');
        %         end
        %         set(ax1,'yticklabel',Tick_label)
        %
        %         clear cb_tick Tick_label n
        %         cb_tick = get(ax1,'xtick');
        %         Tick_label = cell(1,length(cb_tick));
        %         for n = 1 : length(cb_tick)
        %             Tick_label{1,n} = num2str(roundn(cb_tick(n),0),'%4.0f');
        %         end
        %         set(ax1,'xticklabel',Tick_label)
        
        %         % 设置横纵坐标限制
        %         if j == 4 % HR
        %             xlim(Temp_HR_limit)
        %         elseif j == 3 % TR
        %             xlim(Temp_TR_limit)
        %         elseif j == 2 % AR
        %             xlim(Temp_AR_limit)
        %         elseif j == 1 % TP
        %             xlim(Temp_TP_limit)
        %         end

        %         if i ~= 4
        %             set(gca,'xticklabel',[])
        %         end
        %         ylim(GI_limit{i,j})
        %
        % 加title，标子图标题+拟合线
        if stats(3) < 0.05
            text('string',[' K* = ',num2str(roundn(b(2),-3),'%4.3f'),'mm^{-1}'],'Units','normalized','position',[0.11,1.11],'fontsize',15,'FontName','times new Roman')
        else
            text('string',[' K = ',num2str(roundn(b(2),-3),'%4.3f'),'mm^{-1}'],'Units','normalized','position',[0.11,1.11],'fontsize',15,'FontName','times new Roman')
        end
        text('string',subplot_name{i,j},'Units','normalized','position',[0.04,0.92],'fontsize',15,'FontName','times new Roman')
        
        clear b stats X1 Y1 xlim1 xlim2 X Y
    end
end
axes('visible','off');
% 加底部横坐标
text('string','年降水量','Units','normalized','position',[0.42,-0.1],'fontsize',20,'FontName','宋体')
text('string','(mm)','Units','normalized','position',[0.56,-0.095],'fontsize',20,'FontName','Times new Roman')
% 加左侧横坐标
text('string','中等程度降雨年时段数','Units','normalized','position',[-0.08,0.3],'fontsize',20,'FontName','宋体','Rotation',90)

% 加左侧时间尺度标识
text('string','SSP1-2.6','Units','normalized','position',[-0.13,0.79],'fontsize',25,'FontName','Times new Roman','Rotation',90)
text('string','SSP2-4.5','Units','normalized','position',[-0.13,0.5],'fontsize',25,'FontName','Times new Roman','Rotation',90)
text('string','SSP3-7.0','Units','normalized','position',[-0.13,0.23],'fontsize',25,'FontName','Times new Roman','Rotation',90)
text('string','SSP5-8.5','Units','normalized','position',[-0.13,-0.03],'fontsize',25,'FontName','Times new Roman','Rotation',90)


% 加顶部气候区标识
text('string','湿润区','Units','normalized','position',[0.024,1.01],'fontsize',25,'FontName','宋体')
text('string','过渡区','Units','normalized','position',[0.33,1.01],'fontsize',25,'FontName','宋体')
text('string','干旱区','Units','normalized','position',[0.62,1.01],'fontsize',25,'FontName','宋体')
text('string','高寒区','Units','normalized','position',[0.925,1.01],'fontsize',25,'FontName','宋体')

cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\008-08-scatter-of-CMIP6-moderate-rain-features-and-AP-in-climate-zones-2031-2060\')
exportgraphics(gcf,'未来时期中等程度降雨时段数和年降水量的散点拟合关系图.jpg')