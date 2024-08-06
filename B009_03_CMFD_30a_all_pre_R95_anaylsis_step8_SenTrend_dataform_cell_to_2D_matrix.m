%% 这个文件将第二步中提取出来的三种雨中暴雨（heavy rain）的的频率、平均降水强度、降水量占比的Sen斜率
%% 从cell存储格式转回三维矩阵
%% 研究时段为1985-2014
%% 时间尺度包括3-hour、6-hour、12-hour、1-day
%% 3-hour

clear;clc;

path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')
% 为了加快运算速度，可以根据之前的结果，将中国地区的pixel索引进行利用
filename_1 = ['pre1_3h_no_preprocessing_',num2str(2000),'.mat'];
load(['J:\6-硕士毕业论文\1-Data\CMFD\1-origin-data-3h\Pre\',filename_1])
pre_year = sum(pre_3h_noprocessing,3);
clear pre_3h_noprocessing
mask_China_line = reshape(pre_year,[1,length(Lon)*length(Lat)]);
k = find(~isnan(mask_China_line));
k1 = find(isnan(mask_China_line));
clear pre_year

clear filename2
filename2 = 'SenTrend_fre_CMFD_3h_01_scale_thresold_5_95_in_cell.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\3h\SenTrend\',filename2]);
clear filename2
filename2 = 'SenTrend_intensity_CMFD_3h_01_scale_thresold_5_95_in_cell.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\3h\SenTrend\',filename2]);
clear filename2
filename2 = 'SenTrend_percentage_CMFD_3h_01_scale_thresold_5_95_in_cell.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\3h\SenTrend\',filename2]);

% 用一维向量进行读取
heavy_rain_fre_SenTrend_3h_matrix_line = nan(size(mask_China_line));
heavy_rain_intensity_SenTrend_3h_matrix_line = nan(size(mask_China_line));
heavy_rain_amount_percentage_SenTrend_3h_matrix_line = nan(size(mask_China_line));
heavy_rain_fre_MKTrend_3h_matrix_line = nan(size(mask_China_line));
heavy_rain_intensity_MKTrend_3h_matrix_line = nan(size(mask_China_line));
heavy_rain_amount_percentage_MKTrend_3h_matrix_line = nan(size(mask_China_line));
for i = 1 : length(k)
    heavy_rain_fre_SenTrend_3h_matrix_line(k(i)) = Sen_slope_fre(3,i);% 这里的单位是%
    heavy_rain_intensity_SenTrend_3h_matrix_line(k(i)) = Sen_slope_intensity(3,i); % 这里的单位是mmh
    heavy_rain_amount_percentage_SenTrend_3h_matrix_line(k(i)) = Sen_slope_percentage(3,i); % 这里的单位是%
    heavy_rain_fre_MKTrend_3h_matrix_line(k(i)) = MK_Trend_Z_fre(3,i);% 这里的单位是%
    heavy_rain_intensity_MKTrend_3h_matrix_line(k(i)) = MK_Trend_Z_intensity(3,i); % 这里的单位是mmh
    heavy_rain_amount_percentage_MKTrend_3h_matrix_line(k(i)) = MK_Trend_Z_percentage(3,i); % 这里的单位是%    
end

% 转回二维
heavy_rain_fre_SenTrend_3h_matrix = reshape(heavy_rain_fre_SenTrend_3h_matrix_line,[length(Lon),length(Lat)]);
heavy_rain_intensity_SenTrend_3h_matrix = reshape(heavy_rain_intensity_SenTrend_3h_matrix_line,[length(Lon),length(Lat)]);
heavy_rain_amount_percentage_SenTrend_3h_matrix = reshape(heavy_rain_amount_percentage_SenTrend_3h_matrix_line,[length(Lon),length(Lat)]);
heavy_rain_fre_MKTrend_3h_matrix = reshape(heavy_rain_fre_MKTrend_3h_matrix_line,[length(Lon),length(Lat)]);
heavy_rain_intensity_MKTrend_3h_matrix = reshape(heavy_rain_intensity_MKTrend_3h_matrix_line,[length(Lon),length(Lat)]);
heavy_rain_amount_percentage_MKTrend_3h_matrix = reshape(heavy_rain_amount_percentage_MKTrend_3h_matrix_line,[length(Lon),length(Lat)]);

clear filename
filename = 'heavy_rain_fre_01_scale_3h_pre_event_thresold_5_95_2D_matrix.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\3h\SenTrend\',filename],...
    'heavy_rain_fre_SenTrend_3h_matrix','heavy_rain_fre_MKTrend_3h_matrix','Lon','Lat')
clear filename
filename = 'heavy_rain_intensity_01_scale_3h_pre_event_thresold_5_95_2D_matrix.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\3h\SenTrend\',filename],...
    'heavy_rain_intensity_SenTrend_3h_matrix','heavy_rain_intensity_MKTrend_3h_matrix','Lon','Lat')
