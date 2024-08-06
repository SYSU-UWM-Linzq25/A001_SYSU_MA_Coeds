%% 这个文件将三个选出来的最优模型的基尼系数Sen趋势画出来
%% 基尼系数为历史时期（1985-2014）
%% 同时画集合平均的结果
%% 并画出同时期的CMFD结果

% 三个模型各自的线性趋势
clear;clc;
model_name = {'MPI-ESM1-2-HR','NorESM2-MM','MIROC6'};


% 画图
shp0 = shaperead('J:\4-论文备份\论文代码2021.4.14\map\bou1_4p.shp');
shp = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\基于审图号GS(2019)1822号新制作的底图\新国界_无东沙赤尾钓鱼_需和Chinaline连用.shp');
shp1 = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\基于审图号GS(2019)1822号新制作的底图\New_China_line.shp');
shp2 = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\基于审图号GS(2019)1822号新制作的底图\Dongsha_Chiwei_Diaoyu.shp');
% 读取4个气候区的线shp图，叠加在绘图上
shp_line_HR = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\中国农业自然区划-中国科学院地理科学与资源研究所资源环境科学与数据中心\气候分区\Humid_Region_Dissolv_Line_GCS1984.shp');
shp_line_TR = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\中国农业自然区划-中国科学院地理科学与资源研究所资源环境科学与数据中心\气候分区\Transition_Region_Dissolv_Line_GCS1984.shp');
shp_line_AR = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\中国农业自然区划-中国科学院地理科学与资源研究所资源环境科学与数据中心\气候分区\Arid_Region_Dissolv_Line_GCS1984.shp');
shp_line_TP = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\中国农业自然区划-中国科学院地理科学与资源研究所资源环境科学与数据中心\气候分区\Tibetan_Plateau_Dissolv_Line_GCS1984.shp');

% 集合平均的结果
save_path_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\5-1-His-pr-025-scale-Gini\asemble\';
cd(save_path_1)
load('Three_Model_ensemble_average_025_scale_Gini_SenTrend_CN_1985_2014.mat')
Gini_Sen_slope_1d_asemble = Gini_Sen_slope_1d;
Gini_MK_1d_asemble = Gini_MK_1d;
clear Gini_Sen_slope_1d Gini_MK_1d
G_Sen_Trend_range = nan(4,2);
G_Sen_Trend_range(1,1) = min(min(Gini_Sen_slope_1d_asemble));
G_Sen_Trend_range(1,2) = max(max(Gini_Sen_slope_1d_asemble));

Lon_025 = xx_025(:,1);
Lat_025 = yy_025(1,:);

save_path_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\5-1-His-pr-025-scale-Gini\';
cd(save_path_1)
% 首先提取三个模型和CMFD同时期基尼系数线性趋势的范围
for i = 1 : length(model_name) % 选择模式读取数据
    filename = [model_name{i},'_025_scale_Gini_SenTrend_CN_1985_2014.mat'];
    load(filename)
    
    G_Sen_Trend_range(i+1,1) = min(min(Gini_Sen_slope_1d));
    G_Sen_Trend_range(i+1,2) = max(max(Gini_Sen_slope_1d));
    
    eval(['Gini_Sen_slope_1d_',num2str(i),' = Gini_Sen_slope_1d;'])
    eval(['Gini_MK_1d_',num2str(i),' = Gini_MK_1d;'])
    clear Gini_Sen_slope_1d Gini_MK_1d
    
end

a1 = min(G_Sen_Trend_range(:,1));
b1 = min(G_Sen_Trend_range(:,2));

% 画图
mask_CN_Gini_Sen_Trend_group(Lon_025,Lat_025,Gini_Sen_slope_1d_1,Gini_Sen_slope_1d_2,Gini_Sen_slope_1d_3,Gini_Sen_slope_1d_asemble,Gini_MK_1d_1,Gini_MK_1d_2,...
    Gini_MK_1d_3,Gini_MK_1d_asemble,shp0,shp,shp1,shp2,-0.004,0.004,shp_line_HR,shp_line_TR,shp_line_AR,shp_line_TP);

%%

cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\002-04-01-Three-best-CMIP6-His-GI-and-LinearTrend\')
exportgraphics(gcf,'历史时期3个最优模型和集合平均的Sen斜率.jpg')

close all
