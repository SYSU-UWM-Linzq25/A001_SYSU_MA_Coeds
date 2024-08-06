%% 这个文件画CMFD数据四种时间尺度的基尼系数的多年平均值
%% 原始空间尺度（0.1°）
%% 3-hour以外的时间尺度从3-hour升尺度而来

clear;clc;
% 3h
filename2 = 'CMFD_3h_Gini_1979_2018_01mmh.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\3-1-Gini&LinearTrend\',filename2])
% 统一选取年份范围为1985-2014
Gini_CMFD_3h_1985_2014 = Gini_CMFD_3h(:,:,7:end-4);
Gini_CMFD_3h_1985_2014_mean = nanmean(Gini_CMFD_3h_1985_2014,3);
clear Gini_CMFD_3h
% 6-hour
clear filename2
filename2 = 'Full Gini index 6h.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\0-from-paper2\6h\full Gini\',filename2])
% 统一选取年份范围为1985-2014
Gini_CMFD_6h_1985_2014 = Full_Gini_6h_all(:,:,7:end-4);
Gini_CMFD_6h_1985_2014_mean = nanmean(Gini_CMFD_6h_1985_2014,3);
clear Full_Gini_6h_all
% 12-hour
clear filename2
filename2 = 'Full Gini index 12h.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\0-from-paper2\12h\full Gini\',filename2])
% 统一选取年份范围为1985-2014
Gini_CMFD_12h_1985_2014 = Full_Gini_12h_all(:,:,7:end-4);
Gini_CMFD_12h_1985_2014_mean = nanmean(Gini_CMFD_12h_1985_2014,3);
clear Full_Gini_12h_all
% 1-day
clear filename2
filename2 = 'Full Gini index 1d.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\0-from-paper2\1d\full Gini\',filename2])
% 统一选取年份范围为1985-2014
Gini_CMFD_1d_1985_2014 = Full_Gini_1d_all(:,:,7:end-4);
Gini_CMFD_1d_1985_2014_mean = nanmean(Gini_CMFD_1d_1985_2014,3);
clear Full_Gini_1d_all

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

mask_CN_Gini_group(Lon,Lat,Gini_CMFD_3h_1985_2014_mean,Gini_CMFD_6h_1985_2014_mean,Gini_CMFD_12h_1985_2014_mean,Gini_CMFD_1d_1985_2014_mean,...
    shp0,shp,shp1,shp2,0.7,1,shp_line_HR,shp_line_TR,shp_line_AR,shp_line_TP);

cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\002-01-CMFD-3h-6h-12h-1d-GI-and-Sen-Trend\01-scale\')
exportgraphics(gcf,['四个时间尺度下的基尼系数多年平均值.jpg'])