%% 读取CMIP6历史时期的数据，从而帮助进一步确定所使用的模型
%% 根据前面已经筛选得到的有四个模型SSP126、245、370、585的模式
%% 这里仅仅是提取，还没有处理单位问题和润平年问题

clear;clc;


CMIP6_model_name = {'EC-Earth3','MPI-ESM1-2-HR','IITM-ESM','NorESM2-LM','NorESM2-MM','MIROC6',...
    'TaiESM1','CESM2-WACCM','MPI-ESM1-2-LR','BCC-CSM2-MR','INM-CM4-8',...
    'INM-CM5-0','ACCESS-ESM1-5','MRI-ESM2-0','CanESM5'};

history_pr_index = nan(length(CMIP6_model_name),1);
for i = 1 : length(CMIP6_model_name)
    save_path_1 = ['Z:\CMIP6_WRCP_daily\',CMIP6_model_name{1},'\'];
    cd(save_path_1)
    
    namelist_all = dir(save_path_1);
    name_list = {namelist_all(:).name};
    
    file_ind_1 = contains(name_list,'histor'); % 包含历史的文件名
    file_ind_2 = contains(name_list,'pr'); % 包含降水的文件名
    k1 = find(file_ind_1 == 1);
    k2 = find(file_ind_2 == 1);
    if ~isempty(k1) && ~isempty(k2)
        history_pr_index(i) = 1; % 有历史时期的数据
    else
        history_pr_index(i) = 0; % 有历史时期的数据
    end
end

%% 都存在历史时期的数据，进行提取
%% 同样是不同模式按照不同的形式存储，并且仍然有润平年问题
%% 筛选1979-2014年有历史数据的

%% MPI-ESM1-2-HR 5年存一个数据
%% 考虑润平年
%% 这里分成两部分处理，首先从原始数据中提取中国地区，仍以5年的时间存储
clear;clc
% 读取CMFD的经纬度网格情况，从而提取中国地区的范围
load('F:\File_of_MATLAB\关于3h尺度的CMFD降水数据研究2022.3.2\Data\LLT.mat')

CMIP6_model_name = {'MPI-ESM1-2-HR'};
save_path_1 = ['Z:\CMIP6_WRCP_daily\',CMIP6_model_name{1},'\historical-pr\'];
cd(save_path_1)
namelist_all = dir([save_path_1,'*.nc']);
name_list = {namelist_all(:).name};

file_ind_1 = contains(name_list,'1975'); % 包含历史的文件名
file_ind_2 = contains(name_list,'2014'); % 包含降水的文件名

% 查找索引
k1 = find(file_ind_1 == 1);
k2 = find(file_ind_2 == 1);

year_range = nan(length(k1:k2),2);
for i = k1 : k2
    year_range(i-k1+1,1) = 1975 + (i-k1)*5;
    year_range(i-k1+1,2) = 1979 + (i-k1)*5;
end

% 打开对应文件夹
cd(save_path_1)
% 读取经纬度和时间
Lon = ncread(name_list{k1},'lon');
Lat = ncread(name_list{k1},'lat');

% 查找中国地区的经纬度范围，从而缩小提取数据大小
a = find(Lon(:) >= min(Lon_3h_scale) & Lon(:)<= max(Lon_3h_scale));%经度的指针
b = find(Lat(:) >= min(Lat_3h_scale) & Lat(:)<= max(Lat_3h_scale));%纬度的指针
Lon_CN = Lon(a);
Lat_CN = Lat(b);

year_index = 1;
for i = k1 : k2
    time = ncread(name_list{i},'time');
    Pr_His = ncread(name_list{i},'pr',[a(1) b(1) 1],[length(a) length(b) length(time)]);
    filename = ['MPI-ESM1-2-HR_historical_pr_CN_',num2str(year_range(i-k1+1,1)),'_',num2str(year_range(i-k1+1,2)),'.mat'];
    save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2018-2058\7-history-pr\',CMIP6_model_name{1},'\',filename],'Pr_His','Lon_CN','Lat_CN')
    clear Pr_His
end

%% IITM-ESM 5年存一个数据
%% 考虑润平年
clear;clc
% 读取CMFD的经纬度网格情况，从而提取中国地区的范围
load('F:\File_of_MATLAB\关于3h尺度的CMFD降水数据研究2022.3.2\Data\LLT.mat')

CMIP6_model_name = {'IITM-ESM'};
save_path_1 = ['Z:\CMIP6_WRCP_daily\',CMIP6_model_name{1},'\historical-pr\'];
cd(save_path_1)
namelist_all = dir([save_path_1,'*.nc']);
name_list = {namelist_all(:).name};

file_ind_1 = contains(name_list,'1975'); % 包含历史的文件名
file_ind_2 = contains(name_list,'2014'); % 包含降水的文件名

% 查找索引
k1 = find(file_ind_1 == 1);
k2 = find(file_ind_2 == 1);

year_range = nan(length(k1:k2),2);
for i = k1 : k2
    year_range(i-k1+1,1) = 1975 + (i-k1)*5;
    year_range(i-k1+1,2) = 1979 + (i-k1)*5;
end

% 打开对应文件夹
cd(save_path_1)
% 读取经纬度和时间
Lon = ncread(name_list{k1},'lon');
Lat = ncread(name_list{k1},'lat');

% 查找中国地区的经纬度范围，从而缩小提取数据大小
a = find(Lon(:) >= min(Lon_3h_scale) & Lon(:)<= max(Lon_3h_scale));%经度的指针
b = find(Lat(:) >= min(Lat_3h_scale) & Lat(:)<= max(Lat_3h_scale));%纬度的指针
Lon_CN = Lon(a);
Lat_CN = Lat(b);

year_index = 1;
for i = k1 : k2
    time = ncread(name_list{i},'time');
    Pr_His = ncread(name_list{i},'pr',[a(1) b(1) 1],[length(a) length(b) length(time)]);
    filename = [CMIP6_model_name{1},'_historical_pr_CN_',num2str(year_range(i-k1+1,1)),'_',num2str(year_range(i-k1+1,2)),'.mat'];
    save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2018-2058\7-history-pr\',CMIP6_model_name{1},'\',filename],'Pr_His','Lon_CN','Lat_CN')
    clear Pr_His
end

%% NorESM2-LM 10年存一个数据
%% 不区分润平年
clear;clc
% 读取CMFD的经纬度网格情况，从而提取中国地区的范围
load('F:\File_of_MATLAB\关于3h尺度的CMFD降水数据研究2022.3.2\Data\LLT.mat')

CMIP6_model_name = {'NorESM2-LM'};
save_path_1 = ['Z:\CMIP6_WRCP_daily\',CMIP6_model_name{1},'\historical-pr\'];
cd(save_path_1)
namelist_all = dir([save_path_1,'*.nc']);
name_list = {namelist_all(:).name};

file_ind_1 = contains(name_list,'1970'); % 包含历史的文件名
file_ind_2 = contains(name_list,'2014'); % 包含降水的文件名

% 查找索引
k1 = find(file_ind_1 == 1);
k2 = find(file_ind_2 == 1);

year_range = nan(length(k1:k2),2);
for i = k1 : k2
    year_range(i-k1+1,1) = 1970 + (i-k1)*10;
    if i ~= k2
        year_range(i-k1+1,2) = 1979 + (i-k1)*10;
    else
        year_range(i-k1+1,2) = 2014;
    end
end

% 打开对应文件夹
cd(save_path_1)
% 读取经纬度和时间
Lon = ncread(name_list{k1},'lon');
Lat = ncread(name_list{k1},'lat');

% 查找中国地区的经纬度范围，从而缩小提取数据大小
a = find(Lon(:) >= min(Lon_3h_scale) & Lon(:)<= max(Lon_3h_scale));%经度的指针
b = find(Lat(:) >= min(Lat_3h_scale) & Lat(:)<= max(Lat_3h_scale));%纬度的指针
Lon_CN = Lon(a);
Lat_CN = Lat(b);

year_index = 1;
for i = k1 : k2
    time = ncread(name_list{i},'time');
    Pr_His = ncread(name_list{i},'pr',[a(1) b(1) 1],[length(a) length(b) length(time)]);
    filename = [CMIP6_model_name{1},'_historical_pr_CN_',num2str(year_range(i-k1+1,1)),'_',num2str(year_range(i-k1+1,2)),'.mat'];
    save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2018-2058\7-history-pr\',CMIP6_model_name{1},'\',filename],'Pr_His','Lon_CN','Lat_CN')
    clear Pr_His
end

%% NorESM2-MM 6年存一个数据
%% 不区分润平年
clear;clc
% 读取CMFD的经纬度网格情况，从而提取中国地区的范围
load('F:\File_of_MATLAB\关于3h尺度的CMFD降水数据研究2022.3.2\Data\LLT.mat')

CMIP6_model_name = {'NorESM2-MM'};
save_path_1 = ['Z:\CMIP6_WRCP_daily\',CMIP6_model_name{1},'\historical-pr\'];
cd(save_path_1)
namelist_all = dir([save_path_1,'*.nc']);
name_list = {namelist_all(:).name};

file_ind_1 = contains(name_list,'1970'); % 包含历史的文件名
file_ind_2 = contains(name_list,'2014'); % 包含降水的文件名

% 查找索引
k1 = find(file_ind_1 == 1);
k2 = find(file_ind_2 == 1);

year_range = nan(length(k1:k2),2);
for i = k1 : k2
    year_range(i-k1+1,1) = 1970 + (i-k1)*10;
    if i ~= k2
        year_range(i-k1+1,2) = 1979 + (i-k1)*10;
    else
        year_range(i-k1+1,2) = 2014;
    end
end

% 打开对应文件夹
cd(save_path_1)
% 读取经纬度和时间
Lon = ncread(name_list{k1},'lon');
Lat = ncread(name_list{k1},'lat');

% 查找中国地区的经纬度范围，从而缩小提取数据大小
a = find(Lon(:) >= min(Lon_3h_scale) & Lon(:)<= max(Lon_3h_scale));%经度的指针
b = find(Lat(:) >= min(Lat_3h_scale) & Lat(:)<= max(Lat_3h_scale));%纬度的指针
Lon_CN = Lon(a);
Lat_CN = Lat(b);

year_index = 1;
for i = k1 : k2
    time = ncread(name_list{i},'time');
    Pr_His = ncread(name_list{i},'pr',[a(1) b(1) 1],[length(a) length(b) length(time)]);
    filename = [CMIP6_model_name{1},'_historical_pr_CN_',num2str(year_range(i-k1+1,1)),'_',num2str(year_range(i-k1+1,2)),'.mat'];
    save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2018-2058\7-history-pr\',CMIP6_model_name{1},'\',filename],'Pr_His','Lon_CN','Lat_CN')
    clear Pr_His
end

%% MIROC6 10年存一个数据
%% 并且区分润平年

clear;clc
% 读取CMFD的经纬度网格情况，从而提取中国地区的范围
load('F:\File_of_MATLAB\关于3h尺度的CMFD降水数据研究2022.3.2\Data\LLT.mat')

CMIP6_model_name = {'MIROC6'};
save_path_1 = ['Z:\CMIP6_WRCP_daily\',CMIP6_model_name{1},'\historical-pr\'];
cd(save_path_1)
namelist_all = dir([save_path_1,'*.nc']);
name_list = {namelist_all(:).name};

file_ind_1 = contains(name_list,'1970'); % 包含历史的文件名
file_ind_2 = contains(name_list,'2014'); % 包含降水的文件名

% 查找索引
k1 = find(file_ind_1 == 1);
k2 = find(file_ind_2 == 1);

year_range = nan(length(k1:k2),2);
for i = k1 : k2
    year_range(i-k1+1,1) = 1970 + (i-k1)*10;
    if i ~= k2
        year_range(i-k1+1,2) = 1979 + (i-k1)*10;
    else
        year_range(i-k1+1,2) = 2014;
    end
end

% 打开对应文件夹
cd(save_path_1)
% 读取经纬度和时间
Lon = ncread(name_list{k1},'lon');
Lat = ncread(name_list{k1},'lat');

% 查找中国地区的经纬度范围，从而缩小提取数据大小
a = find(Lon(:) >= min(Lon_3h_scale) & Lon(:)<= max(Lon_3h_scale));%经度的指针
b = find(Lat(:) >= min(Lat_3h_scale) & Lat(:)<= max(Lat_3h_scale));%纬度的指针
Lon_CN = Lon(a);
Lat_CN = Lat(b);

year_index = 1;
for i = k1 : k2
    time = ncread(name_list{i},'time');
    Pr_His = ncread(name_list{i},'pr',[a(1) b(1) 1],[length(a) length(b) length(time)]);
    filename = [CMIP6_model_name{1},'_historical_pr_CN_',num2str(year_range(i-k1+1,1)),'_',num2str(year_range(i-k1+1,2)),'.mat'];
    save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2018-2058\7-history-pr\',CMIP6_model_name{1},'\',filename],'Pr_His','Lon_CN','Lat_CN')
    clear Pr_His
end

%% TaiESM1  10年存一个数据
%% 不考虑润平年

clear;clc
% 读取CMFD的经纬度网格情况，从而提取中国地区的范围
load('F:\File_of_MATLAB\关于3h尺度的CMFD降水数据研究2022.3.2\Data\LLT.mat')

CMIP6_model_name = {'TaiESM1'};
save_path_1 = ['Z:\CMIP6_WRCP_daily\',CMIP6_model_name{1},'\historical-pr\'];
cd(save_path_1)
namelist_all = dir([save_path_1,'*.nc']);
name_list = {namelist_all(:).name};

file_ind_1 = contains(name_list,'1970'); % 包含历史的文件名
file_ind_2 = contains(name_list,'2014'); % 包含降水的文件名

% 查找索引
k1 = find(file_ind_1 == 1);
k2 = find(file_ind_2 == 1);

year_range = nan(length(k1:k2),2);
for i = k1 : k2
    year_range(i-k1+1,1) = 1970 + (i-k1)*10;
    if i ~= k2
        year_range(i-k1+1,2) = 1979 + (i-k1)*10;
    else
        year_range(i-k1+1,2) = 2014;
    end
end

% 打开对应文件夹
cd(save_path_1)
% 读取经纬度和时间
Lon = ncread(name_list{k1},'lon');
Lat = ncread(name_list{k1},'lat');

% 查找中国地区的经纬度范围，从而缩小提取数据大小
a = find(Lon(:) >= min(Lon_3h_scale) & Lon(:)<= max(Lon_3h_scale));%经度的指针
b = find(Lat(:) >= min(Lat_3h_scale) & Lat(:)<= max(Lat_3h_scale));%纬度的指针
Lon_CN = Lon(a);
Lat_CN = Lat(b);

year_index = 1;
for i = k1 : k2
    time = ncread(name_list{i},'time');
    Pr_His = ncread(name_list{i},'pr',[a(1) b(1) 1],[length(a) length(b) length(time)]);
    filename = [CMIP6_model_name{1},'_historical_pr_CN_',num2str(year_range(i-k1+1,1)),'_',num2str(year_range(i-k1+1,2)),'.mat'];
    save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2018-2058\7-history-pr\',CMIP6_model_name{1},'\',filename],'Pr_His','Lon_CN','Lat_CN')
    clear Pr_His
end

%% MPI-ESM1-2-LR 20a存储一个数据
%% 考虑润平年

clear;clc
% 读取CMFD的经纬度网格情况，从而提取中国地区的范围
load('F:\File_of_MATLAB\关于3h尺度的CMFD降水数据研究2022.3.2\Data\LLT.mat')

CMIP6_model_name = {'MPI-ESM1-2-LR'};
save_path_1 = ['Z:\CMIP6_WRCP_daily\',CMIP6_model_name{1},'\historical-pr\'];
cd(save_path_1)
namelist_all = dir([save_path_1,'*.nc']);
name_list = {namelist_all(:).name};

file_ind_1 = contains(name_list,'1970'); % 包含历史的文件名
file_ind_2 = contains(name_list,'2014'); % 包含降水的文件名

% 查找索引
k1 = find(file_ind_1 == 1);
k2 = find(file_ind_2 == 1);

year_range = nan(length(k1:k2),2);
for i = k1 : k2
    year_range(i-k1+1,1) = 1970 + (i-k1)*20;
    if i ~= k2
        year_range(i-k1+1,2) = 1989 + (i-k1)*20;
    else
        year_range(i-k1+1,2) = 2014;
    end
end

% 打开对应文件夹
cd(save_path_1)
% 读取经纬度和时间
Lon = ncread(name_list{k1},'lon');
Lat = ncread(name_list{k1},'lat');

% 查找中国地区的经纬度范围，从而缩小提取数据大小
a = find(Lon(:) >= min(Lon_3h_scale) & Lon(:)<= max(Lon_3h_scale));%经度的指针
b = find(Lat(:) >= min(Lat_3h_scale) & Lat(:)<= max(Lat_3h_scale));%纬度的指针
Lon_CN = Lon(a);
Lat_CN = Lat(b);

year_index = 1;
for i = k1 : k2
    time = ncread(name_list{i},'time');
    Pr_His = ncread(name_list{i},'pr',[a(1) b(1) 1],[length(a) length(b) length(time)]);
    filename = [CMIP6_model_name{1},'_historical_pr_CN_',num2str(year_range(i-k1+1,1)),'_',num2str(year_range(i-k1+1,2)),'.mat'];
    save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2018-2058\7-history-pr\',CMIP6_model_name{1},'\',filename],'Pr_His','Lon_CN','Lat_CN')
    clear Pr_His
end

%% BCC-CSM2-MR 25a存储一个数据
%% 不考虑润平年

clear;clc
% 读取CMFD的经纬度网格情况，从而提取中国地区的范围
load('F:\File_of_MATLAB\关于3h尺度的CMFD降水数据研究2022.3.2\Data\LLT.mat')

CMIP6_model_name = {'BCC-CSM2-MR'};
save_path_1 = ['Z:\CMIP6_WRCP_daily\',CMIP6_model_name{1},'\historical-pr\'];
cd(save_path_1)
namelist_all = dir([save_path_1,'*.nc']);
name_list = {namelist_all(:).name};

file_ind_1 = contains(name_list,'1975'); % 包含历史的文件名
file_ind_2 = contains(name_list,'2014'); % 包含降水的文件名

% 查找索引
k1 = find(file_ind_1 == 1);
k2 = find(file_ind_2 == 1);

year_range = nan(length(k1:k2),2);
for i = k1 : k2
    year_range(i-k1+1,1) = 1975 + (i-k1)*25;
    if i ~= k2
        year_range(i-k1+1,2) = 1999 + (i-k1)*25;
    else
        year_range(i-k1+1,2) = 2014;
    end
end

% 打开对应文件夹
cd(save_path_1)
% 读取经纬度和时间
Lon = ncread(name_list{k1},'lon');
Lat = ncread(name_list{k1},'lat');

% 查找中国地区的经纬度范围，从而缩小提取数据大小
a = find(Lon(:) >= min(Lon_3h_scale) & Lon(:)<= max(Lon_3h_scale));%经度的指针
b = find(Lat(:) >= min(Lat_3h_scale) & Lat(:)<= max(Lat_3h_scale));%纬度的指针
Lon_CN = Lon(a);
Lat_CN = Lat(b);

year_index = 1;
for i = k1 : k2
    time = ncread(name_list{i},'time');
    Pr_His = ncread(name_list{i},'pr',[a(1) b(1) 1],[length(a) length(b) length(time)]);
    filename = [CMIP6_model_name{1},'_historical_pr_CN_',num2str(year_range(i-k1+1,1)),'_',num2str(year_range(i-k1+1,2)),'.mat'];
    save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2018-2058\7-history-pr\',CMIP6_model_name{1},'\',filename],'Pr_His','Lon_CN','Lat_CN')
    clear Pr_His
end

%% MRI-ESM2-0 50年存一个数据
%% 考虑润平年

clear;clc
% 读取CMFD的经纬度网格情况，从而提取中国地区的范围
load('F:\File_of_MATLAB\关于3h尺度的CMFD降水数据研究2022.3.2\Data\LLT.mat')

CMIP6_model_name = {'MRI-ESM2-0'};
save_path_1 = ['Z:\CMIP6_WRCP_daily\',CMIP6_model_name{1},'\historical-pr\'];
cd(save_path_1)
namelist_all = dir([save_path_1,'*.nc']);
name_list = {namelist_all(:).name};

file_ind_1 = contains(name_list,'1950'); % 包含历史的文件名
file_ind_2 = contains(name_list,'2014'); % 包含降水的文件名

% 查找索引
k1 = find(file_ind_1 == 1);
k2 = find(file_ind_2 == 1);

year_range = nan(length(k1:k2),2);
for i = k1 : k2
    year_range(i-k1+1,1) = 1950 + (i-k1)*50;
    if i ~= k2
        year_range(i-k1+1,2) = 1999 + (i-k1)*50;
    else
        year_range(i-k1+1,2) = 2014;
    end
end

% 打开对应文件夹
cd(save_path_1)
% 读取经纬度和时间
Lon = ncread(name_list{k1},'lon');
Lat = ncread(name_list{k1},'lat');

% 查找中国地区的经纬度范围，从而缩小提取数据大小
a = find(Lon(:) >= min(Lon_3h_scale) & Lon(:)<= max(Lon_3h_scale));%经度的指针
b = find(Lat(:) >= min(Lat_3h_scale) & Lat(:)<= max(Lat_3h_scale));%纬度的指针
Lon_CN = Lon(a);
Lat_CN = Lat(b);

year_index = 1;
for i = k1 : k2
    time = ncread(name_list{i},'time');
    Pr_His = ncread(name_list{i},'pr',[a(1) b(1) 1],[length(a) length(b) length(time)]);
    filename = [CMIP6_model_name{1},'_historical_pr_CN_',num2str(year_range(i-k1+1,1)),'_',num2str(year_range(i-k1+1,2)),'.mat'];
    save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2018-2058\7-history-pr\',CMIP6_model_name{1},'\',filename],'Pr_His','Lon_CN','Lat_CN')
    clear Pr_His
end

%% CanESM5 100年存一个数据
%% 不考虑润平年

clear;clc
% 读取CMFD的经纬度网格情况，从而提取中国地区的范围
load('F:\File_of_MATLAB\关于3h尺度的CMFD降水数据研究2022.3.2\Data\LLT.mat')

CMIP6_model_name = {'CanESM5'};
save_path_1 = ['Z:\CMIP6_WRCP_daily\',CMIP6_model_name{1},'\historical-pr\'];
cd(save_path_1)
namelist_all = dir([save_path_1,'*.nc']);
name_list = {namelist_all(:).name};

file_ind_1 = contains(name_list,'1850'); % 包含历史的文件名
file_ind_2 = contains(name_list,'2014'); % 包含降水的文件名

% 查找索引
k1 = find(file_ind_1 == 1);
k2 = find(file_ind_2 == 1);

year_range = nan(length(k1:k2),2);
for i = k1 : k2
    year_range(i-k1+1,1) = 1850 + (i-k1)*50;
    if i ~= k2
        year_range(i-k1+1,2) = 1999 + (i-k1)*50;
    else
        year_range(i-k1+1,2) = 2014;
    end
end

% 打开对应文件夹
cd(save_path_1)
% 读取经纬度和时间
Lon = ncread(name_list{k1},'lon');
Lat = ncread(name_list{k1},'lat');

% 查找中国地区的经纬度范围，从而缩小提取数据大小
a = find(Lon(:) >= min(Lon_3h_scale) & Lon(:)<= max(Lon_3h_scale));%经度的指针
b = find(Lat(:) >= min(Lat_3h_scale) & Lat(:)<= max(Lat_3h_scale));%纬度的指针
Lon_CN = Lon(a);
Lat_CN = Lat(b);

year_index = 1;
for i = k1 : k2
    time = ncread(name_list{i},'time');
    Pr_His = ncread(name_list{i},'pr',[a(1) b(1) 1],[length(a) length(b) length(time)]);
    filename = [CMIP6_model_name{1},'_historical_pr_CN_',num2str(year_range(i-k1+1,1)),'_',num2str(year_range(i-k1+1,2)),'.mat'];
    save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2018-2058\7-history-pr\',CMIP6_model_name{1},'\',filename],'Pr_His','Lon_CN','Lat_CN')
    clear Pr_His
end