clear filename
filename = 'heavy_rain_amount_percentage_01_scale_3h_pre_event_thresold_5_95_2D_matrix.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\3h\SenTrend\',filename],...
    'heavy_rain_amount_percentage_SenTrend_3h_matrix','heavy_rain_amount_percentage_MKTrend_3h_matrix','Lon','Lat')

%% 6-hour

clear;clc;
load('J:\6-硕士毕业论文\1-Data\CMFD\0-from-paper2\LLT.mat')

path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')
% 为了加快运算速度，可以根据之前的结果，将中国地区的pixel索引进行利用
filename_1 = ['pre2(6h)_',num2str(2000),'.mat'];
load(['J:\6-硕士毕业论文\1-Data\CMFD\0-from-paper2\6h\pre\',filename_1])
pre_year = sum(pre_6h_preprocessing01_year,3);
clear pre_1d_preprocessing01_year
mask_China_line = reshape(pre_year,[1,length(Lon_3h_scale)*length(Lat_3h_scale)]);
k = find(~isnan(mask_China_line));
k1 = find(isnan(mask_China_line));
clear pre_year

Lon = Lon_3h_scale;
Lat = Lat_3h_scale;

clear filename2
filename2 = 'SenTrend_fre_CMFD_6h_01_scale_thresold_5_95_in_cell.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\6h-from-Paper2\SenTrend\',filename2]);
clear filename2
filename2 = 'SenTrend_intensity_CMFD_6h_01_scale_thresold_5_95_in_cell.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\6h-from-Paper2\SenTrend\',filename2]);
clear filename2
filename2 = 'SenTrend_percentage_CMFD_6h_01_scale_thresold_5_95_in_cell.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\6h-from-Paper2\SenTrend\',filename2]);

% 用一维向量进行读取
heavy_rain_fre_SenTrend_6h_matrix_line = nan(size(mask_China_line));
heavy_rain_intensity_SenTrend_6h_matrix_line = nan(size(mask_China_line));
heavy_rain_amount_percentage_SenTrend_6h_matrix_line = nan(size(mask_China_line));
heavy_rain_fre_MKTrend_6h_matrix_line = nan(size(mask_China_line));
heavy_rain_intensity_MKTrend_6h_matrix_line = nan(size(mask_China_line));
heavy_rain_amount_percentage_MKTrend_6h_matrix_line = nan(size(mask_China_line));
for i = 1 : length(k)
    heavy_rain_fre_SenTrend_6h_matrix_line(k(i)) = Sen_slope_fre(3,i);% 这里的单位是%
    heavy_rain_intensity_SenTrend_6h_matrix_line(k(i)) = Sen_slope_intensity(3,i); % 这里的单位是mmh
    heavy_rain_amount_percentage_SenTrend_6h_matrix_line(k(i)) = Sen_slope_percentage(3,i); % 这里的单位是%
    heavy_rain_fre_MKTrend_6h_matrix_line(k(i)) = MK_Trend_Z_fre(3,i);% 这里的单位是%
    heavy_rain_intensity_MKTrend_6h_matrix_line(k(i)) = MK_Trend_Z_intensity(3,i); % 这里的单位是mmh
    heavy_rain_amount_percentage_MKTrend_6h_matrix_line(k(i)) = MK_Trend_Z_percentage(3,i); % 这里的单位是%    
end

% 转回二维
heavy_rain_fre_SenTrend_6h_matrix = reshape(heavy_rain_fre_SenTrend_6h_matrix_line,[length(Lon),length(Lat)]);
heavy_rain_intensity_SenTrend_6h_matrix = reshape(heavy_rain_intensity_SenTrend_6h_matrix_line,[length(Lon),length(Lat)]);
heavy_rain_amount_percentage_SenTrend_6h_matrix = reshape(heavy_rain_amount_percentage_SenTrend_6h_matrix_line,[length(Lon),length(Lat)]);
heavy_rain_fre_MKTrend_6h_matrix = reshape(heavy_rain_fre_MKTrend_6h_matrix_line,[length(Lon),length(Lat)]);
heavy_rain_intensity_MKTrend_6h_matrix = reshape(heavy_rain_intensity_MKTrend_6h_matrix_line,[length(Lon),length(Lat)]);
heavy_rain_amount_percentage_MKTrend_6h_matrix = reshape(heavy_rain_amount_percentage_MKTrend_6h_matrix_line,[length(Lon),length(Lat)]);

clear filename
filename = 'heavy_rain_fre_01_scale_6h_pre_event_thresold_5_95_2D_matrix.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\6h-from-Paper2\SenTrend\',filename],...
    'heavy_rain_fre_SenTrend_6h_matrix','heavy_rain_fre_MKTrend_6h_matrix','Lon','Lat')
clear filename
filename = 'heavy_rain_intensity_01_scale_6h_pre_event_thresold_5_95_2D_matrix.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\6h-from-Paper2\SenTrend\',filename],...
    'heavy_rain_intensity_SenTrend_6h_matrix','heavy_rain_intensity_MKTrend_6h_matrix','Lon','Lat')
