%% 这个文件根据CMFD原始分辨率提取出来的30a期间的暴雨（heavy rain）频率、平均强度和降水量占比的趋势
%% 画Sen趋势的空间分布图
%% 研究时段为1985-2014
%% 时间尺度包括3h、6h、12h和1-day

%% 暴雨频率
clear;clc;

% 3h
clear filename
filename = 'heavy_rain_fre_01_scale_3h_pre_event_thresold_5_95_2D_matrix.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\3h\SenTrend\',filename])

% 6h
clear filename
filename = 'heavy_rain_fre_01_scale_6h_pre_event_thresold_5_95_2D_matrix.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\6h-from-Paper2\SenTrend\',filename])

% 12h
clear filename
filename = 'heavy_rain_fre_01_scale_12h_pre_event_thresold_5_95_2D_matrix.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\12h-from-Paper2\SenTrend\',filename])

% 1d
clear filename
filename = 'heavy_rain_fre_01_scale_1d_pre_event_thresold_5_95_2D_matrix.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\1d-from-Paper2\SenTrend\',filename])

shp0 = shaperead('J:\4-论文备份\论文代码2021.4.14\map\bou1_4p.shp');
shp = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\基于审图号GS(2019)1822号新制作的底图\新国界_无东沙赤尾钓鱼_需和Chinaline连用.shp');
shp1 = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\基于审图号GS(2019)1822号新制作的底图\New_China_line.shp');
shp2 = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\基于审图号GS(2019)1822号新制作的底图\Dongsha_Chiwei_Diaoyu.shp');
% 读取4个气候区的线shp图，叠加在绘图上
shp_line_HR = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\中国农业自然区划-中国科学院地理科学与资源研究所资源环境科学与数据中心\气候分区\Humid_Region_Dissolv_Line_GCS1984.shp');
shp_line_TR = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\中国农业自然区划-中国科学院地理科学与资源研究所资源环境科学与数据中心\气候分区\Transition_Region_Dissolv_Line_GCS1984.shp');
shp_line_AR = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\中国农业自然区划-中国科学院地理科学与资源研究所资源环境科学与数据中心\气候分区\Arid_Region_Dissolv_Line_GCS1984.shp');
shp_line_TP = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\中国农业自然区划-中国科学院地理科学与资源研究所资源环境科学与数据中心\气候分区\Tibetan_Plateau_Dissolv_Line_GCS1984.shp');

Data_all = nan(length(Lon),length(Lat),4);
Data_all(:,:,1) = heavy_rain_fre_SenTrend_3h_matrix;
Data_all(:,:,2) = heavy_rain_fre_SenTrend_6h_matrix;
Data_all(:,:,3) = heavy_rain_fre_SenTrend_12h_matrix;
Data_all(:,:,4) = heavy_rain_fre_SenTrend_1d_matrix;

a1 = min(min(min(Data_all)));
b1 = max(max(max(Data_all)));

mask_CN_Heavy_rain_Fre_Sen_Trend_group(Lon,Lat,heavy_rain_fre_SenTrend_3h_matrix,heavy_rain_fre_SenTrend_6h_matrix,heavy_rain_fre_SenTrend_12h_matrix,heavy_rain_fre_SenTrend_1d_matrix,...
    heavy_rain_fre_MKTrend_3h_matrix,heavy_rain_fre_MKTrend_6h_matrix,heavy_rain_fre_MKTrend_12h_matrix,heavy_rain_fre_MKTrend_1d_matrix,shp0,...
    shp,shp1,shp2,-0.6,0.6,6,shp_line_HR,shp_line_TR,shp_line_AR,shp_line_TP);

cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\008-02-CMFD-heavy-rain-fre-intensity-amount-percentage-SenTend-1985-2014\')
exportgraphics(gcf,['历史时期四个时间尺度下暴雨频率的趋势.jpg'])

%% 暴雨平均强度
clear;clc;

% 3h
clear filename
filename = 'heavy_rain_intensity_01_scale_3h_pre_event_thresold_5_95_2D_matrix.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\3h\SenTrend\',filename])

% 6h
clear filename
filename = 'heavy_rain_intensity_01_scale_6h_pre_event_thresold_5_95_2D_matrix.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\6h-from-Paper2\SenTrend\',filename])

% 12h
clear filename
filename = 'heavy_rain_intensity_01_scale_12h_pre_event_thresold_5_95_2D_matrix.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\12h-from-Paper2\SenTrend\',filename])

% 1d
clear filename
filename = 'heavy_rain_intensity_01_scale_1d_pre_event_thresold_5_95_2D_matrix.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\1d-from-Paper2\SenTrend\',filename])

shp0 = shaperead('J:\4-论文备份\论文代码2021.4.14\map\bou1_4p.shp');
shp = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\基于审图号GS(2019)1822号新制作的底图\新国界_无东沙赤尾钓鱼_需和Chinaline连用.shp');
shp1 = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\基于审图号GS(2019)1822号新制作的底图\New_China_line.shp');
shp2 = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\基于审图号GS(2019)1822号新制作的底图\Dongsha_Chiwei_Diaoyu.shp');
% 读取4个气候区的线shp图，叠加在绘图上
shp_line_HR = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\中国农业自然区划-中国科学院地理科学与资源研究所资源环境科学与数据中心\气候分区\Humid_Region_Dissolv_Line_GCS1984.shp');
shp_line_TR = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\中国农业自然区划-中国科学院地理科学与资源研究所资源环境科学与数据中心\气候分区\Transition_Region_Dissolv_Line_GCS1984.shp');
shp_line_AR = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\中国农业自然区划-中国科学院地理科学与资源研究所资源环境科学与数据中心\气候分区\Arid_Region_Dissolv_Line_GCS1984.shp');
shp_line_TP = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\中国农业自然区划-中国科学院地理科学与资源研究所资源环境科学与数据中心\气候分区\Tibetan_Plateau_Dissolv_Line_GCS1984.shp');

