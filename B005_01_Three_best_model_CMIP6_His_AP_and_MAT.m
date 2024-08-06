%% 这个文件根据提取出来的模型历史时期的降水和温度数据
%% 计算多年平均降水量和温度
%% 只针对三个最好的模型:MPI-ESM1-2-HR、NorESM2-MM和MIROC6
%% 注意温度中，BCC-CSM2-MR没有温度数据
%% 原始尺度和升尺度（实际降尺度））0.25°的结果
%% 时间尺度为1985-2014

% 原始尺度-降水
clear;clc
path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')
model_name = {'MPI-ESM1-2-HR','NorESM2-MM','MIROC6'};

save_peth_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2018-2058\7-3-history-pr-process-cell-data\';
cd(save_peth_1)

for i = 1 : length(model_name) % 选择模式读取数据
    filename_1 = [model_name{i},'_CN_1975_2014.mat'];
    load(filename_1)
    CMIP6_model_HisPr_1985_2014 = CMIP6_model_HisPr_1975_2014(11:end);
    clear CMIP6_model_HisPr_1975_2014
    
    Model_AP_1985_2014 = nan(length(Lon_CN),length(Lat_CN),2014-1985+1);
    for year = 1985:2014
        % 当年日降水三维矩阵
        Model_Pre_year = CMIP6_model_HisPr_1985_2014{year-1984,1};
        % 求年降水量
        Model_AP_1985_2014(:,:,year-1984) = nansum(Model_Pre_year,3);
        clear Model_Pre_year
    end
    filename2 = [model_name{i},'_AP_CN_1985_2014.mat'];
    save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\4-origin-scale-MAT-AP\',filename2],'Model_AP_1985_2014','Lon_CN','Lat_CN')
    disp([model_name{i},' is complete!'])
    clear Model_AP_1985_2014 Lon_CN Lat_CN filename2 filename_1
end

%% 升尺度后-年降水量

clear;clc
path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')
model_name = {'MPI-ESM1-2-HR','NorESM2-MM','MIROC6'};

save_peth_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2018-2058\7-4-His-pr-025-scale-cell-data\';
cd(save_peth_1)

for i = 1 : length(model_name) % 选择模式读取数据
    filename_1 = [model_name{i},'_CN_025_scale_1975_2014.mat'];
    load(filename_1)
    CMIP6_model_HisPr_1985_2014 = CMIP6_model_HisPr_1975_2014_025_scale(11:end);
    clear CMIP6_model_HisPr_1975_2014_025_scale
    
    Model_AP_1985_2014_025_scale = nan(size(xx_025,1),size(xx_025,2),2014-1985+1);
    for year = 1985:2014
        % 当年日降水三维矩阵
        Model_Pre_year = CMIP6_model_HisPr_1985_2014{year-1984,1};
        % 求年降水量
        Model_AP_1985_2014_025_scale(:,:,year-1984) = nansum(Model_Pre_year,3);
        clear Model_Pre_year
    end
    filename2 = [model_name{i},'_AP_CN_025_scale_1985_2014.mat'];
    save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\6-0-His-025-scale-MAT-AP\',filename2],'Model_AP_1985_2014_025_scale','xx_025','yy_025')
    disp([model_name{i},' is complete!'])
    clear Model_AP_1985_2014_025_scale Lon_CN Lat_CN filename2 filename_1
end

%% 原始尺度-温度
% MIROC6没有温度数据
clear;clc
path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')
model_name = {'MPI-ESM1-2-HR','NorESM2-MM'};

save_peth_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2018-2058\7-3-history-temp-process-cell-data\';
cd(save_peth_1)

for i = 1 : length(model_name) % 选择模式读取数据
    filename_1 = [model_name{i},'_CN_1975_2014.mat'];
    load(filename_1)
    CMIP6_model_HisTemp_1985_2014 = CMIP6_model_HisTemp_1975_2014(11:end);
    clear CMIP6_model_HisTemp_1975_2014
    
    Model_MAT_1985_2014 = nan(length(Lon_CN),length(Lat_CN),2014-1985+1);
    for year = 1985:2014
        % 当年温度三维矩阵
        Model_Tas_year = CMIP6_model_HisTemp_1985_2014{year-1984,1};
        % 求年降水量
        Model_MAT_1985_2014(:,:,year-1984) = nanmean(Model_Tas_year,3);
        clear Model_Tas_year 
    end
    filename2 = [model_name{i},'_MAT_CN_1985_2014.mat'];
    save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\4-origin-scale-MAT-AP\',filename2],'Model_MAT_1985_2014','Lon_CN','Lat_CN')
    disp([model_name{i},' is complete!'])
    clear Model_MAT_1985_2014 Lon_CN Lat_CN filename2 filename_1 
end