clear filename
filename = 'heavy_rain_amount_percentage_01_scale_6h_pre_event_thresold_5_95_2D_matrix.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\6h-from-Paper2\SenTrend\',filename],...
    'heavy_rain_amount_percentage_SenTrend_6h_matrix','heavy_rain_amount_percentage_MKTrend_6h_matrix','Lon','Lat')

%% 12-hour

clear;clc;
load('J:\6-硕士毕业论文\1-Data\CMFD\0-from-paper2\LLT.mat')

path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')
% 为了加快运算速度，可以根据之前的结果，将中国地区的pixel索引进行利用
filename_1 = ['pre3(12h)_',num2str(2000),'.mat'];
load(['J:\6-硕士毕业论文\1-Data\CMFD\0-from-paper2\12h\pre\',filename_1])
pre_year = sum(pre_12h_preprocessing01_year,3);
clear pre_1d_preprocessing01_year
mask_China_line = reshape(pre_year,[1,length(Lon_3h_scale)*length(Lat_3h_scale)]);
k = find(~isnan(mask_China_line));
k1 = find(isnan(mask_China_line));
clear pre_year

Lon = Lon_3h_scale;
Lat = Lat_3h_scale;

clear filename2
filename2 = 'SenTrend_fre_CMFD_12h_01_scale_thresold_5_95_in_cell.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\12h-from-Paper2\SenTrend\',filename2]);
clear filename2
filename2 = 'SenTrend_intensity_CMFD_12h_01_scale_thresold_5_95_in_cell.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\12h-from-Paper2\SenTrend\',filename2]);
clear filename2
filename2 = 'SenTrend_percentage_CMFD_12h_01_scale_thresold_5_95_in_cell.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\12h-from-Paper2\SenTrend\',filename2]);

% 用一维向量进行读取
heavy_rain_fre_SenTrend_12h_matrix_line = nan(size(mask_China_line));
heavy_rain_intensity_SenTrend_12h_matrix_line = nan(size(mask_China_line));
heavy_rain_amount_percentage_SenTrend_12h_matrix_line = nan(size(mask_China_line));
heavy_rain_fre_MKTrend_12h_matrix_line = nan(size(mask_China_line));
heavy_rain_intensity_MKTrend_12h_matrix_line = nan(size(mask_China_line));
heavy_rain_amount_percentage_MKTrend_12h_matrix_line = nan(size(mask_China_line));
for i = 1 : length(k)
    heavy_rain_fre_SenTrend_12h_matrix_line(k(i)) = Sen_slope_fre(3,i);% 这里的单位是%
    heavy_rain_intensity_SenTrend_12h_matrix_line(k(i)) = Sen_slope_intensity(3,i); % 这里的单位是mmh
    heavy_rain_amount_percentage_SenTrend_12h_matrix_line(k(i)) = Sen_slope_percentage(3,i); % 这里的单位是%
    heavy_rain_fre_MKTrend_12h_matrix_line(k(i)) = MK_Trend_Z_fre(3,i);% 这里的单位是%
    heavy_rain_intensity_MKTrend_12h_matrix_line(k(i)) = MK_Trend_Z_intensity(3,i); % 这里的单位是mmh
    heavy_rain_amount_percentage_MKTrend_12h_matrix_line(k(i)) = MK_Trend_Z_percentage(3,i); % 这里的单位是%    
end

% 转回二维
heavy_rain_fre_SenTrend_12h_matrix = reshape(heavy_rain_fre_SenTrend_12h_matrix_line,[length(Lon),length(Lat)]);
heavy_rain_intensity_SenTrend_12h_matrix = reshape(heavy_rain_intensity_SenTrend_12h_matrix_line,[length(Lon),length(Lat)]);
heavy_rain_amount_percentage_SenTrend_12h_matrix = reshape(heavy_rain_amount_percentage_SenTrend_12h_matrix_line,[length(Lon),length(Lat)]);
heavy_rain_fre_MKTrend_12h_matrix = reshape(heavy_rain_fre_MKTrend_12h_matrix_line,[length(Lon),length(Lat)]);
heavy_rain_intensity_MKTrend_12h_matrix = reshape(heavy_rain_intensity_MKTrend_12h_matrix_line,[length(Lon),length(Lat)]);
heavy_rain_amount_percentage_MKTrend_12h_matrix = reshape(heavy_rain_amount_percentage_MKTrend_12h_matrix_line,[length(Lon),length(Lat)]);

clear filename
filename = 'heavy_rain_fre_01_scale_12h_pre_event_thresold_5_95_2D_matrix.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\12h-from-Paper2\SenTrend\',filename],...
    'heavy_rain_fre_SenTrend_12h_matrix','heavy_rain_fre_MKTrend_12h_matrix','Lon','Lat')
clear filename
filename = 'heavy_rain_intensity_01_scale_12h_pre_event_thresold_5_95_2D_matrix.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\12h-from-Paper2\SenTrend\',filename],...
    'heavy_rain_intensity_SenTrend_12h_matrix','heavy_rain_intensity_MKTrend_12h_matrix','Lon','Lat')
