%% 这个文件将第二步中提取出来的三种雨中暴雨（heavy rain）的的频率、平均降水强度、降水量占比从cell存储格式转回三维矩阵
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
filename2 = '3h_frenquency_of_pre_event_thresold_5_95_in_cell.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\3h\',filename2]);
clear filename2
filename2 = '3h_Intensity_of_pre_event_thresold_5_95_in_cell.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\3h\',filename2]);
clear filename2
filename2 = '3h_Pre_amount_percentage_of_pre_event_thresold_5_95_in_cell.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\3h\',filename2]);

heavy_rain_fre_3h_matrix = nan(length(Lon),length(Lat),size(Fre_30a_pre_event,1));
heavy_rain_intensity_3h_matrix = nan(length(Lon),length(Lat),size(Fre_30a_pre_event,1));
heavy_rain_amount_percentage_3h_matrix = nan(length(Lon),length(Lat),size(Fre_30a_pre_event,1));
for year = 1 : size(Fre_30a_pre_event,1) 
    Fre_30a_pre_event_year = Fre_30a_pre_event(year,:);
    Intensity_pre_event_year = Intensity_pre_event(year,:);
    Pre_amount_percentage_pre_event_year = Pre_amount_percentage_pre_event(year,:);
    % 这里需要逐年提取，转回二维矩阵
    % 提取频率和强度列向量，转回二维矩阵
    heavy_rain_fre_3h_matrix_line = nan(size(mask_China_line));
    heavy_rain_intensity_3h_matrix_line = nan(size(mask_China_line));
    heavy_rain_percentage_3h_matrix_line = nan(size(mask_China_line));
    for i = 1 : length(k)
        heavy_rain_fre_3h_matrix_line(k(i)) = Fre_30a_pre_event_year{1,i}(3);% 这里的单位是%
        heavy_rain_intensity_3h_matrix_line(k(i)) = Intensity_pre_event_year{1,i}(3); % 这里的单位是mmh
        heavy_rain_percentage_3h_matrix_line(k(i)) = Pre_amount_percentage_pre_event_year{1,i}(3); % 这里的单位是%
    end
    clear Fre_30a_pre_event_year Intensity_pre_event_year Pre_amount_percentage_pre_event_year
    heavy_rain_fre_3h_year = reshape(heavy_rain_fre_3h_matrix_line,[length(Lon),length(Lat)]);
    heavy_rain_intensity_3h_year = reshape(heavy_rain_intensity_3h_matrix_line,[length(Lon),length(Lat)]);
    heavy_rain_percentage_3h_year = reshape(heavy_rain_percentage_3h_matrix_line,[length(Lon),length(Lat)]);
    clear heavy_rain_fre_3h_matrix_line heavy_rain_intensity_3h_matrix_line heavy_rain_percentage_3h_matrix_line
    heavy_rain_fre_3h_matrix(:,:,year) = heavy_rain_fre_3h_year;
    heavy_rain_intensity_3h_matrix(:,:,year) = heavy_rain_intensity_3h_year;
    heavy_rain_amount_percentage_3h_matrix(:,:,year) = heavy_rain_percentage_3h_year;
    clear heavy_rain_fre_3h_year heavy_rain_intensity_3h_year heavy_rain_percentage_3h_year
    disp([num2str(year),' is done!'])
end

filename = 'heavy_rain_fre_intensity_percentage_01_scale_3h_pre_event_thresold_5_95_matrix.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\3h\Heavy_rain_fre_intensity_percentage_3D_matrix\',filename],...
    'heavy_rain_fre_3h_matrix','heavy_rain_intensity_3h_matrix','heavy_rain_amount_percentage_3h_matrix','Lon','Lat')

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

clear filename2
filename2 = '6h_frenquency_of_pre_event_thresold_5_95_in_cell.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\6h-from-Paper2\',filename2]);
clear filename2
filename2 = '6h_Intensity_of_pre_event_thresold_5_95_in_cell.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\6h-from-Paper2\',filename2]);
clear filename2
filename2 = '6h_Pre_amount_percentage_of_pre_event_thresold_5_95_in_cell.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\6h-from-Paper2\',filename2]);

Lon = Lon_3h_scale;
Lat = Lat_3h_scale;

