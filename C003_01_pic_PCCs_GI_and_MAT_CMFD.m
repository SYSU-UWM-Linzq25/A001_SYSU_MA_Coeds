%% 这个文件将CMFD数据计算得到的基尼系数与年均温相关系数画成空间分布图
%% 研究时段为1985-2014

clear;clc;

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

save_peth_1 = 'J:\6-硕士毕业论文\1-Data\PCCs-bewteen-MAT-and-GI\';
cd(save_peth_1)
filename2 = 'PCCs_of_CMFD_MAT_and_GI_01_scale_1985_2014.mat';
load(filename2)

mask_CN_PCCs_MAT_group(Lon,Lat,PCCs_3h_GI_MAT,PCCs_6h_GI_MAT,PCCs_12h_GI_MAT,...
    PCCs_1d_GI_MAT,p_value_3h,p_value_6h,p_value_12h,p_value_1d,shp0,shp,shp1,shp2,-1,1,10,shp_line_HR,shp_line_TR,shp_line_AR,shp_line_TP)
%%
cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\003-01-PCCs-MAT-and-GI\CMFD\')
exportgraphics(gcf,['温度对降水集中度的影响-CMFD.jpg'])