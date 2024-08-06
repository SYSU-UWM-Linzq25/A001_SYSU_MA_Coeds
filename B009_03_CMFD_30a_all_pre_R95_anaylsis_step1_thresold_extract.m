%% 这个文件对极端降水的定义与ETCCDI指数中的R95p——日降水量 > 95%分位数的年累积降水量不同
%% 将30a所有的降水变成一个序列，然后以序列的95分位数作为分位数
%% 历史时期的CMFD，包括四种时间尺度

%% 注意：所有时间尺度的降水单位都是mm/h！

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
clear mask_China_line pre_year

for year = 1985:2014
    clear filename_1
    filename_1 = ['pre1_3h_no_preprocessing_',num2str(year),'.mat'];
    load(['J:\6-硕士毕业论文\1-Data\CMFD\1-origin-data-3h\Pre\',filename_1])
    
    pre_3h_preprocessing01_year = pre_3h_noprocessing;
    clear pre_3h_noprocessing
    pre_3h_preprocessing01_year(pre_3h_preprocessing01_year < 0.1) = 0; % 阈值处理
    pre_3h_preprocessing01_year_2 = num2cell(pre_3h_preprocessing01_year,3);
    clear pre_3h_preprocessing01_year
    pre_3h_preprocessing01_year_line = reshape(pre_3h_preprocessing01_year_2,[1,length(Lon)*length(Lat)]); % 转为单列
    clear pre_3h_preprocessing01_year_2
    pre_3h_preprocessing01_year_line(k1) = [];
    % 由于cell是直接从三维转换下来的，导致cell里面还是三维矩阵，通过函数将之转换为二维
    pre_3h_preprocessing01_year_line_2D = cell_3D_to_2D(pre_3h_preprocessing01_year_line);
    clear pre_3h_preprocessing01_year_line
    filename = ['pre for integrated of pixel in cell in ',num2str(year),'.mat'];
    save(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\3h\',filename], 'pre_3h_preprocessing01_year_line_2D')
    clear pre_3h_preprocessing01_year_line_2D
    disp(['Finish in year ',num2str(year)])    
end

%% 中国整个的话数组过大，尝试切割
clearvars -except k k1
cell_group_length = length(k);
a = 0:10000:100000;
a(1) = 1;
a(end) = cell_group_length;

for j = 1 : length(a) - 1
    % 第一年
    load(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\3h\pre for integrated of pixel in cell in ',num2str(1985),'.mat'])
    pre_40a_China_3h_2D = pre_3h_preprocessing01_year_line_2D;
    clear pre_3h_preprocessing01_year_line_2D
    % 切割
    pre_40a_China_3h_2D_part = pre_40a_China_3h_2D(1,a(j):a(j+1));
    clear pre_40a_China_3h_2D
    for year = 1986 : 2014
        load(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\3h\pre for integrated of pixel in cell in ',num2str(year),'.mat'])
        pre_3h_preprocessing01_year_line_2D_part = pre_3h_preprocessing01_year_line_2D(1,a(j):a(j+1)); % 提取出对应的部分
        clear pre_3h_preprocessing01_year_line_2D
        pre_40a_China_3h_2D_part = cell_intergrate(pre_40a_China_3h_2D_part,pre_3h_preprocessing01_year_line_2D_part);
        clear pre_3h_preprocessing01_year_line_2D_part
    end
    filename = ['40a pre of pixel in cell in part ',num2str(j),'.mat'];
    save(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\3h\',filename], 'pre_40a_China_3h_2D_part')
    clear pre_40a_China_3h_2D_part
    disp(['Finish in part ',num2str(j)])
end

%% 根据提取出来的降水计算两个阈值和百分位数
clear;clc;

% 为了加快运算速度，可以根据之前的结果，将中国地区的pixel索引进行利用
filename_1 = ['pre1_3h_no_preprocessing_',num2str(2000),'.mat'];
load(['J:\6-硕士毕业论文\1-Data\CMFD\1-origin-data-3h\Pre\',filename_1])
pre_year = sum(pre_3h_noprocessing,3);
clear pre_3h_noprocessing
mask_China_line = reshape(pre_year,[1,length(Lon)*length(Lat)]);
k = find(~isnan(mask_China_line));
k1 = find(isnan(mask_China_line));
clear mask_China_line pre_year

a_3h = 0:10000:100000;
a_3h(1) = 1;
a_3h(end) = length(k);

% 3h
pre_event_thresold_all = cell(1,length(k));
for i = 1 : length(a_3h) - 1
    load(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\3h\40a pre of pixel in cell in part ',num2str(i),'.mat'])
    % 提取分位数
    pre_event_thresold = cell_percentage_extract_5_95(pre_40a_China_3h_2D_part);
    clear pre_40a_China_3h_2D_part
    if i ~= 1 
       last_thresolad = pre_event_thresold_all{1,a_3h(i)}; % 上一个分段的最后一个
       first_thresolad = pre_event_thresold{1,1}; % 这个分段的第一个
       if last_thresolad(1) == first_thresolad(1) && last_thresolad(2) == first_thresolad(2) % 说明重复了
           pre_event_thresold_all{1,a_3h(i)} = []; % 去掉重复的第一个
           pre_event_thresold_all(1,a_3h(i):a_3h(i+1)) = pre_event_thresold;  
       else
           disp('No repetition!')
       end
    else
       pre_event_thresold_all(1,a_3h(i):a_3h(i+1)) = pre_event_thresold;     
    end
    clear pre_event_thresold last_thresolad first_thresolad
    % 由于每一组的第一个与最后一个有重复，需要注意
    disp(['part ',num2str(i),'is done!'])
end
filename = '3h_pre_event_thresold_5_95_in_cell.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\3h\',filename], 'pre_event_thresold_all')
disp('3h done')

%% 1-day
%% 日尺度的数据改回与英文文章相同
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
clear mask_China_line pre_year

for year = 1985:2014
    clear filename_1
    filename_1 = ['pre4(1d)_',num2str(year),'.mat'];
    load(['J:\6-硕士毕业论文\1-Data\CMFD\0-from-paper2\1d\pre\',filename_1])
    
    pre_1d_preprocessing01_year_2 = num2cell(pre_1d_preprocessing01_year,3);
    clear pre_1d_preprocessing01_year
    pre_1d_preprocessing01_year_line = reshape(pre_1d_preprocessing01_year_2,[1,length(Lon_3h_scale)*length(Lat_3h_scale)]); % 转为单列
    clear pre_1d_preprocessing01_year_2
    pre_1d_preprocessing01_year_line(k1) = [];
    % 由于cell是直接从三维转换下来的，导致cell里面还是三维矩阵，通过函数将之转换为二维
    pre_1d_preprocessing01_year_line_2D = cell_3D_to_2D(pre_1d_preprocessing01_year_line);
    clear pre_1d_preprocessing01_year_line
    filename = ['pre for integrated of pixel in cell in ',num2str(year),'.mat'];
    save(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\1d-from-paper2\',filename], 'pre_1d_preprocessing01_year_line_2D')
    clear pre_1d_preprocessing01_year_line_2D
    disp(['Finish in year ',num2str(year)])    
end

%% 中国整个的话数组过大，尝试切割
clearvars -except k k1
cell_group_length = length(k);
a = 0:10000:100000;
a(1) = 1;
a(end) = cell_group_length;

for j = 1 : length(a) - 1
    % 第一年
    load(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\1d-from-paper2\pre for integrated of pixel in cell in ',num2str(1985),'.mat'])
    pre_40a_China_1d_2D = pre_1d_preprocessing01_year_line_2D;
    clear pre_1d_preprocessing01_year_line_2D
    % 切割
    pre_40a_China_1d_2D_part = pre_40a_China_1d_2D(1,a(j):a(j+1));
    clear pre_40a_China_1d_2D
    for year = 1986 : 2014
        load(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\1d-from-paper2\pre for integrated of pixel in cell in ',num2str(year),'.mat'])
        pre_1d_preprocessing01_year_line_2D_part = pre_1d_preprocessing01_year_line_2D(1,a(j):a(j+1)); % 提取出对应的部分
        clear pre_1d_preprocessing01_year_line_2D
        pre_40a_China_1d_2D_part = cell_intergrate(pre_40a_China_1d_2D_part,pre_1d_preprocessing01_year_line_2D_part);
        clear pre_1d_preprocessing01_year_line_2D_part
    end
    filename = ['40a pre of pixel in cell in part ',num2str(j),'.mat'];
    save(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\1d-from-Paper2\',filename], 'pre_40a_China_1d_2D_part')
    clear pre_40a_China_1d_2D_part
    disp(['Finish in part ',num2str(j)])
end

%% 根据提取出来的降水计算两个阈值和百分位数
clear;clc;
load('J:\6-硕士毕业论文\1-Data\CMFD\0-from-paper2\LLT.mat')

% 为了加快运算速度，可以根据之前的结果，将中国地区的pixel索引进行利用
filename_1 = ['pre4(1d)_',num2str(2000),'.mat'];
load(['J:\6-硕士毕业论文\1-Data\CMFD\0-from-paper2\1d\pre\',filename_1])
pre_year = sum(pre_1d_preprocessing01_year,3);
clear pre_1d_preprocessing01_year
mask_China_line = reshape(pre_year,[1,length(Lon_3h_scale)*length(Lat_3h_scale)]);
k = find(~isnan(mask_China_line));
k1 = find(isnan(mask_China_line));
clear mask_China_line pre_year

a_1d = 0:10000:100000;
a_1d(1) = 1;
a_1d(end) = length(k);

% 1d
pre_event_thresold_all = cell(1,length(k));
for i = 1 : length(a_1d) - 1
    load(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\1d-from-Paper2\40a pre of pixel in cell in part ',num2str(i),'.mat'])
    % 提取分位数
    pre_event_thresold = cell_percentage_extract_5_95(pre_40a_China_1d_2D_part);
    clear pre_40a_China_1d_2D_part
    if i ~= 1 
       last_thresolad = pre_event_thresold_all{1,a_1d(i)}; % 上一个分段的最后一个
       first_thresolad = pre_event_thresold{1,1}; % 这个分段的第一个
       if last_thresolad(1) == first_thresolad(1) && last_thresolad(2) == first_thresolad(2) % 说明重复了
           pre_event_thresold_all{1,a_1d(i)} = []; % 去掉重复的第一个
           pre_event_thresold_all(1,a_1d(i):a_1d(i+1)) = pre_event_thresold;  
       else
           disp('No repetition!')
       end
    else
       pre_event_thresold_all(1,a_1d(i):a_1d(i+1)) = pre_event_thresold;     
    end
    clear pre_event_thresold last_thresolad first_thresolad
    % 由于每一组的第一个与最后一个有重复，需要注意
    disp(['part ',num2str(i),'is done!'])
end
filename = '1d_pre_event_thresold_5_95_in_cell.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\1d-from-Paper2\',filename], 'pre_event_thresold_all')
disp('1d done')

%% 6-hour
%% 从英文文章来的，3h数据升尺度

clear;clc;
load('J:\6-硕士毕业论文\1-Data\CMFD\0-from-paper2\LLT.mat')

path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')
% 为了加快运算速度，可以根据之前的结果，将中国地区的pixel索引进行利用
filename_1 = ['pre2(6h)_',num2str(2000),'.mat'];
load(['J:\6-硕士毕业论文\1-Data\CMFD\0-from-paper2\6h\pre\',filename_1])
pre_year = sum(pre_6h_preprocessing01_year,3);
clear pre_6h_preprocessing01_year
mask_China_line = reshape(pre_year,[1,length(Lon_3h_scale)*length(Lat_3h_scale)]);
k = find(~isnan(mask_China_line));
k1 = find(isnan(mask_China_line));
clear mask_China_line pre_year

for year = 1985:2014
    clear filename_1
    filename_1 = ['pre2(6h)_',num2str(year),'.mat'];
    load(['J:\6-硕士毕业论文\1-Data\CMFD\0-from-paper2\6h\pre\',filename_1])
    
    pre_6h_preprocessing01_year_2 = num2cell(pre_6h_preprocessing01_year,3);
    clear pre_6h_preprocessing01_year
    pre_6h_preprocessing01_year_line = reshape(pre_6h_preprocessing01_year_2,[1,length(Lon_3h_scale)*length(Lat_3h_scale)]); % 转为单列
    clear pre_6h_preprocessing01_year_2
    pre_6h_preprocessing01_year_line(k1) = [];
    % 由于cell是直接从三维转换下来的，导致cell里面还是三维矩阵，通过函数将之转换为二维
    pre_6h_preprocessing01_year_line_2D = cell_3D_to_2D(pre_6h_preprocessing01_year_line);
    clear pre_6h_preprocessing01_year_line
    filename = ['pre for integrated of pixel in cell in ',num2str(year),'.mat'];
    save(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\6h-from-paper2\',filename], 'pre_6h_preprocessing01_year_line_2D')
    clear pre_6h_preprocessing01_year_line_2D
    disp(['Finish in year ',num2str(year)])
end

%% 中国整个的话数组过大，尝试切割
clearvars -except k k1
cell_group_length = length(k);
a = 0:10000:100000;
a(1) = 1;
a(end) = cell_group_length;

for j = 1 : length(a) - 1
    % 第一年
    load(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\6h-from-paper2\pre for integrated of pixel in cell in ',num2str(1985),'.mat'])
    pre_40a_China_6h_2D = pre_6h_preprocessing01_year_line_2D;
    clear pre_6h_preprocessing01_year_line_2D
    % 切割
    pre_40a_China_6h_2D_part = pre_40a_China_6h_2D(1,a(j):a(j+1));
    clear pre_40a_China_6h_2D
    for year = 1986 : 2014
        load(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\6h-from-paper2\pre for integrated of pixel in cell in ',num2str(year),'.mat'])
        pre_6h_preprocessing01_year_line_2D_part = pre_6h_preprocessing01_year_line_2D(1,a(j):a(j+1)); % 提取出对应的部分
        clear pre_6h_preprocessing01_year_line_2D
        pre_40a_China_6h_2D_part = cell_intergrate(pre_40a_China_6h_2D_part,pre_6h_preprocessing01_year_line_2D_part);
        clear pre_6h_preprocessing01_year_line_2D_part
    end
    filename = ['40a pre of pixel in cell in part ',num2str(j),'.mat'];
    save(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\6h-from-Paper2\',filename], 'pre_40a_China_6h_2D_part')
    clear pre_40a_China_6h_2D_part
    disp(['Finish in part ',num2str(j)])
end

%% 根据提取出来的降水计算两个阈值和百分位数
clear;clc;
load('J:\6-硕士毕业论文\1-Data\CMFD\0-from-paper2\LLT.mat')

% 为了加快运算速度，可以根据之前的结果，将中国地区的pixel索引进行利用
filename_1 = ['pre2(6h)_',num2str(2000),'.mat'];
load(['J:\6-硕士毕业论文\1-Data\CMFD\0-from-paper2\6h\pre\',filename_1])
pre_year = sum(pre_6h_preprocessing01_year,3);
clear pre_6h_preprocessing01_year
mask_China_line = reshape(pre_year,[1,length(Lon_3h_scale)*length(Lat_3h_scale)]);
k = find(~isnan(mask_China_line));
k1 = find(isnan(mask_China_line));
clear mask_China_line pre_year

a_1d = 0:10000:100000;
a_1d(1) = 1;
a_1d(end) = length(k);

% 1d
pre_event_thresold_all = cell(1,length(k));
for i = 1 : length(a_1d) - 1
    load(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\6h-from-Paper2\40a pre of pixel in cell in part ',num2str(i),'.mat'])
    % 提取分位数
    pre_event_thresold = cell_percentage_extract_5_95(pre_40a_China_6h_2D_part);
    clear pre_40a_China_6h_2D_part
    if i ~= 1 
       last_thresolad = pre_event_thresold_all{1,a_1d(i)}; % 上一个分段的最后一个
       first_thresolad = pre_event_thresold{1,1}; % 这个分段的第一个
       if last_thresolad(1) == first_thresolad(1) && last_thresolad(2) == first_thresolad(2) % 说明重复了
           pre_event_thresold_all{1,a_1d(i)} = []; % 去掉重复的第一个
           pre_event_thresold_all(1,a_1d(i):a_1d(i+1)) = pre_event_thresold;  
       else
           disp('No repetition!')
       end
    else
       pre_event_thresold_all(1,a_1d(i):a_1d(i+1)) = pre_event_thresold;     
    end
    clear pre_event_thresold last_thresolad first_thresolad
    % 由于每一组的第一个与最后一个有重复，需要注意
    disp(['part ',num2str(i),'is done!'])
end
filename = '6h_pre_event_thresold_5_95_in_cell.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\6h-from-Paper2\',filename], 'pre_event_thresold_all')
disp('6h done')

%% 12-hour
%% 从英文文章来的，3h数据升尺度

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
clear mask_China_line pre_year

for year = 1985:2014
    clear filename_1
    filename_1 = ['pre3(12h)_',num2str(year),'.mat'];
    load(['J:\6-硕士毕业论文\1-Data\CMFD\0-from-paper2\12h\pre\',filename_1])
    
    pre_12h_preprocessing01_year_2 = num2cell(pre_12h_preprocessing01_year,3);
    clear pre_12h_preprocessing01_year
    pre_12h_preprocessing01_year_line = reshape(pre_12h_preprocessing01_year_2,[1,length(Lon_3h_scale)*length(Lat_3h_scale)]); % 转为单列
    clear pre_12h_preprocessing01_year_2
    pre_12h_preprocessing01_year_line(k1) = [];
    % 由于cell是直接从三维转换下来的，导致cell里面还是三维矩阵，通过函数将之转换为二维
    pre_12h_preprocessing01_year_line_2D = cell_3D_to_2D(pre_12h_preprocessing01_year_line);
    clear pre_12h_preprocessing01_year_line
    filename = ['pre for integrated of pixel in cell in ',num2str(year),'.mat'];
    save(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\12h-from-paper2\',filename], 'pre_12h_preprocessing01_year_line_2D')
    clear pre_12h_preprocessing01_year_line_2D
    disp(['Finish in year ',num2str(year)])
end

%% 中国整个的话数组过大，尝试切割
clearvars -except k k1
cell_group_length = length(k);
a = 0:10000:100000;
a(1) = 1;
a(end) = cell_group_length;

for j = 1 : length(a) - 1
    % 第一年
    load(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\12h-from-paper2\pre for integrated of pixel in cell in ',num2str(1985),'.mat'])
    pre_40a_China_12h_2D = pre_12h_preprocessing01_year_line_2D;
    clear pre_12h_preprocessing01_year_line_2D
    % 切割
    pre_40a_China_12h_2D_part = pre_40a_China_12h_2D(1,a(j):a(j+1));
    clear pre_40a_China_12h_2D
    for year = 1986 : 2014
        load(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\12h-from-paper2\pre for integrated of pixel in cell in ',num2str(year),'.mat'])
        pre_12h_preprocessing01_year_line_2D_part = pre_12h_preprocessing01_year_line_2D(1,a(j):a(j+1)); % 提取出对应的部分
        clear pre_12h_preprocessing01_year_line_2D
        pre_40a_China_12h_2D_part = cell_intergrate(pre_40a_China_12h_2D_part,pre_12h_preprocessing01_year_line_2D_part);
        clear pre_12h_preprocessing01_year_line_2D_part
    end
    filename = ['40a pre of pixel in cell in part ',num2str(j),'.mat'];
    save(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\12h-from-Paper2\',filename], 'pre_40a_China_12h_2D_part')
    clear pre_40a_China_12h_2D_part
    disp(['Finish in part ',num2str(j)])
end

%% 根据提取出来的降水计算两个阈值和百分位数
clear;clc;
load('J:\6-硕士毕业论文\1-Data\CMFD\0-from-paper2\LLT.mat')

% 为了加快运算速度，可以根据之前的结果，将中国地区的pixel索引进行利用
filename_1 = ['pre3(12h)_',num2str(2000),'.mat'];
load(['J:\6-硕士毕业论文\1-Data\CMFD\0-from-paper2\12h\pre\',filename_1])
pre_year = sum(pre_12h_preprocessing01_year,3);
clear pre_12h_preprocessing01_year
mask_China_line = reshape(pre_year,[1,length(Lon_3h_scale)*length(Lat_3h_scale)]);
k = find(~isnan(mask_China_line));
k1 = find(isnan(mask_China_line));
clear mask_China_line pre_year

a_1d = 0:10000:100000;
a_1d(1) = 1;
a_1d(end) = length(k);

% 1d
pre_event_thresold_all = cell(1,length(k));
for i = 1 : length(a_1d) - 1
    load(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\12h-from-Paper2\40a pre of pixel in cell in part ',num2str(i),'.mat'])
    % 提取分位数
    pre_event_thresold = cell_percentage_extract_5_95(pre_40a_China_12h_2D_part);
    clear pre_40a_China_12h_2D_part
    if i ~= 1 
       last_thresolad = pre_event_thresold_all{1,a_1d(i)}; % 上一个分段的最后一个
       first_thresolad = pre_event_thresold{1,1}; % 这个分段的第一个
       if last_thresolad(1) == first_thresolad(1) && last_thresolad(2) == first_thresolad(2) % 说明重复了
           pre_event_thresold_all{1,a_1d(i)} = []; % 去掉重复的第一个
           pre_event_thresold_all(1,a_1d(i):a_1d(i+1)) = pre_event_thresold;  
       else
           disp('No repetition!')
       end
    else
       pre_event_thresold_all(1,a_1d(i):a_1d(i+1)) = pre_event_thresold;     
    end
    clear pre_event_thresold last_thresolad first_thresolad
    % 由于每一组的第一个与最后一个有重复，需要注意
    disp(['part ',num2str(i),'is done!'])
end
filename = '12h_pre_event_thresold_5_95_in_cell.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\12h-from-Paper2\',filename], 'pre_event_thresold_all')
disp('1d done')