heavy_rain_fre_6h_matrix = nan(length(Lon),length(Lat),size(Fre_30a_pre_event,1));
heavy_rain_intensity_6h_matrix = nan(length(Lon),length(Lat),size(Fre_30a_pre_event,1));
heavy_rain_amount_percentage_6h_matrix = nan(length(Lon),length(Lat),size(Fre_30a_pre_event,1));
for year = 1 : size(Fre_30a_pre_event,1) 
    Fre_30a_pre_event_year = Fre_30a_pre_event(year,:);
    Intensity_pre_event_year = Intensity_pre_event(year,:);
    Pre_amount_percentage_pre_event_year = Pre_amount_percentage_pre_event(year,:);
    % 这里需要逐年提取，转回二维矩阵
    % 提取频率和强度列向量，转回二维矩阵
    heavy_rain_fre_6h_matrix_line = nan(size(mask_China_line));
    heavy_rain_intensity_6h_matrix_line = nan(size(mask_China_line));
    heavy_rain_percentage_6h_matrix_line = nan(size(mask_China_line));
    for i = 1 : length(k)
        heavy_rain_fre_6h_matrix_line(k(i)) = Fre_30a_pre_event_year{1,i}(3);% 这里的单位是%
        heavy_rain_intensity_6h_matrix_line(k(i)) = Intensity_pre_event_year{1,i}(3); % 这里的单位是mmh
        heavy_rain_percentage_6h_matrix_line(k(i)) = Pre_amount_percentage_pre_event_year{1,i}(3); % 这里的单位是%
    end
    clear Fre_30a_pre_event_year Intensity_pre_event_year Pre_amount_percentage_pre_event_year
    heavy_rain_fre_6h_year = reshape(heavy_rain_fre_6h_matrix_line,[length(Lon),length(Lat)]);
    heavy_rain_intensity_6h_year = reshape(heavy_rain_intensity_6h_matrix_line,[length(Lon),length(Lat)]);
    heavy_rain_percentage_6h_year = reshape(heavy_rain_percentage_6h_matrix_line,[length(Lon),length(Lat)]);
    clear heavy_rain_fre_6h_matrix_line heavy_rain_intensity_6h_matrix_line heavy_rain_percentage_6h_matrix_line
    heavy_rain_fre_6h_matrix(:,:,year) = heavy_rain_fre_6h_year;
    heavy_rain_intensity_6h_matrix(:,:,year) = heavy_rain_intensity_6h_year;
    heavy_rain_amount_percentage_6h_matrix(:,:,year) = heavy_rain_percentage_6h_year;
    clear heavy_rain_fre_6h_year heavy_rain_intensity_6h_year heavy_rain_percentage_6h_year
    disp([num2str(year),' is done!'])
end

filename = 'heavy_rain_fre_intensity_percentage_01_scale_6h_pre_event_thresold_5_95_matrix.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\6h-from-Paper2\Heavy_rain_fre_intensity_percentage_3D_matrix\',filename],...
    'heavy_rain_fre_6h_matrix','heavy_rain_intensity_6h_matrix','heavy_rain_amount_percentage_6h_matrix','Lon','Lat')

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

clear filename2
filename2 = '12h_frenquency_of_pre_event_thresold_5_95_in_cell.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\12h-from-Paper2\',filename2]);
clear filename2
filename2 = '12h_Intensity_of_pre_event_thresold_5_95_in_cell.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\12h-from-Paper2\',filename2]);
clear filename2
filename2 = '12h_Pre_amount_percentage_of_pre_event_thresold_5_95_in_cell.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\12h-from-Paper2\',filename2]);

Lon = Lon_3h_scale;
Lat = Lat_3h_scale;

heavy_rain_fre_12h_matrix = nan(length(Lon),length(Lat),size(Fre_30a_pre_event,1));
heavy_rain_intensity_12h_matrix = nan(length(Lon),length(Lat),size(Fre_30a_pre_event,1));
heavy_rain_amount_percentage_12h_matrix = nan(length(Lon),length(Lat),size(Fre_30a_pre_event,1));
for year = 1 : size(Fre_30a_pre_event,1) 
    Fre_30a_pre_event_year = Fre_30a_pre_event(year,:);
    Intensity_pre_event_year = Intensity_pre_event(year,:);
    Pre_amount_percentage_pre_event_year = Pre_amount_percentage_pre_event(year,:);
    % 这里需要逐年提取，转回二维矩阵
    % 提取频率和强度列向量，转回二维矩阵
    heavy_rain_fre_12h_matrix_line = nan(size(mask_China_line));
    heavy_rain_intensity_12h_matrix_line = nan(size(mask_China_line));
    heavy_rain_percentage_12h_matrix_line = nan(size(mask_China_line));
    for i = 1 : length(k)
        heavy_rain_fre_12h_matrix_line(k(i)) = Fre_30a_pre_event_year{1,i}(3);% 这里的单位是%
        heavy_rain_intensity_12h_matrix_line(k(i)) = Intensity_pre_event_year{1,i}(3); % 这里的单位是mmh
        heavy_rain_percentage_12h_matrix_line(k(i)) = Pre_amount_percentage_pre_event_year{1,i}(3); % 这里的单位是%
    end
    clear Fre_30a_pre_event_year Intensity_pre_event_year Pre_amount_percentage_pre_event_year
    heavy_rain_fre_12h_year = reshape(heavy_rain_fre_12h_matrix_line,[length(Lon),length(Lat)]);
    heavy_rain_intensity_12h_year = reshape(heavy_rain_intensity_12h_matrix_line,[length(Lon),length(Lat)]);
    heavy_rain_percentage_12h_year = reshape(heavy_rain_percentage_12h_matrix_line,[length(Lon),length(Lat)]);
    clear heavy_rain_fre_12h_matrix_line heavy_rain_intensity_12h_matrix_line heavy_rain_percentage_12h_matrix_line
    heavy_rain_fre_12h_matrix(:,:,year) = heavy_rain_fre_12h_year;
    heavy_rain_intensity_12h_matrix(:,:,year) = heavy_rain_intensity_12h_year;
    heavy_rain_amount_percentage_12h_matrix(:,:,year) = heavy_rain_percentage_12h_year;
    clear heavy_rain_fre_12h_year heavy_rain_intensity_12h_year heavy_rain_percentage_12h_year
    disp([num2str(year),' is done!'])
