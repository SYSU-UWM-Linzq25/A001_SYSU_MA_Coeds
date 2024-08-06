%% 这个文件对历史时期模型降水进行检验
%% 时间为1975-2014
%% 主要看多年平均降水量的空间分布

clear;clc;
model_name = {'MPI-ESM1-2-HR','IITM-ESM','NorESM2-LM','NorESM2-MM','MIROC6','TaiESM1','MPI-ESM1-2-LR','BCC-CSM2-MR','MRI-ESM2-0','CanESM5'};

% 读取4个气候区的线shp图，叠加在绘图上
shp_line_HR = shaperead('F:\File_of_MATLAB\关于3h尺度的CMFD降水数据研究2022.3.2\New climate seperate method from Du\湿润区\shiRunQu_Line.shp');
shp_line_TR = shaperead('F:\File_of_MATLAB\关于3h尺度的CMFD降水数据研究2022.3.2\New climate seperate method from Du\过渡区\guoDuQu_Line.shp');
shp_line_AR = shaperead('F:\File_of_MATLAB\关于3h尺度的CMFD降水数据研究2022.3.2\New climate seperate method from Du\干旱区\ganHanQu_Line.shp');
shp_line_TP = shaperead('F:\File_of_MATLAB\关于3h尺度的CMFD降水数据研究2022.3.2\New climate seperate method from Du\高寒区\qingZangGaoYuanQu_Line.shp');

shp = shaperead('J:\4-论文备份\论文代码2021.4.14\map\bou1_4p.shp');
shp1 = shaperead('J:\4-论文备份\论文代码2021.4.14\map\China.shp');
shp2 = shaperead('J:\4-论文备份\论文代码2021.4.14\map\China.shp');

shp_x=[shp(:).X];%提取经度信息
shp_y=[shp(:).Y];%提取纬度信息
% 读取4个气候区线shp的经纬度信息
shp_line_HR_x =[shp_line_HR(:).X];
shp_line_HR_y =[shp_line_HR(:).Y];
shp_line_TR_x =[shp_line_TR(:).X];
shp_line_TR_y =[shp_line_TR(:).Y];
shp_line_AR_x =[shp_line_AR(:).X];
shp_line_AR_y =[shp_line_AR(:).Y];
shp_line_TP_x =[shp_line_TP(:).X];
shp_line_TP_y =[shp_line_TP(:).Y];

for i = 1 : length(model_name)
    save_peth_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2018-2058\7-3-history-pr-process-cell-data\';
    cd(save_peth_1)
    filename2 = [model_name{i},'_CN_1975_2014.mat'];
    load(filename2)
    His_AP_year = nan(length(Lon_CN),length(Lat_CN),2014-1975+1);
    for j = 1 : length(CMIP6_model_HisPr_1975_2014)
        a = CMIP6_model_HisPr_1975_2014{j};
        His_AP_year(:,:,j) = nansum(a,3);
    end
    clear CMIP6_model_HisPr_1975_2014
    
    His_AP_multiyear_mean = nanmean(His_AP_year,3);
    
    % 画多年平均的空间分布图
    [xx,yy] = meshgrid(Lon_CN,Lat_CN);
    figure1 = figure('Position', [1, 1, 1300, 1000],'paperpositionmode','auto');
    set (gca,'position',[0.08,0.03,0.87,0.95] );
    m_proj('miller','lon',[70,140],'lat',[10,57]);%选择投影方式
    
    m_pcolor(xx,yy,His_AP_multiyear_mean')
    hold on
    m_plot(shp_x,shp_y,'k','linewidth',2)
    hold on
    m_plot(shp_line_HR_x,shp_line_HR_y,'k--','linewidth',1.5)
    hold on
    m_plot(shp_line_TR_x,shp_line_TR_y,'k--','linewidth',1.5)
    hold on
    m_plot(shp_line_AR_x,shp_line_AR_y,'k--','linewidth',1.5)
    hold on
    m_plot(shp_line_TP_x,shp_line_TP_y,'k--','linewidth',1.5)
    hold off
    m_grid('fontsize',26,'box','fancy','tickdir','in') % 在grid这里调整网格以及坐标模式，xtick可以直接改变坐标轴所需要的刻度多少
    m_ruler([0.35 0.6],0.09,2,'linewid',4,'ticklen',0.01,'fontsize',26); % 设置'tickdir','out'会导致图colorbar强制改变
    caxis([0,3000])
    
    RGB = cbrewer('div','RdYlBu',50,'linear');
    colormap(flip(RGB))
    cb1 = colorbar;
    set(cb1,'fontsize',30)
    % 设置子图标题
    m_text(74,53,model_name{i},'fontsize',36,'FontName','微软雅黑')
    
    % 保存图片
    cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\000-01-Model_His_pr_exam\')
    exportgraphics(gcf,[model_name{i},'_multiyear_average_Hispr.jpg'])
    close all
    clear filename2 Lon_CN Lat_CN His_AP_multiyear_mean His_AP_year
end