%% 这个文件画sub-daily根据线性回归方程转换的日尺度基尼系数的空间分布
%% 原始空间尺度（0.1°）

clear;clc;

% 3h
filename2 = 'CMFD_3h_Gini_1979_2018_01mmh.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\3-1-Gini&LinearTrend\',filename2])
clear Gini_CMFD_3h

% 3h→日尺度的参数
filename2 = '1d_GI_transformed_from_3h_GI.mat';
load(['J:\6-硕士毕业论文\1-Data\Temporal_resolution_translation\',filename2])
% 改变数据形式
GI_1d_transform_from_3h_3D = nan(length(Lon),length(Lat),2014-1985);
GI_1d_transform_from_3h = GI_1d_transform_from_3h';
for i = 1 : size(GI_1d_transform_from_3h,2)
    GI_1d_transform_from_3h_year = GI_1d_transform_from_3h(:,i);
    GI_1d_transform_from_3h_3D(:,:,i) = reshape(GI_1d_transform_from_3h_year,[length(Lon),length(Lat)]);
    clear GI_1d_transform_from_3h_year
end
GI_1d_transform_from_3h_3D_mean = nanmean(GI_1d_transform_from_3h_3D,3);

Differ_3h_3D = nan(length(Lon),length(Lat),2014-1985);
differ_3h = differ_3h';
for i = 1 : size(differ_3h,2)
    differ_3h_year = differ_3h(:,i);
    Differ_3h_3D(:,:,i) = reshape(differ_3h_year,[length(Lon),length(Lat)]);
    clear differ_3h_year
end
Differ_3h_3D_mean = nanmean(Differ_3h_3D,3);

% 6-hour
clear filename2
filename2 = '1d_GI_transformed_from_6h_GI.mat';
load(['J:\6-硕士毕业论文\1-Data\Temporal_resolution_translation\',filename2])
% 改变数据形式
GI_1d_transform_from_6h_3D = nan(length(Lon),length(Lat),2014-1985);
GI_1d_transform_from_6h = GI_1d_transform_from_6h';
for i = 1 : size(GI_1d_transform_from_6h,2)
    GI_1d_transform_from_6h_year = GI_1d_transform_from_6h(:,i);
    GI_1d_transform_from_6h_3D(:,:,i) = reshape(GI_1d_transform_from_6h_year,[length(Lon),length(Lat)]);
    clear GI_1d_transform_from_6h_year
end
GI_1d_transform_from_6h_3D_mean = nanmean(GI_1d_transform_from_6h_3D,3);

Differ_6h_3D = nan(length(Lon),length(Lat),2014-1985);
differ_6h = differ_6h';
for i = 1 : size(differ_6h,2)
    differ_6h_year = differ_6h(:,i);
    Differ_6h_3D(:,:,i) = reshape(differ_6h_year,[length(Lon),length(Lat)]);
    clear differ_6h_year
end
Differ_6h_3D_mean = nanmean(Differ_6h_3D,3);

% 12-hour
clear filename2
filename2 = '1d_GI_transformed_from_12h_GI.mat';
load(['J:\6-硕士毕业论文\1-Data\Temporal_resolution_translation\',filename2])
% 改变数据形式
GI_1d_transform_from_12h_3D = nan(length(Lon),length(Lat),2014-1985);
GI_1d_transform_from_12h = GI_1d_transform_from_12h';
for i = 1 : size(GI_1d_transform_from_12h,2)
    GI_1d_transform_from_12h_year = GI_1d_transform_from_12h(:,i);
    GI_1d_transform_from_12h_3D(:,:,i) = reshape(GI_1d_transform_from_12h_year,[length(Lon),length(Lat)]);
    clear GI_1d_transform_from_12h_year
end
GI_1d_transform_from_12h_3D_mean = nanmean(GI_1d_transform_from_12h_3D,3);

Differ_12h_3D = nan(length(Lon),length(Lat),2014-1985);
differ_12h = differ_12h';
for i = 1 : size(differ_12h,2)
    differ_12h_year = differ_12h(:,i);
    Differ_12h_3D(:,:,i) = reshape(differ_12h_year,[length(Lon),length(Lat)]);
    clear differ_12h_year
end
Differ_12h_3D_mean = nanmean(Differ_12h_3D,3);

% 原始1d的基尼系数转换
GI_1d_3D = nan(length(Lon),length(Lat),2014-1985);
GI_1d_2D = GI_a_day_3h';
for i = 1 : size(GI_1d_2D,2)
    GI_1d_year = GI_1d_2D(:,i);
    GI_1d_3D(:,:,i) = reshape(GI_1d_year,[length(Lon),length(Lat)]);
    clear GI_1d_year
end
GI_1d_3D_mean = nanmean(GI_1d_3D,3);

% 看差别的最大最小值
Differ_3D_mean_all = nan(length(Lon),length(Lat),3);
Differ_3D_mean_all(:,:,1) = Differ_3h_3D_mean;
Differ_3D_mean_all(:,:,2) = Differ_6h_3D_mean;
Differ_3D_mean_all(:,:,3) = Differ_12h_3D_mean;
min(min(min(Differ_3D_mean_all)))
max(max(max(Differ_3D_mean_all)))


%% 画图
shp0 = shaperead('J:\4-论文备份\论文代码2021.4.14\map\bou1_4p.shp');
shp = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\基于审图号GS(2019)1822号新制作的底图\新国界_无东沙赤尾钓鱼_需和Chinaline连用.shp');
shp1 = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\基于审图号GS(2019)1822号新制作的底图\New_China_line.shp');
shp2 = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\基于审图号GS(2019)1822号新制作的底图\Dongsha_Chiwei_Diaoyu.shp');
% 读取4个气候区的线shp图，叠加在绘图上
shp_line_HR = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\中国农业自然区划-中国科学院地理科学与资源研究所资源环境科学与数据中心\气候分区\Humid_Region_Dissolv_Line_GCS1984.shp');
shp_line_TR = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\中国农业自然区划-中国科学院地理科学与资源研究所资源环境科学与数据中心\气候分区\Transition_Region_Dissolv_Line_GCS1984.shp');
shp_line_AR = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\中国农业自然区划-中国科学院地理科学与资源研究所资源环境科学与数据中心\气候分区\Arid_Region_Dissolv_Line_GCS1984.shp');
shp_line_TP = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\中国农业自然区划-中国科学院地理科学与资源研究所资源环境科学与数据中心\气候分区\Tibetan_Plateau_Dissolv_Line_GCS1984.shp');

mask_CN_Transformed_Gini_group(Lon,Lat,GI_1d_transform_from_3h_3D_mean,GI_1d_transform_from_6h_3D_mean,GI_1d_transform_from_12h_3D_mean,...
    Differ_3h_3D_mean,Differ_6h_3D_mean,Differ_12h_3D_mean,shp0,shp,shp1,shp2,0.7,1,-0.18,0.18,shp_line_HR,shp_line_TR,shp_line_AR,shp_line_TP);

cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\002-01-CMFD-3h-6h-12h-1d-GI-and-Sen-Trend\')
exportgraphics(gcf,['3h、6h、12h转换的日尺度基尼系数和原日尺度基尼系数差值的多年平均.jpg'])