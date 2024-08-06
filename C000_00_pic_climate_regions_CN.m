%% 这个文件参考杜师兄博士论文中的气候分区
%% 利用中科院资源环境科学与数据中心的DEM 1km数据和农业区划划分气候带
%% 包括四个气候带-湿润区（HR）、过渡区（TR）、 高寒区（TP）、干旱区（AR）

clear;clc;

%% 读取DEM高程的shp图
inputRasterFile='F:\File_of_MATLAB\6-硕士毕业论文\6-map\中国dem_1km_中科院资源环境科学与数据中心\dem_1km\dem_1km_Clip_GCS1984.tif';
[DataRaster,Ref] = geotiffread(inputRasterFile);%读取全国范围的栅格数据
DataRaster = flipud(DataRaster);
[m,n]=size(DataRaster);
lonSpan=Ref.LongitudeLimits;%栅格经度范围 73 135
latSpan=Ref.LatitudeLimits;%栅格纬度范围 18 54
resolution=Ref.CellExtentInLatitude;%栅格分辨率0.2500
resolution2=Ref.CellExtentInLongitude;%栅格分辨率0.2500
xgv = [lonSpan(1)+resolution2/2:resolution2:lonSpan(2)-resolution2/2];
ygv = [latSpan(1)+resolution/2:resolution:latSpan(2)-resolution/2];
DataRaster(DataRaster==32767)=nan;
a1 = double(max(max(DataRaster)));
b1 = double(min(min(DataRaster)));
% m_contourf(lon,lat,DataRaster,'linestyle','none');
DataRaster_double = double(DataRaster);
Lon = xgv';
Lat = ygv';
%% 读取shp图
shp0 = shaperead('J:\4-论文备份\论文代码2021.4.14\map\bou1_4p.shp');
shp = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\基于审图号GS(2019)1822号新制作的底图\新国界_无东沙赤尾钓鱼_需和Chinaline连用.shp');
shp1 = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\基于审图号GS(2019)1822号新制作的底图\New_China_line.shp');
shp2 = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\基于审图号GS(2019)1822号新制作的底图\Dongsha_Chiwei_Diaoyu.shp');
% 读取4个气候区的线shp图，叠加在绘图上
shp_line_HR = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\中国农业自然区划-中国科学院地理科学与资源研究所资源环境科学与数据中心\气候分区\Humid_Region_Dissolv_Line_GCS1984.shp');
shp_line_TR = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\中国农业自然区划-中国科学院地理科学与资源研究所资源环境科学与数据中心\气候分区\Transition_Region_Dissolv_Line_GCS1984.shp');
shp_line_AR = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\中国农业自然区划-中国科学院地理科学与资源研究所资源环境科学与数据中心\气候分区\Arid_Region_Dissolv_Line_GCS1984.shp');
shp_line_TP = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\中国农业自然区划-中国科学院地理科学与资源研究所资源环境科学与数据中心\气候分区\Tibetan_Plateau_Dissolv_Line_GCS1984.shp');


%% 设置颜色范围

%% 画图
mask_CN_DEM(Lon,Lat,DataRaster_double',shp0,shp,shp1,shp2,b1,a1,shp_line_HR,shp_line_TR,shp_line_AR,shp_line_TP)

cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\000-000-气候分区\')
exportgraphics(gcf,['气候分区及高程.jpg'])