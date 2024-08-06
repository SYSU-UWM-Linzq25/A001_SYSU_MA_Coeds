%% 这个文件根据CMFD原始分辨率提取出来的30a期间的暴雨（heavy rain）频率、平均强度和降水量占比三维矩阵
%% 画多年平均值的空间分布图
%% 研究时段为1985-2014
%% 时间尺度包括3h、6h、12h和1-day

clear;clc;

path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')
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

% 计算暴雨降水量占比的多年平均
heavy_rain_amount_percentage_3h_mean = nanmean(heavy_rain_amount_percentage_3h_matrix,3);
heavy_rain_amount_percentage_6h_mean = nanmean(heavy_rain_amount_percentage_6h_matrix,3);
heavy_rain_amount_percentage_12h_mean = nanmean(heavy_rain_amount_percentage_12h_matrix,3);
heavy_rain_amount_percentage_1d_mean = nanmean(heavy_rain_amount_percentage_1d_matrix,3);

% 计算暴雨平均降水强度的多年平均
heavy_rain_intensity_3h_matrix_mean = nanmean(heavy_rain_intensity_3h_matrix,3);
heavy_rain_intensity_6h_matrix_mean = nanmean(heavy_rain_intensity_6h_matrix,3);
heavy_rain_intensity_12h_matrix_mean = nanmean(heavy_rain_intensity_12h_matrix,3);
heavy_rain_intensity_1d_matrix_mean = nanmean(heavy_rain_intensity_1d_matrix,3);

% 计算暴雨发生频率的多年平均
heavy_rain_fre_3h_matrix_mean = nanmean(heavy_rain_fre_3h_matrix,3);
heavy_rain_fre_6h_matrix_mean = nanmean(heavy_rain_fre_6h_matrix,3);
heavy_rain_fre_12h_matrix_mean = nanmean(heavy_rain_fre_12h_matrix,3);
heavy_rain_fre_1d_matrix_mean = nanmean(heavy_rain_fre_1d_matrix,3);

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

%% 暴雨频率的多年平均的空间分布图

heavy_rain_fre_3h_matrix_all = nan(length(Lon),length(Lat),4);
heavy_rain_fre_3h_matrix_all(:,:,1) = heavy_rain_fre_3h_matrix_mean;
heavy_rain_fre_3h_matrix_all(:,:,2) = heavy_rain_fre_6h_matrix_mean;
heavy_rain_fre_3h_matrix_all(:,:,3) = heavy_rain_fre_12h_matrix_mean;
heavy_rain_fre_3h_matrix_all(:,:,4) = heavy_rain_fre_1d_matrix_mean;

a1 = min(min(min(heavy_rain_fre_3h_matrix_all)));
b1 = max(max(max(heavy_rain_fre_3h_matrix_all)));

mask_CN_Heavy_rain_fre_or_amount_percentage_group(Lon,Lat,heavy_rain_fre_3h_matrix_mean,heavy_rain_fre_6h_matrix_mean,heavy_rain_fre_12h_matrix_mean,heavy_rain_fre_1d_matrix_mean,...
    shp0,shp,shp1,shp2,2.5,8.5,6,shp_line_HR,shp_line_TR,shp_line_AR,shp_line_TP);

cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\008-01-CMFD-heavy-rain-fre-intensity-amount-percentage-1985-2014\')
exportgraphics(gcf,['历史时期四个时间尺度下暴雨频率占比的多年平均值.jpg'])

%% 暴雨降水量占比的多年平均的空间分布图

heavy_rain_amount_percentage_matrix_all = nan(length(Lon),length(Lat),4);
heavy_rain_amount_percentage_matrix_all(:,:,1) = heavy_rain_amount_percentage_3h_mean;
heavy_rain_amount_percentage_matrix_all(:,:,2) = heavy_rain_amount_percentage_6h_mean;
heavy_rain_amount_percentage_matrix_all(:,:,3) = heavy_rain_amount_percentage_12h_mean;
heavy_rain_amount_percentage_matrix_all(:,:,4) = heavy_rain_amount_percentage_1d_mean;

a1 = min(min(min(heavy_rain_amount_percentage_matrix_all)));
b1 = max(max(max(heavy_rain_amount_percentage_matrix_all)));

mask_CN_Heavy_rain_fre_or_amount_percentage_group(Lon,Lat,heavy_rain_amount_percentage_3h_mean,heavy_rain_amount_percentage_6h_mean,heavy_rain_amount_percentage_12h_mean,heavy_rain_amount_percentage_1d_mean,...
    shp0,shp,shp1,shp2,10,45,7,shp_line_HR,shp_line_TR,shp_line_AR,shp_line_TP);

cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\008-01-CMFD-heavy-rain-fre-intensity-amount-percentage-1985-2014\')
exportgraphics(gcf,['历史时期四个时间尺度下暴雨降水量占比的多年平均值.jpg'])


%% 暴雨平均降水强度的多年平均的空间分布图

heavy_rain_intensity_matrix_all = nan(length(Lon),length(Lat),4);
heavy_rain_intensity_matrix_all(:,:,1) = heavy_rain_intensity_3h_matrix_mean;
heavy_rain_intensity_matrix_all(:,:,2) = heavy_rain_intensity_6h_matrix_mean;
heavy_rain_intensity_matrix_all(:,:,3) = heavy_rain_intensity_12h_matrix_mean;
heavy_rain_intensity_matrix_all(:,:,4) = heavy_rain_intensity_1d_matrix_mean;

a1 = min(min(min(heavy_rain_intensity_matrix_all)));
b1 = max(max(max(heavy_rain_intensity_matrix_all)));

mask_CN_Heavy_rain_intensity_group(Lon,Lat,heavy_rain_intensity_3h_matrix_mean,heavy_rain_intensity_6h_matrix_mean,heavy_rain_intensity_12h_matrix_mean,heavy_rain_intensity_1d_matrix_mean,...
    shp0,shp,shp1,shp2,0,8,8,shp_line_HR,shp_line_TR,shp_line_AR,shp_line_TP);

cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\008-01-CMFD-heavy-rain-fre-intensity-amount-percentage-1985-2014\')
exportgraphics(gcf,['历史时期四个时间尺度下暴雨平均降水强度的多年平均值.jpg'])














