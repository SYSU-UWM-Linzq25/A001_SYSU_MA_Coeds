%% 这个文件根据CMFD历史时期（1985-2014）计算得到的基尼系数和暴雨降水量占比
%% 在气候区上求区域平均
%% 在四个时间尺度上画散点拟合图
%% 气候分区的提取已经在《B009_04_01_PCCs_of_heavy_rain_features_and_GI_CMFD_01_scale_1985_2014》完成


clear;clc;

% 读取四个气候区下，四个时间尺度下
% 基尼系数和暴雨降水量占比的数据
save_path = 'J:\6-硕士毕业论文\1-Data\CMFD\9-1-GI-and_heavy-rain-features-in-climate-zones\';
Temporal_scale_name = {'3h','6h','12h','1d'};
climate_zone_name = {'HR','TR','AR','TP'};

% 循环读取变量
for i = 1 : length(Temporal_scale_name)
    for j = 1 : length(climate_zone_name)
        filename2 = ['GI_and_heavy_rain_features_',Temporal_scale_name{i},'_',climate_zone_name{j},'.mat'];
        load([save_path,filename2])
    end
end




%% 直接画散点图

plot_GAP_Len = 0.06; %图形之间的间隔
plot_GAP_High = 0.07; %图形之间的间隔
plot_Len = 0.17; % 图形的宽
plot_High = 0.16; % 图形的高

Temporal_scale_name = {'3h','6h','12h','1d'};
climate_zone_name = {'HR','TR','AR','TP'};

% 验证的图
% figure
% plot(MAT_TP,GI_6h_TP,'k.')

% 设置横纵坐标轴的范围
Temp_HR_limit = [14.8 16.8];
Temp_TR_limit = [5 8];
Temp_AR_limit = [4.5 7.2];
Temp_TP_limit = [-3.6 -1.4];

GI_limit = cell(4,4);
GI_limit{1,1} = [0.945,0.961];
GI_limit{2,1} = [0.919,0.941];
GI_limit{3,1} = [0.88,0.925];
GI_limit{4,1} = [0.84,0.92];

GI_limit{1,2} = [0.972,0.982];
GI_limit{2,2} = [0.955,0.975];
GI_limit{3,2} = [0.93,0.97];
GI_limit{4,2} = [0.9,0.96];

GI_limit{1,3} = [0.93,0.97];
GI_limit{2,3} = [0.91,0.95];
GI_limit{3,3} = [0.9,0.93];
GI_limit{4,3} = [0.87,0.91];

GI_limit{1,4} = [0.87,0.94];
GI_limit{2,4} = [0.84,0.92];
GI_limit{3,4} = [0.8,0.88];
GI_limit{4,4} = [0.77,0.84];

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
        eval(['xlim1 = min(Temp_',climate_zone_name{5-j},'_limit);'])
        eval(['xlim2 = max(Temp_',climate_zone_name{5-j},'_limit);'])
        eval(['X = [ones(length(MAT_',climate_zone_name{5-j},'),1),MAT_',climate_zone_name{5-j},'];'])
        eval(['Y = GI_',Temporal_scale_name{i},'_',climate_zone_name{5-j},';'])
        [b,~,~,~,stats] = regress(Y,X,0.05);
        % 设定x轴范围
        X1 = xlim1 : 0.1 : xlim2;
        Y1 = b(1) + b(2)*X1;

        Bottom_pos = 0.07+(4-i)*plot_High + (4-i)*plot_GAP_High;
        Left_pos = 0.12+(4-j)*plot_Len + (4-j)*plot_GAP_Len;
        % 先从底部的开始画
        ax1 = axes('pos',[Left_pos Bottom_pos plot_Len plot_High]);
%         eval(['plot(MAT_',climate_zone_name{5-j},',GI_',Temporal_scale_name{i},'_',climate_zone_name{5-j},',''k.'')'])
        eval(['scatter(MAT_',climate_zone_name{5-j},',GI_',Temporal_scale_name{i},'_',climate_zone_name{5-j},',15,''k'',''filled'')'])
        hold on
        plot(X1,Y1,'r--','linewidth',2);
        hold off
        box on
        set(gca,'linewidth',1)
        set(gca,'fontsize',13)
        set(gca,'fontname','Times new Roman')
        
        % 强制保留小数位数
        clear cb_tick Tick_label n
        cb_tick = get(ax1,'ytick');
        Tick_label = cell(1,length(cb_tick));
        for n = 1 : length(cb_tick)
            Tick_label{1,n} = num2str(roundn(cb_tick(n),-3),'%4.3f');
        end
        set(ax1,'yticklabel',Tick_label)
        
        clear cb_tick Tick_label n
        cb_tick = get(ax1,'xtick');
        Tick_label = cell(1,length(cb_tick));
        for n = 1 : length(cb_tick)
            Tick_label{1,n} = num2str(roundn(cb_tick(n),-1),'%4.1f');
        end
        set(ax1,'xticklabel',Tick_label)
        
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
        
        % 加title，标子图标题+拟合线
        if stats(3) < 0.05
            title([subplot_name{i,j},' K* = ',num2str(roundn(b(2),-3),'%4.3f')])
        else
            title([subplot_name{i,j},' K = ',num2str(roundn(b(2),-3),'%4.3f')])
        end
        
        clear b stats X1 Y1 xlim1 xlim2 X Y
    end
end
axes('visible','off');
% 加底部横坐标
text('string','年均温','Units','normalized','position',[0.44,-0.1],'fontsize',20,'FontName','宋体')
text('string','(\circC)','Units','normalized','position',[0.55,-0.095],'fontsize',20,'FontName','Times new Roman')
% 加左侧横坐标
text('string','GC','Units','normalized','position',[-0.09,0.45],'fontsize',20,'FontName','Times new Roman','Rotation',90)

% 加左侧时间尺度标识
text('string','3-hour','Units','normalized','position',[-0.13,0.85],'fontsize',25,'FontName','Times new Roman','Rotation',90)
text('string','6-hour','Units','normalized','position',[-0.13,0.56],'fontsize',25,'FontName','Times new Roman','Rotation',90)
text('string','12-hour','Units','normalized','position',[-0.13,0.27],'fontsize',25,'FontName','Times new Roman','Rotation',90)
text('string','1-day','Units','normalized','position',[-0.13,0.01],'fontsize',25,'FontName','Times new Roman','Rotation',90)


% 加顶部气候区标识
text('string','湿润区','Units','normalized','position',[0.024,1.06],'fontsize',25,'FontName','宋体')
text('string','过渡区','Units','normalized','position',[0.32,1.06],'fontsize',25,'FontName','宋体')
text('string','干旱区','Units','normalized','position',[0.62,1.06],'fontsize',25,'FontName','宋体')
text('string','高寒区','Units','normalized','position',[0.925,1.06],'fontsize',25,'FontName','宋体')

cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\005-01-scatter-plot-of-MAT-GI-CMFD-1985-2014\')
exportgraphics(gcf,'历史时期基尼系数和年均温的散点拟合关系图.jpg')