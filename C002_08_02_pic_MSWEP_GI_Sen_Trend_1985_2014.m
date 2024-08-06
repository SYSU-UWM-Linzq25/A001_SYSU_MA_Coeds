%% 这个文件画MSWEP数据四种时间尺度的基尼系数和趋势
%% 原始空间尺度（0.25°）
%% 3-hour以外的时间尺度从3-hour升尺度而来

clear;clc;

load('J:\6-硕士毕业论文\1-Data\MSWEP-V280-1985-2014\range.mat')
Lat_2 = flip(Lat); % lat是按照递减序列排列的，所以要现改成增序

% 3-hour
filename2 = 'MSWEP_3h_Gini_MK_and_Sen_1985_2014_01mmh.mat';
load(['J:\6-硕士毕业论文\1-Data\MSWEP-V280-1985-2014\003-GI-Sen-slope\',filename2])

% 注意MWSEP在处理过程中，lat是按照递减序列排列的，所以要现改成增序
Gini_Sen_slope_3h_2 = nan(size(Gini_Sen_slope_3h));
Gini_MK_3h_2 = nan(size(Gini_MK_3h));
for i = 1 : length(Lat)
    Gini_Sen_slope_3h_2(length(Lat)+1-i,:) = Gini_Sen_slope_3h(i,:);  
    Gini_MK_3h_2(length(Lat)+1-i,:) = Gini_MK_3h(i,:);  
end
clear Gini_Sen_slope_3h Gini_MK_3h

% 6-hour
clear filename2
filename2 = 'MSWEP_6h_Gini_MK_and_Sen_1985_2014_01mmh.mat';
load(['J:\6-硕士毕业论文\1-Data\MSWEP-V280-1985-2014\003-GI-Sen-slope\',filename2])

% 注意MWSEP在处理过程中，lat是按照递减序列排列的，所以要现改成增序
Gini_Sen_slope_6h_2 = nan(size(Gini_Sen_slope_6h));
Gini_MK_6h_2 = nan(size(Gini_MK_6h));
for i = 1 : length(Lat)
    Gini_Sen_slope_6h_2(length(Lat)+1-i,:) = Gini_Sen_slope_6h(i,:);  
    Gini_MK_6h_2(length(Lat)+1-i,:) = Gini_MK_6h(i,:);  
end
clear Gini_Sen_slope_6h Gini_MK_6h

% 12-hour
clear filename2
filename2 = 'MSWEP_12h_Gini_MK_and_Sen_1985_2014_01mmh.mat';
load(['J:\6-硕士毕业论文\1-Data\MSWEP-V280-1985-2014\003-GI-Sen-slope\',filename2])

% 注意MWSEP在处理过程中，lat是按照递减序列排列的，所以要现改成增序
Gini_Sen_slope_12h_2 = nan(size(Gini_Sen_slope_12h));
Gini_MK_12h_2 = nan(size(Gini_MK_12h));
for i = 1 : length(Lat)
    Gini_Sen_slope_12h_2(length(Lat)+1-i,:) = Gini_Sen_slope_12h(i,:);  
    Gini_MK_12h_2(length(Lat)+1-i,:) = Gini_MK_12h(i,:);  
end
clear Gini_Sen_slope_12h Gini_MK_12h

% 1-day
clear filename2
filename2 = 'MSWEP_1d_Gini_MK_and_Sen_1985_2014_01mmh.mat';
load(['J:\6-硕士毕业论文\1-Data\MSWEP-V280-1985-2014\003-GI-Sen-slope\',filename2])

% 注意MWSEP在处理过程中，lat是按照递减序列排列的，所以要现改成增序
Gini_Sen_slope_1d_2 = nan(size(Gini_Sen_slope_1d));
Gini_MK_1d_2 = nan(size(Gini_MK_1d));
for i = 1 : length(Lat)
    Gini_Sen_slope_1d_2(length(Lat)+1-i,:) = Gini_Sen_slope_1d(i,:);  
    Gini_MK_1d_2(length(Lat)+1-i,:) = Gini_MK_1d(i,:);  
end
clear Gini_Sen_slope_1d Gini_MK_1d

shp0 = shaperead('J:\4-论文备份\论文代码2021.4.14\map\bou1_4p.shp');
shp = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\基于审图号GS(2019)1822号新制作的底图\新国界_无东沙赤尾钓鱼_需和Chinaline连用.shp');
shp1 = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\基于审图号GS(2019)1822号新制作的底图\New_China_line.shp');
shp2 = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\基于审图号GS(2019)1822号新制作的底图\Dongsha_Chiwei_Diaoyu.shp');
% 读取4个气候区的线shp图，叠加在绘图上
shp_line_HR = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\中国农业自然区划-中国科学院地理科学与资源研究所资源环境科学与数据中心\气候分区\Humid_Region_Dissolv_Line_GCS1984.shp');
shp_line_TR = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\中国农业自然区划-中国科学院地理科学与资源研究所资源环境科学与数据中心\气候分区\Transition_Region_Dissolv_Line_GCS1984.shp');
shp_line_AR = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\中国农业自然区划-中国科学院地理科学与资源研究所资源环境科学与数据中心\气候分区\Arid_Region_Dissolv_Line_GCS1984.shp');
shp_line_TP = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\中国农业自然区划-中国科学院地理科学与资源研究所资源环境科学与数据中心\气候分区\Tibetan_Plateau_Dissolv_Line_GCS1984.shp');

% 确认一下范围
Gini_Sen_slope_all = nan(size(Gini_Sen_slope_3h_2,1),size(Gini_Sen_slope_3h_2,2),4);
Gini_Sen_slope_all(:,:,1) = Gini_Sen_slope_3h_2;
Gini_Sen_slope_all(:,:,2) = Gini_Sen_slope_6h_2;
Gini_Sen_slope_all(:,:,3) = Gini_Sen_slope_12h_2;
Gini_Sen_slope_all(:,:,4) = Gini_Sen_slope_1d_2;

a1 = min(min(min(Gini_Sen_slope_all)));
b1 = max(max(max(Gini_Sen_slope_all)));

mask_CN_Gini_Sen_Trend_group(Lon,Lat_2,Gini_Sen_slope_3h_2',Gini_Sen_slope_6h_2',Gini_Sen_slope_12h_2',Gini_Sen_slope_1d_2',Gini_MK_3h_2',Gini_MK_6h_2',...
    Gini_MK_12h_2',Gini_MK_1d_2',shp0,shp,shp1,shp2,-0.004,0.004,shp_line_HR,shp_line_TR,shp_line_AR,shp_line_TP);
%%
cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\002-06-MSWEP-3h-6h-12h-1d-GI-and-Sen-Trend\')
exportgraphics(gcf,['MSWEP四个时间尺度下的基尼系数Sen趋势.jpg'])