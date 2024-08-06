%% 这个文件根据升尺度后的CMFD-1d降水基尼系数
%% 与CN051结果进行比较
%% 主要目标：1.说明两种降水阈值哪个好(暂缓)
%%           2.说明CMFD数据结果与CN051相近，可以画纬度平均变化

%% 画两种数据基尼系数的多年平均和线性趋势空间分布图在下面两个文件中实现
% C002_01_pic_CMFD_3h_and_1d_GI_and_LinearTrend_1985_2014
% C002_02_pic_CN051_1d_GI_and_LinearTrend_1985_2014
% 多年平均相似性很高，但是趋势就不一样

%% 计算CMFD升尺度的基尼系数与CN051降水得到的基尼系数的差别
%% 时间段取为1985-2014
%% 画图

clear;clc;
filename2 = 'RMSE_CMFD_and_CN051_GI_025_scale.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\',filename2])
Lon_025 = xx_025(:,1);
Lat_025 = yy_025(1,:)';

% 画图
% 去掉台湾
shp0 = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\China_map_without_TW\bou1_4p_without_TW.shp');
shp = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\基于审图号GS(2019)1822号新制作的底图\新国界_无东沙赤尾钓鱼_需和Chinaline连用.shp');
shp1 = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\基于审图号GS(2019)1822号新制作的底图\New_China_line.shp');
shp2 = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\基于审图号GS(2019)1822号新制作的底图\Dongsha_Chiwei_Diaoyu.shp');
% 读取4个气候区的线shp图，叠加在绘图上
shp_line_HR = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\中国农业自然区划-中国科学院地理科学与资源研究所资源环境科学与数据中心\气候分区\Humid_Region_Dissolv_Line_GCS1984.shp');
shp_line_TR = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\中国农业自然区划-中国科学院地理科学与资源研究所资源环境科学与数据中心\气候分区\Transition_Region_Dissolv_Line_GCS1984.shp');
shp_line_AR = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\中国农业自然区划-中国科学院地理科学与资源研究所资源环境科学与数据中心\气候分区\Arid_Region_Dissolv_Line_GCS1984.shp');
shp_line_TP = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\中国农业自然区划-中国科学院地理科学与资源研究所资源环境科学与数据中心\气候分区\Tibetan_Plateau_Dissolv_Line_GCS1984.shp');

Var_name = {'RMSE_01mmh_025_scale'};
Var_name2 = {'RMSE-01mmh-025-scale'};

bb = max(max(RMSE_01mmh_025_scale));

for i = 1 : length(Var_name)
    
    subplot_name = ['(',num2str(i),') ',Var_name2{i}];
    eval(['mask_CN_RMSE(Lon_025,Lat_025,',Var_name{i},',shp0,shp,shp1,shp2,0,0.24,8,shp_line_HR,shp_line_TR,shp_line_AR,shp_line_TP,subplot_name)'])
          
    cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\002-03-01-RMSE-025-scale-GI-CMFD-CN051\')
    exportgraphics(gcf,['(',num2str(i+2),') ',Var_name2{i},'.jpg'])
end

% %% 以0.1 mm/h 处理的在西部沙漠很大一部分都是nan
% k = find(isnan(RMSE_01mmh_025_scale) & ~isnan(RMSE_01mmday_025_scale));
% 
% G_nan_search_CN051 = nan(size(Gini_CMFD_1d_025_scale_01mmday,3),length(k));
% G_nan_search_CMFD = nan(size(Gini_CMFD_1d_025_scale_01mmday,3),length(k));
% for year = 1 : size(Gini_CMFD_1d_025_scale_01mmday,3)
%     a = Gini_CN051_01mmh(:,:,year);
%     b = Gini_CMFD_1d_025_scale_01mmh_rev(:,:,year);    
%     
%     G_nan_search_CN051(year,1:length(k)) = a(k);
%     G_nan_search_CMFD(year,1:length(k)) = b(k);
%     clear a b
% end
% 
% clearvars -except G_nan_search_CN051 G_nan_search_CMFD k