clear filename
filename = 'heavy_rain_amount_percentage_01_scale_12h_pre_event_thresold_5_95_2D_matrix.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\12h-from-Paper2\SenTrend\',filename],...
    'heavy_rain_amount_percentage_SenTrend_12h_matrix','heavy_rain_amount_percentage_MKTrend_12h_matrix','Lon','Lat')


%% 1-day 空间分辨率为0.1°
clear;clc;
load('J:\6-硕士毕业论文\1-Data\CMFD\0-from-paper2\LLT.mat')

path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')
% 为了加快运算速度，可以根据之前的结果，将中国地区的pixel索引进行利用
filename_1 = ['pre4(1d)_',num2str(2000),'.mat'];
load(['J:\6-硕士毕业论文\1-Data\CMFD\0-from-paper2\1d\pre\',filename_1])
pre_year = sum(pre_1d_preprocessing01_year,3);
clear pre_1d_preprocessing01_year
mask_China_line = reshape(pre_year,[1,length(Lon_3h_scale)*length(Lat_3h_scale)]);
k = find(~isnan(mask_China_line));
k1 = find(isnan(mask_China_line));
clear pre_year

Lon = Lon_3h_scale;
Lat = Lat_3h_scale;

clear filename2
filename2 = 'SenTrend_fre_CMFD_1d_01_scale_thresold_5_95_in_cell.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\1d-from-Paper2\SenTrend\',filename2]);
clear filename2
filename2 = 'SenTrend_intensity_CMFD_1d_01_scale_thresold_5_95_in_cell.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\1d-from-Paper2\SenTrend\',filename2]);
clear filename2
filename2 = 'SenTrend_percentage_CMFD_1d_01_scale_thresold_5_95_in_cell.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\1d-from-Paper2\SenTrend\',filename2]);

% 用一维向量进行读取
heavy_rain_fre_SenTrend_1d_matrix_line = nan(size(mask_China_line));
heavy_rain_intensity_SenTrend_1d_matrix_line = nan(size(mask_China_line));
heavy_rain_amount_percentage_SenTrend_1d_matrix_line = nan(size(mask_China_line));
heavy_rain_fre_MKTrend_1d_matrix_line = nan(size(mask_China_line));
heavy_rain_intensity_MKTrend_1d_matrix_line = nan(size(mask_China_line));
heavy_rain_amount_percentage_MKTrend_1d_matrix_line = nan(size(mask_China_line));
for i = 1 : length(k)
    heavy_rain_fre_SenTrend_1d_matrix_line(k(i)) = Sen_slope_fre(3,i);% 这里的单位是%
    heavy_rain_intensity_SenTrend_1d_matrix_line(k(i)) = Sen_slope_intensity(3,i); % 这里的单位是mmh
    heavy_rain_amount_percentage_SenTrend_1d_matrix_line(k(i)) = Sen_slope_percentage(3,i); % 这里的单位是%
    heavy_rain_fre_MKTrend_1d_matrix_line(k(i)) = MK_Trend_Z_fre(3,i);% 这里的单位是%
    heavy_rain_intensity_MKTrend_1d_matrix_line(k(i)) = MK_Trend_Z_intensity(3,i); % 这里的单位是mmh
    heavy_rain_amount_percentage_MKTrend_1d_matrix_line(k(i)) = MK_Trend_Z_percentage(3,i); % 这里的单位是%    
end

% 转回二维
heavy_rain_fre_SenTrend_1d_matrix = reshape(heavy_rain_fre_SenTrend_1d_matrix_line,[length(Lon),length(Lat)]);
heavy_rain_intensity_SenTrend_1d_matrix = reshape(heavy_rain_intensity_SenTrend_1d_matrix_line,[length(Lon),length(Lat)]);
heavy_rain_amount_percentage_SenTrend_1d_matrix = reshape(heavy_rain_amount_percentage_SenTrend_1d_matrix_line,[length(Lon),length(Lat)]);
heavy_rain_fre_MKTrend_1d_matrix = reshape(heavy_rain_fre_MKTrend_1d_matrix_line,[length(Lon),length(Lat)]);
heavy_rain_intensity_MKTrend_1d_matrix = reshape(heavy_rain_intensity_MKTrend_1d_matrix_line,[length(Lon),length(Lat)]);
heavy_rain_amount_percentage_MKTrend_1d_matrix = reshape(heavy_rain_amount_percentage_MKTrend_1d_matrix_line,[length(Lon),length(Lat)]);

clear filename
filename = 'heavy_rain_fre_01_scale_1d_pre_event_thresold_5_95_2D_matrix.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\1d-from-Paper2\SenTrend\',filename],...
    'heavy_rain_fre_SenTrend_1d_matrix','heavy_rain_fre_MKTrend_1d_matrix','Lon','Lat')
clear filename
filename = 'heavy_rain_intensity_01_scale_1d_pre_event_thresold_5_95_2D_matrix.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\1d-from-Paper2\SenTrend\',filename],...
    'heavy_rain_intensity_SenTrend_1d_matrix','heavy_rain_intensity_MKTrend_1d_matrix','Lon','Lat')
clear filename
filename = 'heavy_rain_amount_percentage_01_scale_1d_pre_event_thresold_5_95_2D_matrix.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\1d-from-Paper2\SenTrend\',filename],...
    'heavy_rain_amount_percentage_SenTrend_1d_matrix','heavy_rain_amount_percentage_MKTrend_1d_matrix','Lon','Lat')