%% 升尺度后的温度

clear;clc
path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')
model_name = {'MPI-ESM1-2-HR','NorESM2-MM'};

save_peth_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2018-2058\7-4-His-temp-025-scale-cell-data\';
cd(save_peth_1)

for i = 1 : length(model_name) % 选择模式读取数据
    filename_1 = [model_name{i},'_CN_025_scale_1975_2014.mat'];
    load(filename_1)
    CMIP6_model_HisTemp_1985_2014 = CMIP6_model_HisTemp_1975_2014_025_scale(11:end);
    clear CMIP6_model_HisTemp_1975_2014
    
    Model_MAT_1985_2014_025_scale = nan(size(xx_025,1),size(xx_025,2),2014-1985+1);
    for year = 1985:2014
        % 当年温度三维矩阵
        Model_Tas_year = CMIP6_model_HisTemp_1985_2014{year-1984,1};
        % 求年降水量
        Model_MAT_1985_2014_025_scale(:,:,year-1984) = nanmean(Model_Tas_year,3);
        clear Model_Tas_year 
    end
    filename2 = [model_name{i},'_MAT_CN_025_scale_1985_2014.mat'];
    save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\6-0-His-025-scale-MAT-AP\',filename2],'Model_MAT_1985_2014_025_scale','xx_025','yy_025')
    disp([model_name{i},' is complete!'])
    clear Model_MAT_1985_2014_025_scale Lon_CN Lat_CN filename2 filename_1 
end


%% 升尺度下的模型集合平均
% 降水量

clear;clc;
path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')
model_name = {'MPI-ESM1-2-HR','NorESM2-MM','MIROC6'};

save_peth_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\6-0-His-025-scale-MAT-AP\';
cd(save_peth_1)

% 读取CMIP6三个模型下这种情景计算出来的30年降水数据集
for i = 1 : length(model_name) % 选择模式读取数据
    filename_1 = [model_name{i},'_AP_CN_025_scale_1985_2014.mat'];
    load(filename_1)

    eval(['Model_AP_',num2str(i),' = Model_AP_1985_2014_025_scale;'])
    clear filename_1 Model_AP_1985_2014_025_scale
end
    
% 计算三个模型的降水集合平均
Model_AP_ensemble_average_year = nan(size(Model_AP_1,1),size(Model_AP_1,2),size(Model_AP_1,3));
for m = 1 : size(Model_AP_1,3)
    Model_AP_three_model_year = nan(size(Model_AP_1,1),size(Model_AP_1,2),3);
    Model_AP_three_model_year(:,:,1) = Model_AP_1(:,:,m);
    Model_AP_three_model_year(:,:,2) = Model_AP_2(:,:,m);
    Model_AP_three_model_year(:,:,3) = Model_AP_3(:,:,m);
    Model_AP_ensemble_average_year(:,:,m) = nanmean(Model_AP_three_model_year,3);
    clear Model_AP_three_model_year
end
filename2 = 'Three_Model_ensemble_average_025_scale_AP_CN_1985_2014.mat';
save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\6-0-His-025-scale-MAT-AP\',filename2],'Model_AP_ensemble_average_year','xx_025','yy_025')


%% 年均温

clear;clc;
path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')
model_name = {'MPI-ESM1-2-HR','NorESM2-MM'};

save_peth_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\6-0-His-025-scale-MAT-AP\';
cd(save_peth_1)

% 读取CMIP6三个模型下这种情景计算出来的30年降水数据集
for i = 1 : length(model_name) % 选择模式读取数据
    filename_1 = [model_name{i},'_MAT_CN_025_scale_1985_2014.mat'];
    load(filename_1)

    eval(['Model_MAT_',num2str(i),' = Model_MAT_1985_2014_025_scale;'])
    clear filename_1 Model_MAT_1985_2014_025_scale
end
    
% 计算三个模型的降水集合平均
Model_MAT_ensemble_average_year = nan(size(Model_MAT_1,1),size(Model_MAT_1,2),size(Model_MAT_1,3));
for m = 1 : size(Model_MAT_1,3)
    Model_MAT_three_model_year = nan(size(Model_MAT_1,1),size(Model_MAT_1,2),2);
    Model_MAT_three_model_year(:,:,1) = Model_MAT_1(:,:,m);
    Model_MAT_three_model_year(:,:,2) = Model_MAT_2(:,:,m);
    Model_MAT_ensemble_average_year(:,:,m) = nanmean(Model_MAT_three_model_year,3);
    clear Model_MAT_three_model_year
end
filename2 = 'Three_Model_ensemble_average_025_scale_MAT_CN_1985_2014.mat';
save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\6-0-His-025-scale-MAT-AP\',filename2],'Model_MAT_ensemble_average_year','xx_025','yy_025')



