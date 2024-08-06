%% 这个文件对两种时间尺度下的CMFD降水数据进行检验
%% 主要是年降水量的空间分布图
%% 同时看两种降水阈值下的情况
%% 结论：有所不同但是整体接近

%% 未预处理的情况
% 3h
clear;clc;

filename2 = ['pre1_3h_no_preprocessing_',num2str(2000),'.mat'];
load(['J:\6-硕士毕业论文\1-Data\CMFD\1-origin-data-3h\',filename2]);
clear pre_3h_noprocessing

Annual_Pr_3h_all = nan(length(Lon),length(Lat),2018-1979+1);
for year = 1979 : 2018
    filename2 = ['pre1_3h_no_preprocessing_',num2str(year),'.mat'];
    load(['J:\6-硕士毕业论文\1-Data\CMFD\1-origin-data-3h\',filename2]);
    
    Annual_Pr_3h_all(:,:,year-1978) = nansum(pre_3h_noprocessing,3);
    disp([num2str(year),' is done!'])
    clear pre_3h_noprocessing
end
clear filename2
filename2 = 'Annual_Pr_3h_data_no_preprocessing.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\4-Annual-Pr\',filename2],'Annual_Pr_3h_all','Lon','Lat');
clear Annual_Pr_3h_all

% 1d
clear;clc;

filename2 = ['pre4_1d_no_preprocessing_',num2str(2000),'.mat'];
load(['J:\6-硕士毕业论文\1-Data\CMFD\2-origin-data-1d\',filename2]);
clear pre_1d_noprocessing

Annual_Pr_1d_all = nan(length(Lon),length(Lat),2018-1979+1);
for year = 1979 : 2018
    filename2 = ['pre4_1d_no_preprocessing_',num2str(year),'.mat'];
    load(['J:\6-硕士毕业论文\1-Data\CMFD\2-origin-data-1d\',filename2]);
    
    Annual_Pr_1d_all(:,:,year-1978) = nansum(pre_1d_noprocessing,3);
    disp([num2str(year),' is done!'])
    clear pre_1d_noprocessing
end
clear filename2
filename2 = 'Annual_Pr_1d_data_no_preprocessing.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\4-Annual-Pr\',filename2],'Annual_Pr_1d_all','Lon','Lat');
clear Annual_Pr_1d_all

% 原始数据单位为mmh,要变成降水量还要乘以相应的时段
% 3h尺度为×3
% 日尺度为×24




%% 两种预处理方式
% 从日尺度降水出发，以阈值0.1 mm/day 处理（3h尺度就变成 0.1/8 /3h） ——要先将降水率转为降水量
% 从3h尺度出发，以阈值0.1 mm/h 处理（日尺度就变成2.4 mm/day） ——直接针对降水率

% 3h
clear;clc;

filename2 = ['pre1_3h_no_preprocessing_',num2str(2000),'.mat'];
load(['J:\6-硕士毕业论文\1-Data\CMFD\1-origin-data-3h\',filename2]);
clear pre_3h_noprocessing

Annual_Pr_3h_01mmh = nan(length(Lon),length(Lat),2018-1979+1);
Annual_Pr_3h_01mmday = nan(length(Lon),length(Lat),2018-1979+1);
for year = 1979 : 2018
    filename2 = ['pre1_3h_no_preprocessing_',num2str(year),'.mat'];
    load(['J:\6-硕士毕业论文\1-Data\CMFD\1-origin-data-3h\',filename2]);
    
    % 第二种
    pre_3h_01mmh = pre_3h_noprocessing;
    pre_3h_01mmh(pre_3h_01mmh < 0.1) = 0;
    Annual_Pr_3h_01mmh(:,:,year-1978) = nansum(pre_3h_01mmh,3).*3;
    clear pre_3h_01mmh
    
    % 第一种
    pre_3h_01mmday = pre_3h_noprocessing.*3;
    pre_3h_01mmday(pre_3h_01mmday < 0.1/8) = 0;
    Annual_Pr_3h_01mmday(:,:,year-1978) = nansum(pre_3h_01mmday,3);
    clear pre_3h_01mmday pre_3h_noprocessing
    
    disp([num2str(year),' is done!'])   
end
clear filename2
filename2 = 'Annual_Pr_3h_data_01mmh.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\4-Annual-Pr\',filename2],'Annual_Pr_3h_01mmh','Lon','Lat');
clear filename2
filename2 = 'Annual_Pr_3h_data_01mmday.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\4-Annual-Pr\',filename2],'Annual_Pr_3h_01mmday','Lon','Lat');

% 1d
% 从日尺度降水出发，以阈值0.1 mm/day 处理（3h尺度就变成 0.1/8 /3h） ——要先将降水率转为降水量
% 从3h尺度出发，以阈值0.1 mm/h 处理（日尺度就变成2.4 mm/day） ——直接针对3h降水率

clear;clc;

filename2 = ['pre4_1d_no_preprocessing_',num2str(2000),'.mat'];
load(['J:\6-硕士毕业论文\1-Data\CMFD\2-origin-data-1d\',filename2]);
clear pre_1d_noprocessing

Annual_Pr_1d_01mmh = nan(length(Lon),length(Lat),2018-1979+1);
Annual_Pr_1d_01mmday = nan(length(Lon),length(Lat),2018-1979+1);
for year = 1979 : 2018
    filename2 = ['pre4_1d_no_preprocessing_',num2str(year),'.mat'];
    load(['J:\6-硕士毕业论文\1-Data\CMFD\2-origin-data-1d\',filename2]);
    
    % 第二种
    pre_1d_01mmh = pre_1d_noprocessing.*24;
    pre_1d_01mmh(pre_1d_01mmh < 2.4) = 0;
    Annual_Pr_1d_01mmh(:,:,year-1978) = nansum(pre_1d_01mmh,3);
    clear pre_1d_01mmh
    
    % 第一种
    pre_1d_01mmday = pre_1d_noprocessing.*24;
    pre_1d_01mmday(pre_1d_01mmday < 0.1) = 0;
    Annual_Pr_1d_01mmday(:,:,year-1978) = nansum(pre_1d_01mmday,3);
    clear pre_1d_01mmday
    
    disp([num2str(year),' is done!'])
    clear pre_1d_noprocessing
end
clear filename2
filename2 = 'Annual_Pr_1d_data_01mmh.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\4-Annual-Pr\',filename2],'Annual_Pr_1d_01mmh','Lon','Lat');
clear filename2
filename2 = 'Annual_Pr_1d_data_01mmday.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\4-Annual-Pr\',filename2],'Annual_Pr_1d_01mmday','Lon','Lat');


%% 画图
clear;clc;

% 读取年降水量数据
% 未预处理的
clear filename2
filename2 = 'Annual_Pr_3h_data_no_preprocessing.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\4-Annual-Pr\',filename2]);

clear filename2
filename2 = 'Annual_Pr_1d_data_no_preprocessing.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\4-Annual-Pr\',filename2]);

% 转换单位
Annual_Pr_3h_all = Annual_Pr_3h_all .*3;
Annual_Pr_1d_all = Annual_Pr_1d_all .*24;
% 计算多年平均值
Annual_Pr_3h_noprocessing = nanmean(Annual_Pr_3h_all,3);
Annual_Pr_1d_noprocessing = nanmean(Annual_Pr_1d_all,3);

% 两种预处理方式,已经转换过单位
% 01mmh
clear filename2
filename2 = 'Annual_Pr_3h_data_01mmh.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\4-Annual-Pr\',filename2]);
Annual_Pr_3h_data_01mmh_mean = nanmean(Annual_Pr_3h_01mmh,3);

clear filename2
filename2 = 'Annual_Pr_1d_data_01mmh.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\4-Annual-Pr\',filename2]);
Annual_Pr_1d_data_01mmh_mean = nanmean(Annual_Pr_1d_01mmh,3);

% 01mmday
clear filename2
filename2 = 'Annual_Pr_3h_data_01mmday.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\4-Annual-Pr\',filename2]);
Annual_Pr_3h_data_01mmday_mean = nanmean(Annual_Pr_3h_01mmday,3);

clear filename2
filename2 = 'Annual_Pr_1d_data_01mmday.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\4-Annual-Pr\',filename2]);
Annual_Pr_3h_data_01mmday_mean = nanmean(Annual_Pr_1d_01mmday,3);


shp = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\基于审图号GS(2019)1822号新制作的底图\新国界_无东沙赤尾钓鱼_需和Chinaline连用.shp');
shp1 = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\基于审图号GS(2019)1822号新制作的底图\New_China_line.shp');
shp2 = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\基于审图号GS(2019)1822号新制作的底图\Dongsha_Chiwei_Diaoyu.shp');

% 读取4个气候区的线shp图，叠加在绘图上
shp_line_HR = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\湿润区\shiRunQu_Line.shp');
shp_line_TR = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\过渡区\guoDuQu_Line.shp');
shp_line_AR = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\干旱区\ganHanQu_Line.shp');
shp_line_TP = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\高寒区\qingZangGaoYuanQu_Line.shp');

% shp图的经纬度
shp_x=[shp(:).X];%提取经度信息
shp_y=[shp(:).Y];%提取纬度信息
shp1_x=[shp1(:).X];
shp1_y=[shp1(:).Y];
shp2_x=[shp2(:).X];
shp2_y=[shp2(:).Y];

% 读取4个气候区线shp的经纬度信息
shp_line_HR_x =[shp_line_HR(:).X];
shp_line_HR_y =[shp_line_HR(:).Y];
shp_line_TR_x =[shp_line_TR(:).X];
shp_line_TR_y =[shp_line_TR(:).Y];
shp_line_AR_x =[shp_line_AR(:).X];
shp_line_AR_y =[shp_line_AR(:).Y];
shp_line_TP_x =[shp_line_TP(:).X];
shp_line_TP_y =[shp_line_TP(:).Y];


[xx,yy] = meshgrid(Lon,Lat);

Var_name = {'Annual_Pr_3h_noprocessing','Annual_Pr_1d_noprocessing','Annual_Pr_3h_data_01mmh_mean','Annual_Pr_1d_data_01mmh_mean',...
    'Annual_Pr_3h_data_01mmday_mean','Annual_Pr_3h_data_01mmday_mean'};
Var_name2 = {'Annual-Pr-3h-noprocessing','Annual-Pr-1d-noprocessing','Annual-Pr-3h-data-01mmh-mean','Annual-Pr-1d-data-01mmh-mean',...
    'Annual-Pr-3h-data-01mmday-mean','Annual-Pr-3h-data-01mmday-mean'};
for i = 1 : length(Var_name)
    figure1 = figure('Position', [1, 1, 1300, 1000],'paperpositionmode','auto');
    m_proj('miller','lon',[70,140],'lat',[10,57]);%选择投影方式
    eval(['m_pcolor(xx,yy,',Var_name{i},''');'])
    hold on
    m_plot(shp_x,shp_y,'k','linewidth',2)
    hold on
    m_plot(shp1_x,shp1_y,'k','linewidth',2)
    hold on
    m_plot(shp_line_HR_x,shp_line_HR_y,'k--','linewidth',1.5)
    hold on
    m_plot(shp_line_TR_x,shp_line_TR_y,'k--','linewidth',1.5)
    hold on
    m_plot(shp_line_AR_x,shp_line_AR_y,'k--','linewidth',1.5)
    hold on
    m_plot(shp_line_TP_x,shp_line_TP_y,'k--','linewidth',1.5)
    hold off
    m_grid('fontsize',20,'tickdir','out','linestyle','none') % 在grid这里调整网格以及坐标模式，xtick可以直接改变坐标轴所需要的刻度多少
    m_ruler([0.03 0.2],0.05,2,'linewid',4,'ticklen',0.01,'fontsize',15); % 设置'tickdir','out'会导致图colorbar强制改变
    caxis([0 3500]);
    
    RGB = cbrewer('seq','OrRd',8-1,'linear');
    colormap(RGB)
    cb = colorbar;
    set(cb,'fontsize',20)
    
    % 强制保留小数位数
    cb_tick = get(cb,'ytick');
    Tick_label = cell(1,length(cb_tick));
    for j = 1 : length(cb_tick)
        Tick_label{1,j} = num2str(roundn(cb_tick(j),0),'%4.0f');
    end
    set(cb,'yticklabel',Tick_label)
    
    %
    text( 'string',['(',num2str(i),') ',Var_name2{i}], 'Units','normalized','position',[0,1.06],  'FontSize',30,'FontWeight','Bold','FontName','Times New Roman');
    
    % 设置南海小图
    axes('pos',[0.71 0.115 0.15 0.3])
    m_proj('miller','lon',[105,125],'lat',[3,26]);%选择投影方式
    eval(['m_pcolor(xx,yy,',Var_name{i},''');'])
    hold on
    m_plot(shp1_x,shp1_y,'k','linewidth',2)
    hold off
    m_grid('ytick',[],'xtick',[]) % 删除坐标轴显示，'xaxislocation','middle'可以把x轴放在中间
    caxis([0 3500]);
    RGB = cbrewer('seq','OrRd',8-1,'linear');
    colormap(RGB)
end
