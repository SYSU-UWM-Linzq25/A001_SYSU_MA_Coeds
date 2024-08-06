%% 这个文件将第三步中提取出来的三种雨中雨（moderate）的时段数从cell存储格式转回三维矩阵
%% 研究时段为1985-2014
%% 时间尺度包括3-hour、6-hour、12-hour、1-day
%% 可以计算对应的多年平均值用于后续与未来时期进行比较分析，说明未来时期发生的变化
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
filename2 = '3h_Pre_intervals_of_pre_event_thresold_5_95_in_cell.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\3h\',filename2]);

Moderate_rain_intervals_3h_matrix = nan(length(Lon),length(Lat),size(Pre_intervals_pre_event,1));
for year = 1 : size(Pre_intervals_pre_event,1)
    Pre_intervals_pre_event_year = Pre_intervals_pre_event(year,:);
    % 这里需要逐年提取，转回二维矩阵
    % 提取频率和强度列向量，转回二维矩阵
    light_rain_intervals_3h_matrix_line = nan(size(mask_China_line));
    moderate_rain_intervals_3h_matrix_line = nan(size(mask_China_line));
    for i = 1 : length(k)
        moderate_rain_intervals_3h_matrix_line(k(i)) = Pre_intervals_pre_event_year{1,i}(2); % 中雨时段数
    end
    clear Pre_intervals_pre_event_year
    moderate_rain_intervals_3h_year = reshape(moderate_rain_intervals_3h_matrix_line,[length(Lon),length(Lat)]);
    clear moderate_rain_intervals_3h_matrix_line
    Moderate_rain_intervals_3h_matrix(:,:,year) = moderate_rain_intervals_3h_year;
    clear moderate_rain_intervals_3h_year
    disp([num2str(year),' is done!'])
end

filename = 'Moderate_rain_intervals_01_scale_3h_pre_event_thresold_5_95_matrix.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\3h\Moderate_rain_intervals_3D_matrix\',filename],...
    'Moderate_rain_intervals_3h_matrix','Lon','Lat')

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
filename2 = '6h_Pre_intervals_of_pre_event_thresold_5_95_in_cell.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\6h-from-Paper2\',filename2]);

Moderate_rain_intervals_6h_matrix = nan(length(Lon),length(Lat),size(Pre_intervals_pre_event,1));
for year = 1 : size(Pre_intervals_pre_event,1)
    Pre_intervals_pre_event_year = Pre_intervals_pre_event(year,:);
    % 这里需要逐年提取，转回二维矩阵
    % 提取频率和强度列向量，转回二维矩阵
    light_rain_intervals_6h_matrix_line = nan(size(mask_China_line));
    moderate_rain_intervals_6h_matrix_line = nan(size(mask_China_line));
    for i = 1 : length(k)
        moderate_rain_intervals_6h_matrix_line(k(i)) = Pre_intervals_pre_event_year{1,i}(2); % 中雨时段数
    end
    clear Pre_intervals_pre_event_year
    moderate_rain_intervals_6h_year = reshape(moderate_rain_intervals_6h_matrix_line,[length(Lon),length(Lat)]);
    clear moderate_rain_intervals_6h_matrix_line
    Moderate_rain_intervals_6h_matrix(:,:,year) = moderate_rain_intervals_6h_year;
    clear moderate_rain_intervals_6h_year
    disp([num2str(year),' is done!'])
end

filename = 'Moderate_rain_intervals_01_scale_6h_pre_event_thresold_5_95_matrix.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\6h-from-Paper2\Moderate_rain_intervals_3D_matrix\',filename],...
    'Moderate_rain_intervals_6h_matrix','Lon','Lat')

% 12-hour

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
filename2 = '12h_Pre_intervals_of_pre_event_thresold_5_95_in_cell.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\12h-from-Paper2\',filename2]);

Moderate_rain_intervals_12h_matrix = nan(length(Lon),length(Lat),size(Pre_intervals_pre_event,1));
for year = 1 : size(Pre_intervals_pre_event,1)
    Pre_intervals_pre_event_year = Pre_intervals_pre_event(year,:);
    % 这里需要逐年提取，转回二维矩阵
    % 提取频率和强度列向量，转回二维矩阵
    light_rain_intervals_12h_matrix_line = nan(size(mask_China_line));
    moderate_rain_intervals_12h_matrix_line = nan(size(mask_China_line));
    for i = 1 : length(k)
        moderate_rain_intervals_12h_matrix_line(k(i)) = Pre_intervals_pre_event_year{1,i}(2); % 中雨时段数
    end
    clear Pre_intervals_pre_event_year
    moderate_rain_intervals_12h_year = reshape(moderate_rain_intervals_12h_matrix_line,[length(Lon),length(Lat)]);
    clear moderate_rain_intervals_12h_matrix_line
    Moderate_rain_intervals_12h_matrix(:,:,year) = moderate_rain_intervals_12h_year;
    clear moderate_rain_intervals_12h_year
    disp([num2str(year),' is done!'])
end

filename = 'Moderate_rain_intervals_01_scale_12h_pre_event_thresold_5_95_matrix.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\12h-from-Paper2\Moderate_rain_intervals_3D_matrix\',filename],...
    'Moderate_rain_intervals_12h_matrix','Lon','Lat')

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
filename2 = '1d_Pre_intervals_of_pre_event_thresold_5_95_in_cell.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\1d-from-Paper2\',filename2]);

Moderate_rain_intervals_1d_matrix = nan(length(Lon),length(Lat),size(Pre_intervals_pre_event,1));
for year = 1 : size(Pre_intervals_pre_event,1)
    Pre_intervals_pre_event_year = Pre_intervals_pre_event(year,:);
    % 这里需要逐年提取，转回二维矩阵
    % 提取频率和强度列向量，转回二维矩阵
    light_rain_intervals_1d_matrix_line = nan(size(mask_China_line));
    moderate_rain_intervals_1d_matrix_line = nan(size(mask_China_line));
    for i = 1 : length(k)
        moderate_rain_intervals_1d_matrix_line(k(i)) = Pre_intervals_pre_event_year{1,i}(2); % 中雨时段数
    end
    clear Pre_intervals_pre_event_year
    moderate_rain_intervals_1d_year = reshape(moderate_rain_intervals_1d_matrix_line,[length(Lon),length(Lat)]);
    clear moderate_rain_intervals_1d_matrix_line
    Moderate_rain_intervals_1d_matrix(:,:,year) = moderate_rain_intervals_1d_year;
    clear moderate_rain_intervals_1d_year
    disp([num2str(year),' is done!'])
end

filename = 'Moderate_rain_intervals_01_scale_1d_pre_event_thresold_5_95_matrix.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\1d-from-Paper2\Moderate_rain_intervals_3D_matrix\',filename],...
    'Moderate_rain_intervals_1d_matrix','Lon','Lat')
