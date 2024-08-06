%% 这个文件将气候区对应的索引进行提取
%% 包括两种空间尺度，0.1°（用于CMFD结果的气候区分析）；0.25°用于未来情况下的气候区分析和模型优选
%% 注意数据的格式，对于0.1°其二维格式应该是700×400；对于0.25°其二维格式应该是

clear;clc;

% 读取0.1°下的经纬度网格
filename2 = 'CMFD_3h_Gini_1979_2018_01mmh.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\3-1-Gini&LinearTrend\',filename2])
clear Gini_CMFD_3h

% 读取0.25°下的经纬度网格
clear filename2
filename2 = 'CMFD_1d_Gini_025_scale_01mmh_1979_2018_from_Paper2.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\0-from-paper2\',filename2]);

% 首先根据气候区的shp图为点赋值（要用polgyon）
shp_HR = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\中国农业自然区划-中国科学院地理科学与资源研究所资源环境科学与数据中心\气候分区\Humid_Region_Dissolv_GCS1984.shp');
shp_TR = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\中国农业自然区划-中国科学院地理科学与资源研究所资源环境科学与数据中心\气候分区\Transition_Region_Dissolv_GCS1984.shp');
shp_AR = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\中国农业自然区划-中国科学院地理科学与资源研究所资源环境科学与数据中心\气候分区\Arid_Region_Dissolv_GCS1984.shp');
shp_TP = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\中国农业自然区划-中国科学院地理科学与资源研究所资源环境科学与数据中心\气候分区\Tibetan_Plateau_Dissolv_GCS1984.shp');

shp_HR_X = [shp_HR(:).X];
shp_HR_Y = [shp_HR(:).Y];
shp_TR_X = [shp_TR(:).X];
shp_TR_Y = [shp_TR(:).Y];
shp_AR_X = [shp_AR(:).X];
shp_AR_Y = [shp_AR(:).Y];
shp_TP_X = [shp_TP(:).X];
shp_TP_Y = [shp_TP(:).Y];

%% 0.1°
[xx_01,yy_01] = meshgrid(Lon,Lat);
Four_climate_zone_index_01 = nan(length(Lon),length(Lat));
for j = 1 : length(Lat)
    for i = 1 : length(Lon)
        clear pixel_lon pixel_lat in_HR on_HR in_TR on_TR in_AR on_AR in_TP on_TP
        pixel_lon = xx_01(j,i);
        pixel_lat = yy_01(j,i);
        
        [in_HR,on_HR] = inpolygon(pixel_lon,pixel_lat,shp_HR_X,shp_HR_Y);
        [in_TR,on_TR] = inpolygon(pixel_lon,pixel_lat,shp_TR_X,shp_TR_Y);
        [in_AR,on_AR] = inpolygon(pixel_lon,pixel_lat,shp_AR_X,shp_AR_Y);
        [in_TP,on_TP] = inpolygon(pixel_lon,pixel_lat,shp_TP_X,shp_TP_Y);
        
        if in_HR == 1 || on_HR == 1
            Four_climate_zone_index_01(i,j) = 1;
        elseif in_TR == 1 || on_TR == 1
            Four_climate_zone_index_01(i,j) = 2;
        elseif in_AR == 1  || on_AR == 1
            Four_climate_zone_index_01(i,j) = 3;
        elseif in_TP == 1  || on_TP == 1
            Four_climate_zone_index_01(i,j) = 4;
        end
    end
end
save(['J:\6-硕士毕业论文\1-Data\Climate_zone_index\', 'Four_Climite_zone_index_01_scale.mat'], 'Four_climate_zone_index_01','Lon','Lat') 
% 验证
figure
pcolor(xx_01,yy_01,Four_climate_zone_index_01')
colorbar
disp('finish')

%% 0.25°
clear i j 
[xx_025,yy_025] = meshgrid(Lon_025,Lat_025);
Four_climate_zone_index_025 = nan(length(Lon_025),length(Lat_025));
for j = 1 : length(Lat_025)
    for i = 1 : length(Lon_025)
        clear pixel_lon pixel_lat in_HR on_HR in_TR on_TR in_AR on_AR in_TP on_TP
        pixel_lon = xx_025(j,i);
        pixel_lat = yy_025(j,i);
        
        [in_HR,on_HR] = inpolygon(pixel_lon,pixel_lat,shp_HR_X,shp_HR_Y);
        [in_TR,on_TR] = inpolygon(pixel_lon,pixel_lat,shp_TR_X,shp_TR_Y);
        [in_AR,on_AR] = inpolygon(pixel_lon,pixel_lat,shp_AR_X,shp_AR_Y);
        [in_TP,on_TP] = inpolygon(pixel_lon,pixel_lat,shp_TP_X,shp_TP_Y);
        
        if in_HR == 1 || on_HR == 1
            Four_climate_zone_index_025(i,j) = 1;
        elseif in_TR == 1 || on_TR == 1
            Four_climate_zone_index_025(i,j) = 2;
        elseif in_AR == 1  || on_AR == 1
            Four_climate_zone_index_025(i,j) = 3;
        elseif in_TP == 1  || on_TP == 1
            Four_climate_zone_index_025(i,j) = 4;
        end
    end
end
save(['J:\6-硕士毕业论文\1-Data\Climate_zone_index\', 'Four_Climite_zone_index_025_scale.mat'], 'Four_climate_zone_index_025','Lon_025','Lat_025') 
% 验证
figure
pcolor(xx_025,yy_025,Four_climate_zone_index_025')
colorbar
disp('finish')

