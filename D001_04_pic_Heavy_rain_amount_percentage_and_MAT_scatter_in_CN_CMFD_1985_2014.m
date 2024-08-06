%% 这个文件根据CMFD历史时期（1985-2014年）计算的暴雨降水量占比和年均温的关系
%% 画散点关系图，直接全国画

clear;clc;

% 读取四个时间尺度下
% 暴雨降水量占比的数据
% 3-hour
cd('J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\3h\Heavy_rain_fre_intensity_percentage_3D_matrix\')
load('heavy_rain_fre_intensity_percentage_01_scale_3h_pre_event_thresold_5_95_matrix.mat')

% 6-hour
cd('J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\6h-from-Paper2\Heavy_rain_fre_intensity_percentage_3D_matrix\')
load('heavy_rain_fre_intensity_percentage_01_scale_6h_pre_event_thresold_5_95_matrix.mat')

% 12-hour
cd('J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\12h-from-Paper2\Heavy_rain_fre_intensity_percentage_3D_matrix\')
load('heavy_rain_fre_intensity_percentage_01_scale_12h_pre_event_thresold_5_95_matrix.mat')

% 1-day
cd('J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\1d-from-Paper2\Heavy_rain_fre_intensity_percentage_3D_matrix\')
load('heavy_rain_fre_intensity_percentage_01_scale_1d_pre_event_thresold_5_95_matrix.mat')

% % 尝试只看中国东南的湿润区(结果差不多)
% % 根据气候区进行划分
% % 读取气候分区的index
% load(['J:\6-硕士毕业论文\1-Data\Climate_zone_index\', 'Four_Climite_zone_index_01_scale.mat'])
% % 提取气候区的索引
% k_HR = find(Four_climate_zone_index_01 == 1);
% % k_TR = find(Four_climate_zone_index_01 == 2);
% % k_AR = find(Four_climate_zone_index_01 == 3);
% % k_TP = find(Four_climate_zone_index_01 == 4);

% 计算暴雨降水量占比的区域平均
Temporal_scale_name = {'3h','6h','12h','1d'};
for i = 1 : length(Temporal_scale_name)
    for year = 1 : size(heavy_rain_amount_percentage_3h_matrix,3)
        eval(['heavy_rain_amount_percentage_year = heavy_rain_amount_percentage_',Temporal_scale_name{i},'_matrix(:,:,year);'])
        % 求区域平均
        eval(['Heavy_percentage_Areamean_',Temporal_scale_name{i},'(year,1) = nanmean(nanmean(heavy_rain_amount_percentage_year,1));'])
        clear heavy_rain_amount_percentage_year
    end
end

% 读取年均温数据
clear filename2
filename2 = 'MAT_3h_01mmh_1979_2018.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\5-1-CMFD-01-scale-AP-and-MAT-01mmh\',filename2]);
MAT_3h_1985_2014 = MAT_3h(:,:,7:end-4);
clear MAT_3h

MAT_Areamean_all = nan(size(MAT_3h_1985_2014,3),1);
% 计算年均温的区域平均
for year = 1 : size(MAT_3h_1985_2014,3)
    MAT_year = MAT_3h_1985_2014(:,:,year);
    % 求区域平均
    MAT_Areamean_all(year,1) = nanmean(nanmean(MAT_year,1));
    clear MAT_year
end


%% 直接画散点图
%% 按照时间尺度划分成四个小图
RGB = cbrewer('seq','YlOrRd',7,'linear');

Temp_CN_limit = [7 9];

plot_GAP_Len = 0.04; %图形之间的间隔
plot_GAP_High = 0.04; %图形之间的间隔
plot_Len = 0.3; % 图形的宽
plot_High = 0.25; % 图形的高

subplot_name = {'(a)','(b)';'(c)','(d)'};
Temporal_scale_name_3 = {'3-hour','6-hour';'12-hour','1-day'};
Temporal_scale_name_2 = {'3h','6h';'12h','1d'};
figure1 = figure('Position', [1, 1, 1000, 1000],'paperpositionmode','auto');
for i = 1 : size(Temporal_scale_name_2,1)
    for j = 1 : size(Temporal_scale_name_2,2)

        % 做拟合线
        eval(['xlim1 = min(Temp_CN_limit);'])
        eval(['xlim2 = max(Temp_CN_limit);'])
        eval(['X = [ones(length(MAT_Areamean_all),1),MAT_Areamean_all];'])
        eval(['Y = Heavy_percentage_Areamean_',Temporal_scale_name_2{i,j},';'])
        [b,~,~,~,stats] = regress(Y,X,0.05);
        % 设定x轴范围
        X1 = xlim1 : 0.1 : xlim2;
        Y1 = b(1) + b(2)*X1;        
        
        Bottom_pos = 0.55 - (i-1)*plot_High - (i-1)*plot_GAP_High;
        Left_pos = 0.1+(j-1)*plot_Len + (j-1)*plot_GAP_Len;
        % 先从底部的开始画
        ax1 = axes('pos',[Left_pos Bottom_pos plot_Len plot_High]);
        eval(['scatter(MAT_Areamean_all,Heavy_percentage_Areamean_',Temporal_scale_name_2{i,j},',30,''k'',''filled'')'])
%         eval(['semilogy(MAT_Areamean_all,Heavy_percentage_Areamean_',Temporal_scale_name_2{i,j},',''o'')'])
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
        ylim([0 42])
        xlim(Temp_CN_limit)
        set(gca,'ytick',10:5:45)
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
text('string','暴雨降水量占比(%)','Units','normalized','position',[-0.12,0.4],'fontsize',20,'FontName','宋体','Rotation',90)

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

% cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\008-04-scatter-of-CMFD-heavy-rain-features-and-MAT-1985-2014\')
% exportgraphics(gcf,'历史时期暴雨降水量占比和年均温的散点关系图.jpg')