end

filename = 'heavy_rain_fre_intensity_percentage_01_scale_12h_pre_event_thresold_5_95_matrix.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\12h-from-Paper2\Heavy_rain_fre_intensity_percentage_3D_matrix\',filename],...
    'heavy_rain_fre_12h_matrix','heavy_rain_intensity_12h_matrix','heavy_rain_amount_percentage_12h_matrix','Lon','Lat')


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

filename2 = '1d_frenquency_of_pre_event_thresold_5_95_in_cell.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\1d-from-Paper2\',filename2]);
clear filename2
filename2 = '1d_Intensity_of_pre_event_thresold_5_95_in_cell.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\1d-from-Paper2\',filename2]);
clear filename2
filename2 = '1d_Pre_amount_percentage_of_pre_event_thresold_5_95_in_cell.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\1d-from-Paper2\',filename2]);

Lon = Lon_3h_scale;
Lat = Lat_3h_scale;

heavy_rain_fre_1d_matrix = nan(length(Lon_3h_scale),length(Lat_3h_scale),size(Fre_30a_pre_event,1));
heavy_rain_intensity_1d_matrix = nan(length(Lon_3h_scale),length(Lat_3h_scale),size(Fre_30a_pre_event,1));
heavy_rain_amount_percentage_1d_matrix = nan(length(Lon_3h_scale),length(Lat_3h_scale),size(Fre_30a_pre_event,1));
for year = 1 : size(Fre_30a_pre_event,1) 
    Fre_30a_pre_event_year = Fre_30a_pre_event(year,:);
    Intensity_pre_event_year = Intensity_pre_event(year,:);
    Pre_amount_percentage_pre_event_year = Pre_amount_percentage_pre_event(year,:);
    % 这里需要逐年提取，转回二维矩阵
    % 提取频率和强度列向量，转回二维矩阵
    heavy_rain_fre_1d_matrix_line = nan(size(mask_China_line));
    heavy_rain_intensity_1d_matrix_line = nan(size(mask_China_line));
    heavy_rain_percentage_1d_matrix_line = nan(size(mask_China_line));
    for i = 1 : length(k)
        heavy_rain_fre_1d_matrix_line(k(i)) = Fre_30a_pre_event_year{1,i}(3);% 这里的单位是%
        heavy_rain_intensity_1d_matrix_line(k(i)) = Intensity_pre_event_year{1,i}(3); % 这里的单位是mmh
        heavy_rain_percentage_1d_matrix_line(k(i)) = Pre_amount_percentage_pre_event_year{1,i}(3); % 这里的单位是%
    end
    clear Fre_30a_pre_event_year Intensity_pre_event_year Pre_amount_percentage_pre_event_year
    heavy_rain_fre_1d_year = reshape(heavy_rain_fre_1d_matrix_line,[length(Lon_3h_scale),length(Lat_3h_scale)]);
    heavy_rain_intensity_1d_year = reshape(heavy_rain_intensity_1d_matrix_line,[length(Lon_3h_scale),length(Lat_3h_scale)]);
    heavy_rain_percentage_1d_year = reshape(heavy_rain_percentage_1d_matrix_line,[length(Lon_3h_scale),length(Lat_3h_scale)]);
    clear heavy_rain_fre_1d_matrix_line heavy_rain_intensity_1d_matrix_line heavy_rain_percentage_1d_matrix_line
    heavy_rain_fre_1d_matrix(:,:,year) = heavy_rain_fre_1d_year;
    heavy_rain_intensity_1d_matrix(:,:,year) = heavy_rain_intensity_1d_year;
    heavy_rain_amount_percentage_1d_matrix(:,:,year) = heavy_rain_percentage_1d_year;
    clear heavy_rain_fre_1d_year heavy_rain_intensity_1d_year heavy_rain_percentage_1d_year
    disp([num2str(year),' is done!'])
end

filename = 'heavy_rain_fre_intensity_percentage_01_scale_1d_pre_event_thresold_5_95_matrix.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\1d-from-Paper2\Heavy_rain_fre_intensity_percentage_3D_matrix\',filename],...
    'heavy_rain_fre_1d_matrix','heavy_rain_intensity_1d_matrix','heavy_rain_amount_percentage_1d_matrix','Lon','Lat')

