%% 这个文件画MSWEP数据源计算出来的四种时间尺度的降水集中度
%% 直接使用英文文章用的，经过检查，数据处理和基尼系数计算都没有问题，阈值也是用的一样

clear;clc
load('F:\File_of_MATLAB\research_of_MSWEP\data\range.mat')
Lat_2 = flip(Lat); % lat是按照递减序列排列的，所以要现改成增序
% 3h MWSEP
load('F:\File_of_MATLAB\research_of_MSWEP\data\Full Gini index 3h preprocessing01.mat')

% 数据的时间尺度从1979-2015，所以只取出其中1985-2014部分
Full_Gini_3h_MWSEP_1985_2014 = Full_Gini_3h_MWSEP(:,:,7:end-1);
clear Full_Gini_3h_MWSEP
Gini_MSWEP_3h_1985_2014_mean = nanmean(Full_Gini_3h_MWSEP_1985_2014,3);
clear Full_Gini_3h_MWSEP_1985_2014

% 注意MWSEP在处理过程中，lat是按照递减序列排列的，所以要现改成增序
Gini_MSWEP_3h_1985_2014_mean_2 = nan(size(Gini_MSWEP_3h_1985_2014_mean));
for i = 1 : length(Lat)
    Gini_MSWEP_3h_1985_2014_mean_2(length(Lat)+1-i,:) = Gini_MSWEP_3h_1985_2014_mean(i,:);  
end
clear Gini_MSWEP_3h_1985_2014_mean

% 6-hour
load('F:\File_of_MATLAB\research_of_MSWEP\data\Full Gini index 6h preprocessing01.mat')

% 数据的时间尺度从1979-2015，所以只取出其中1985-2014部分
Full_Gini_6h_MWSEP_1985_2014 = Full_Gini_6h_MWSEP(:,:,7:end-1);
clear Full_Gini_6h_MWSEP
Gini_MSWEP_6h_1985_2014_mean = nanmean(Full_Gini_6h_MWSEP_1985_2014,3);
clear Full_Gini_6h_MWSEP_1985_2014

% 注意MWSEP在处理过程中，lat是按照递减序列排列的，所以要现改成增序
Gini_MSWEP_6h_1985_2014_mean_2 = nan(size(Gini_MSWEP_6h_1985_2014_mean));
for i = 1 : length(Lat)
    Gini_MSWEP_6h_1985_2014_mean_2(length(Lat)+1-i,:) = Gini_MSWEP_6h_1985_2014_mean(i,:);  
end
clear Gini_MSWEP_6h_1985_2014_mean

% 12-hour
load('F:\File_of_MATLAB\research_of_MSWEP\data\Full Gini index 12h preprocessing01.mat')

% 数据的时间尺度从1979-2015，所以只取出其中1985-2014部分
Full_Gini_12h_MWSEP_1985_2014 = Full_Gini_12h_MWSEP(:,:,7:end-1);
clear Full_Gini_12h_MWSEP
Gini_MSWEP_12h_1985_2014_mean = nanmean(Full_Gini_12h_MWSEP_1985_2014,3);
clear Full_Gini_12h_MWSEP_1985_2014

% 注意MWSEP在处理过程中，lat是按照递减序列排列的，所以要现改成增序
Gini_MSWEP_12h_1985_2014_mean_2 = nan(size(Gini_MSWEP_12h_1985_2014_mean));
for i = 1 : length(Lat)
    Gini_MSWEP_12h_1985_2014_mean_2(length(Lat)+1-i,:) = Gini_MSWEP_12h_1985_2014_mean(i,:);  
end
clear Gini_MSWEP_12h_1985_2014_mean

% 1-day
load('F:\File_of_MATLAB\research_of_MSWEP\data\Full Gini index 1d preprocessing01.mat')

% 数据的时间尺度从1979-2015，所以只取出其中1985-2014部分
Full_Gini_1d_MWSEP_1985_2014 = Full_Gini_1d_MWSEP(:,:,7:end-1);
clear Full_Gini_1d_MWSEP
Gini_MSWEP_1d_1985_2014_mean = nanmean(Full_Gini_1d_MWSEP_1985_2014,3);
clear Full_Gini_1d_MWSEP_1985_2014

% 注意MWSEP在处理过程中，lat是按照递减序列排列的，所以要现改成增序
Gini_MSWEP_1d_1985_2014_mean_2 = nan(size(Gini_MSWEP_1d_1985_2014_mean));
for i = 1 : length(Lat)
    Gini_MSWEP_1d_1985_2014_mean_2(length(Lat)+1-i,:) = Gini_MSWEP_1d_1985_2014_mean(i,:);  
end
clear Gini_MSWEP_1d_1985_2014_mean

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

mask_CN_Gini_group(Lon,Lat_2,Gini_MSWEP_3h_1985_2014_mean_2',Gini_MSWEP_6h_1985_2014_mean_2',Gini_MSWEP_12h_1985_2014_mean_2',Gini_MSWEP_1d_1985_2014_mean_2',...
    shp0,shp,shp1,shp2,0.7,1,shp_line_HR,shp_line_TR,shp_line_AR,shp_line_TP);

cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\002-06-MSWEP-3h-6h-12h-1d-GI-and-Sen-Trend\')
exportgraphics(gcf,['MSWEP四个时间尺度下的基尼系数多年平均值.jpg'])