Data_all = nan(length(Lon),length(Lat),4);
Data_all(:,:,1) = heavy_rain_intensity_SenTrend_3h_matrix;
Data_all(:,:,2) = heavy_rain_intensity_SenTrend_6h_matrix;
Data_all(:,:,3) = heavy_rain_intensity_SenTrend_12h_matrix;
Data_all(:,:,4) = heavy_rain_intensity_SenTrend_1d_matrix;

a1 = min(min(min(Data_all)));
b1 = max(max(max(Data_all)));
%%
mask_CN_Heavy_rain_Fre_Sen_Trend_group(Lon,Lat,heavy_rain_intensity_SenTrend_3h_matrix,heavy_rain_intensity_SenTrend_6h_matrix,heavy_rain_intensity_SenTrend_12h_matrix,heavy_rain_intensity_SenTrend_1d_matrix,...
    heavy_rain_intensity_MKTrend_3h_matrix,heavy_rain_intensity_MKTrend_6h_matrix,heavy_rain_intensity_MKTrend_12h_matrix,heavy_rain_intensity_MKTrend_1d_matrix,shp0,...
    shp,shp1,shp2,-0.16,0.16,8,shp_line_HR,shp_line_TR,shp_line_AR,shp_line_TP);
cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\008-02-CMFD-heavy-rain-fre-intensity-amount-percentage-SenTend-1985-2014\')
exportgraphics(gcf,['历史时期四个时间尺度下暴雨平均强度的趋势.jpg'])

%% 暴雨降水量占比
clear;clc;

% 3h
clear filename
filename = 'heavy_rain_amount_percentage_01_scale_3h_pre_event_thresold_5_95_2D_matrix.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\3h\SenTrend\',filename])

% 6h
clear filename
filename = 'heavy_rain_amount_percentage_01_scale_6h_pre_event_thresold_5_95_2D_matrix.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\6h-from-Paper2\SenTrend\',filename])

% 12h
clear filename
filename = 'heavy_rain_amount_percentage_01_scale_12h_pre_event_thresold_5_95_2D_matrix.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\12h-from-Paper2\SenTrend\',filename])

% 1d
clear filename
filename = 'heavy_rain_amount_percentage_01_scale_1d_pre_event_thresold_5_95_2D_matrix.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\1d-from-Paper2\SenTrend\',filename])

shp0 = shaperead('J:\4-论文备份\论文代码2021.4.14\map\bou1_4p.shp');
shp = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\基于审图号GS(2019)1822号新制作的底图\新国界_无东沙赤尾钓鱼_需和Chinaline连用.shp');
shp1 = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\基于审图号GS(2019)1822号新制作的底图\New_China_line.shp');
shp2 = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\基于审图号GS(2019)1822号新制作的底图\Dongsha_Chiwei_Diaoyu.shp');
% 读取4个气候区的线shp图，叠加在绘图上
shp_line_HR = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\中国农业自然区划-中国科学院地理科学与资源研究所资源环境科学与数据中心\气候分区\Humid_Region_Dissolv_Line_GCS1984.shp');
shp_line_TR = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\中国农业自然区划-中国科学院地理科学与资源研究所资源环境科学与数据中心\气候分区\Transition_Region_Dissolv_Line_GCS1984.shp');
shp_line_AR = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\中国农业自然区划-中国科学院地理科学与资源研究所资源环境科学与数据中心\气候分区\Arid_Region_Dissolv_Line_GCS1984.shp');
shp_line_TP = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\中国农业自然区划-中国科学院地理科学与资源研究所资源环境科学与数据中心\气候分区\Tibetan_Plateau_Dissolv_Line_GCS1984.shp');

Data_all = nan(length(Lon),length(Lat),4);
Data_all(:,:,1) = heavy_rain_amount_percentage_SenTrend_3h_matrix;
Data_all(:,:,2) = heavy_rain_amount_percentage_SenTrend_6h_matrix;
Data_all(:,:,3) = heavy_rain_amount_percentage_SenTrend_12h_matrix;
Data_all(:,:,4) = heavy_rain_amount_percentage_SenTrend_1d_matrix;

a1 = min(min(min(Data_all)));
b1 = max(max(max(Data_all)));
%%
mask_CN_Heavy_rain_Fre_Sen_Trend_group(Lon,Lat,heavy_rain_amount_percentage_SenTrend_3h_matrix,heavy_rain_amount_percentage_SenTrend_6h_matrix,heavy_rain_amount_percentage_SenTrend_12h_matrix,heavy_rain_amount_percentage_SenTrend_1d_matrix,...
    heavy_rain_amount_percentage_MKTrend_3h_matrix,heavy_rain_amount_percentage_MKTrend_6h_matrix,heavy_rain_amount_percentage_MKTrend_12h_matrix,heavy_rain_amount_percentage_MKTrend_1d_matrix,shp0,...
    shp,shp1,shp2,-2.4,2.4,8,shp_line_HR,shp_line_TR,shp_line_AR,shp_line_TP);

cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\008-02-CMFD-heavy-rain-fre-intensity-amount-percentage-SenTend-1985-2014\')
exportgraphics(gcf,['历史时期四个时间尺度下暴雨降水量占比的趋势.jpg'])

close all