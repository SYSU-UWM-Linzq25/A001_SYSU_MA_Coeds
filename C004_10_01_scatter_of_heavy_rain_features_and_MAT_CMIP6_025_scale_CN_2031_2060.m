%% 这个文件计算暴雨的不同特征对降水集中度的影响
%% 包括暴雨的降水量占比
%% 对象为CMIP6未来时期，2031-2060年
%% 集合平均下的降水集中度和暴雨降水量占比

clear;clc;

% 读取未来时期集合平均的年均温(逐年取集合平均)
SSP_type = {'ssp126','ssp245','ssp370','ssp585'};

for j = 1 : length(SSP_type)
    filename2 = [SSP_type{j},'_3_Model_ensemble_annual_MAT_025_scale_CN_2031_2060.mat'];
    load(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\6-3-future-025-scale-ensemble-annual-MAT-AP\',filename2])
    
    eval(['MAT_ensemble_',SSP_type{j},'_2D = reshape(Model_MAT_3_model_ensemble_annual,[],size(Model_MAT_3_model_ensemble_annual,3));'])
    clear Model_MAT_3_model_ensemble_annual
    
    % 计算全国区域平均
    eval(['MAT_ensemble_',SSP_type{j},'_Areamean = nanmean(MAT_ensemble_',SSP_type{j},'_2D,1)'';'])
    %     eval(['clear MAT_ensemble_',SSP_type{j},'_2D'])
end


% 读取未来时期集合平均的基尼系数(逐年取集合平均)
% 读取基尼系数逐年数据
SSP_type = {'ssp126','ssp245','ssp370','ssp585'};

for j = 1 : length(SSP_type)
    filename2 = [SSP_type{j},'_3_Model_ensemble_annual_GI_025_scale_CN_2031_2060.mat'];
    load(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\7-4-future-025-ensemble-annual-GI\',filename2])
    
    eval(['GI_ensemble_',SSP_type{j},'_2D = reshape(Model_GI_3_model_ensemble_annual,[],size(Model_GI_3_model_ensemble_annual,3));'])
    clear Model_GI_3_model_ensemble_annual
    
    % 计算全国区域平均
    eval(['GI_ensemble_',SSP_type{j},'_Areamean = nanmean(GI_ensemble_',SSP_type{j},'_2D,1)'';'])
    %     eval(['clear GI_ensemble_',SSP_type{j},'_2D'])
end

% 读取暴雨发生频率(逐年取集合平均)
cd('J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\10-1-30a-all-pre-R95\Model_ensemble_Heavy_rain_percentage_and_Moderate_rain_intervals_3D_matrix\annual\')

for j = 1 : length(SSP_type)
    
    filename = [SSP_type{j},'three_models_ensemble_yearly_heavy_rain_percentage_025_scale_pre_event_thresold_5_95_matrix.mat'];
    load(filename)
    %     filename2 = [SSP_type{j},'three_models_ensemble_yearly_moderate_rain_intervals_025_scale_pre_event_thresold_5_95_matrix.mat'];
    %     load(filename2)
    
    eval(['Heavy_rain_percent_year_ensemble_',SSP_type{j},'_2D = reshape(heavy_rain_amount_percentage_year_ensemble,[],size(heavy_rain_amount_percentage_year_ensemble,3));']);
    %     eval(['Moderate_rain_intervals_year_ensemble_',SSP_type{j},'_2D = reshape(Moderate_rain_intervals_year_ensemble,[],size(Moderate_rain_intervals_year_ensemble,3));']);
    clear heavy_rain_amount_percentage_year_ensemble
    
    % 计算全国区域平均
    eval(['Heavy_rain_percent_',SSP_type{j},'_Areamean = nanmean(Heavy_rain_percent_year_ensemble_',SSP_type{j},'_2D,1)'';'])
    %     eval(['clear Heavy_rain_percent_year_ensemble_',SSP_type{j},'_2D'])
end

min(min(MAT_ensemble_ssp126_Areamean))
min(min(MAT_ensemble_ssp245_Areamean))
min(min(MAT_ensemble_ssp370_Areamean))
min(min(MAT_ensemble_ssp585_Areamean))

max(max(MAT_ensemble_ssp126_Areamean))
max(max(MAT_ensemble_ssp245_Areamean))
max(max(MAT_ensemble_ssp370_Areamean))
max(max(MAT_ensemble_ssp585_Areamean))

%% 全国上的温度与暴雨降水量占比的线性关系

Temp_CN_limit = [12.4 14.8];

plot_GAP_Len = 0.04; %图形之间的间隔
plot_GAP_High = 0.04; %图形之间的间隔
plot_Len = 0.3; % 图形的宽
plot_High = 0.25; % 图形的高

subplot_name = {'(a)','(b)';'(c)','(d)'};
SSP_type_3 = {'SSP126','SSP245';'SSP370','SSP585'};
SSP_type_2 = {'ssp126','ssp245';'ssp370','ssp585'};
figure1 = figure('Position', [1, 1, 1000, 1000],'paperpositionmode','auto');
for i = 1 : size(SSP_type_2,1)
    for j = 1 : size(SSP_type_2,2)

        % 做拟合线
        eval(['xlim1 = min(Temp_CN_limit);'])
        eval(['xlim2 = max(Temp_CN_limit);'])
        eval(['X = [ones(length(MAT_ensemble_',SSP_type_2{i,j},'_Areamean),1),MAT_ensemble_',SSP_type_2{i,j},'_Areamean];'])
        eval(['Y = Heavy_rain_percent_',SSP_type_2{i,j},'_Areamean;'])
        [b,~,~,~,stats] = regress(Y,X,0.05);
        % 设定x轴范围
        X1 = xlim1 : 0.1 : xlim2;
        Y1 = b(1) + b(2)*X1;        
        
        Bottom_pos = 0.55 - (i-1)*plot_High - (i-1)*plot_GAP_High;
        Left_pos = 0.1+(j-1)*plot_Len + (j-1)*plot_GAP_Len;
        % 先从底部的开始画
        ax1 = axes('pos',[Left_pos Bottom_pos plot_Len plot_High]);
        eval(['scatter(MAT_ensemble_',SSP_type_2{i,j},'_Areamean,Y,30,''k'',''filled'')'])
        hold on
        if b(2) > 0
            plot(X1,Y1,'r--','linewidth',2.5);
        else
            plot(X1,Y1,'b--','linewidth',2.5);
        end
        hold off
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
        
%         set(gca, 'YGrid', 'on')
        ylim([15 21])
        xlim(Temp_CN_limit)
%         set(gca,'ytick',-1:0.2:1)
        % 强制保留小数位数
        clear cb_tick Tick_label n
        cb_tick = get(gca,'ytick');
        Tick_label = cell(1,length(cb_tick));
        for n = 1 : length(cb_tick)
            Tick_label{1,n} = [num2str(roundn(cb_tick(n),0),'%4.0f'),'%'];
        end
        set(gca,'yticklabel',Tick_label)
        
        % 强制保留小数位数
        clear cb_tick Tick_label n
        cb_tick = get(gca,'xtick');
        Tick_label = cell(1,length(cb_tick));
        for n = 1 : length(cb_tick)
            Tick_label{1,n} = num2str(roundn(cb_tick(n),-1),'%4.1f');
        end
        set(gca,'xticklabel',Tick_label)
        
        % 右侧的列图不用纵坐标
        if j == 2
           set(gca,'yticklabel',[])
        end
        
        if i == 1
           set(gca,'xticklabel',[])
        end    
        
        if stats(3) < 0.05
        text('string',['K* = ',num2str(roundn(b(2),-1),'%4.1f'),' %·\circC^{-1}'],'Units','normalized','position',[0.48,0.12],'fontname','Times new Roman','fontsize',15, 'edgecolor', 'k')
        else
        text('string',['K = ',num2str(roundn(b(2),-1),'%4.1f'),' %·\circC^{-1}'],'Units','normalized','position',[0.48,0.12],'fontname','Times new Roman','fontsize',15, 'edgecolor', 'k')
        end
        text('string',subplot_name{i,j},'Units','normalized','position',[0.037,0.92],'fontsize',15,'FontName','times new Roman')
%         text('string',Temporal_scale_name_3{i,j},'Units','normalized','position',[0.103,0.915],'fontsize',15,'FontName','times new Roman')
        clear b stats X1 Y1 xlim1 xlim2 X Y
    end
end



axes('visible','off');
% % 加底部横坐标
text('string','年均温','Units','normalized','position',[0.28,0.12],'fontsize',20,'FontName','宋体')
text('string','(\circC)','Units','normalized','position',[0.38,0.125],'fontsize',20,'FontName','Times new Roman')
% 加左侧横坐标
text('string','暴雨降水量占比','Units','normalized','position',[-0.12,0.4],'fontsize',20,'FontName','宋体','Rotation',90)

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

cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\008-06-scatter-of-CMIP6-heavy-rain-features-and-MAT-2031-2060\')
exportgraphics(gcf,'未来时期暴雨降水量占比和年均温的散点关系图.jpg')

