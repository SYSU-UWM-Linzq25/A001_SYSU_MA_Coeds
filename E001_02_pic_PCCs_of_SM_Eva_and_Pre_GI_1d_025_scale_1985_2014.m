%% 这个文件画SM和Eva的基尼系数和降水基尼系数的相关系数


clear;clc;

load('J:\6-硕士毕业论文\1-Data\PCCs_for_hydrological_response\PCCs_pre_and_Eva_1d_025_scale_1985_2014.mat')
load('J:\6-硕士毕业论文\1-Data\PCCs_for_hydrological_response\PCCs_pre_and_SM_1d_025_scale_1985_2014.mat')

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


%
mask_CN_HY_response_2_Group(Lon_025,Lat_025,PCCs_Pre_and_SM_GI_1d_025_scale,PCCs_Pre_and_Eva_GI_1d_025_scale,...
   P_Pre_and_SM_GI_1d_025_scale,P_Pre_and_Eva_GI_1d_025_scale,shp0,shp,shp1,shp2,-1,1,10,-1,1,10,shp_line_HR,shp_line_TR,shp_line_AR,shp_line_TP)
% 
cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\009-01-Hydrological-response-of-SM-and-Eva\')
exportgraphics(gcf,'降水基尼系数与土壤表层水含量和实际蒸发基尼系数的相关系数.jpg')












