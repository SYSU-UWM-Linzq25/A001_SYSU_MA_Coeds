%% 这个文件对极端降水的定义与ETCCDI指数中的R95p——日降水量 > 95%分位数的年累积降水量不同
%% 将30a所有的降水变成一个序列，然后以序列的95分位数作为分位数
%% CMIP6历史时期的情况，只有日尺度，1985-2014
%% 先单独计算三个模型的，然后求气候平均，再集合平均
% 0.25°

clear;clc;

path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')
model_name = {'MPI-ESM1-2-HR','NorESM2-MM','MIROC6'};

save_peth_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2018-2058\7-4-His-pr-025-scale-cell-data\';
cd(save_peth_1)

for i = 1 : length(model_name) % 选择模式读取数据
    filename_1 = [model_name{i},'_CN_025_scale_1975_2014.mat'];
    load(filename_1)
    clear filename_1
    
    CMIP6_model_HisPr_1985_2014 = CMIP6_model_HisPr_1975_2014_025_scale(11:end);
    clear CMIP6_model_HisPr_1975_2014_025_scale
    for year = 1985:2014
        % 当年降水
        Model_Pre_year = CMIP6_model_HisPr_1985_2014{year-1984,1};
        % 转换单位为mmh，从而与CMFD数据的单位统一
        pre_1d_preprocessing01_year = Model_Pre_year/24;
        % 预处理
        pre_1d_preprocessing01_year(pre_1d_preprocessing01_year < 0.1) = 0;
        % 转换为cell
        pre_1d_preprocessing01_year_2 = num2cell(pre_1d_preprocessing01_year,3);
        clear pre_1d_preprocessing01_year
        pre_1d_preprocessing01_year_line = reshape(pre_1d_preprocessing01_year_2,[1,size(xx_025,1)*size(xx_025,2)]); % 转为单列
        clear pre_1d_preprocessing01_year_2
        % 由于cell是直接从三维转换下来的，导致cell里面还是三维矩阵，通过函数将之转换为二维
        pre_1d_preprocessing01_year_line_2D = cell_3D_to_2D(pre_1d_preprocessing01_year_line);
        clear pre_1d_preprocessing01_year_line
        filename = [model_name{i},' pre for integrated of pixel in cell in ',num2str(year),'.mat'];
        save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\10-4-30a-all-pre-R95\',filename], 'pre_1d_preprocessing01_year_line_2D')
        clear pre_1d_preprocessing01_year_line_2D
        disp([model_name{i},' Finish in year ',num2str(year)])
    end
end


%% 变成0.25°后，数组不大因此不用切割

clear;clc;
model_name = {'MPI-ESM1-2-HR','NorESM2-MM','MIROC6'};

save_peth_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\10-4-30a-all-pre-R95\';
cd(save_peth_1)
for i = 1 : length(model_name) % 选择模式读取数据
    % 第一年
    filename = [model_name{i},' pre for integrated of pixel in cell in ',num2str(1985),'.mat'];
    load(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\10-4-30a-all-pre-R95\',filename])
    pre_40a_China_1d_2D = pre_1d_preprocessing01_year_line_2D(1,:);
    clear pre_1d_preprocessing01_year_line_2D filename
    for year = 1986 : 2014
        filename = [model_name{i},' pre for integrated of pixel in cell in ',num2str(year),'.mat'];
        load(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\10-4-30a-all-pre-R95\',filename], 'pre_1d_preprocessing01_year_line_2D')
        pre_1d_preprocessing01_year_line_2D_part = pre_1d_preprocessing01_year_line_2D(1,:); % 提取出对应的部分
        clear pre_1d_preprocessing01_year_line_2D
        pre_40a_China_1d_2D = cell_intergrate(pre_40a_China_1d_2D,pre_1d_preprocessing01_year_line_2D_part);
        clear pre_1d_preprocessing01_year_line_2D_part filename
        disp([num2str(year),' is done!'])
    end
    
    filename2 = ['30a pre of pixel in one cell ',model_name{i},' 1d 025 scale 1985 2014.mat'];
    save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\10-4-30a-all-pre-R95\all_pre_in_cell_of_pixel\',filename2], 'pre_40a_China_1d_2D')
    clear pre_40a_China_1d_2D
end

%% 根据提取出来的降水计算两个阈值和百分位数
%% 这里还是用的未来30a自己的95分位数
%% 不考虑使用CMFD-历史时期的阈值（但是可以对比）

clear;clc;
model_name = {'MPI-ESM1-2-HR','NorESM2-MM','MIROC6'};
time_period = {'1985 2014'};
time_period2 = {'1985 2014'};

save_peth_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\10-4-30a-all-pre-R95\all_pre_in_cell_of_pixel\';
cd(save_peth_1)

for i = 1 : length(model_name) % 选择模式读取数据
    for m = 1 : length(time_period)
        filename2 = ['30a pre of pixel in one cell ',model_name{i},' 1d 025 scale 1985 2014.mat'];
        load(filename2)
        pre_event_thresold_all = cell_percentage_extract_5_95(pre_40a_China_1d_2D);
        clear pre_40a_China_1d_2D
        filename = [model_name{i},'_025_scale_1d_pre_event_thresold_5_95_in_cell.mat'];
        save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\10-4-30a-all-pre-R95\all_pre_in_cell_of_pixel\',filename], 'pre_event_thresold_all')
        clear pre_event_thresold_all filename2 filename
        disp([model_name{i},' is done!'])
    end
end

