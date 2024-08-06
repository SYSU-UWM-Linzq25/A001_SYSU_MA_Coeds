%% 这个文件根据初步提取出来的未来数据进一步的处理
%% 包括单位的转换，润平年问题，统一存储为cell格式
%% 首先将数据进行逐年存储
%% MPI-ESM1-2-HR 5a ✔ 考虑润平年
% 这里还是保留2018-2058年

clear;clc;
model_name = {'MPI-ESM1-2-HR'};
SSP_type = {'ssp126','ssp245','ssp370','ssp585'};
Data_type = {'pr','tas'};

save_path_1 = ['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2018-2058\1-origin-data\',model_name{1},'\'];
save_path_2 = ['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2018-2058\2-data-by-year\',model_name{1},'\'];
% CMIP6_model_Tas_Pr_2018_2058 = cell(2058-2018+1,2);
cd(save_path_1)

% 文件夹下面所有的文件
namelist_all = dir([save_path_1,'*.mat']);
name_list = {namelist_all(:).name};

% % 查找索引
% k1 = find(file_ind_1 == 1);
% k2 = find(file_ind_2 == 1);

year_range = nan(length(name_list)/8,2);
for i = 1 : length(name_list)/8
    year_range(i,1) = 2015 + (i-1)*5;
    year_range(i,2) = 2019 + (i-1)*5;
end

% 计算每一年的天数
clear i
day_year_all = nan(length(year_range(1):year_range(end)),1);
for i = 1 : length(day_year_all)
    day_year_all(i) = leapyear(i + 2014) + 365; % 考虑润平年
%     day_year_all(i) = 365; % 不考虑润平年
end

clear i
for i = 1 : length(name_list)/8 % 年份间隔循环
    year_part = [num2str(year_range(i,1)),'_',num2str(year_range(i,2))];
    % 计算相应年份的提取索引
    year_data_index = nan(length(year_range(i,1):year_range(i,2)),2);
    data_year_part = day_year_all(year_range(i,1) - 2014 : year_range(i,2) - 2014);
    for n = year_range(i,1):year_range(i,2)
        year_data_index(n-year_range(i,1)+1,1) = 1 + sum(data_year_part(1 : n - year_range(i,1)));
        year_data_index(n-year_range(i,1)+1,2) = sum(data_year_part(1 : n - year_range(i,1) + 1));
    end
    
    for j = 1 : length(SSP_type) % 未来情景循环
        for m = 1 : length(Data_type) % 数据类型循环
            filename_1 = [model_name{1},'_',Data_type{m},'_',SSP_type{j},'_CN_',year_part,'.mat'];
            load(filename_1)
            
            for year = year_range(i,1) : year_range(i,2)
                Pr_or_Tas_year = Pr_or_Tas(:,:,year_data_index(year - year_range(i,1) + 1,1): year_data_index(year - year_range(i,1) + 1,2));
                filename2 = [model_name{1},'_',Data_type{m},'_',SSP_type{j},'_CN_',num2str(year),'.mat'];
                save([save_path_2,filename2],'Pr_or_Tas_year','Lon_CN','Lat_CN')
                clear filename2 Pr_or_Tas_year
            end
            clear filename_1 Pr_or_Tas
        end
         disp([SSP_type{j},'_',year_part,' is complete!'])
    end
    clear year_data_index data_year_part n year_part
end


%% IITM-ESM 5a ✔ 考虑润平年
clear;clc;
model_name = {'IITM-ESM'};
SSP_type = {'ssp126','ssp245','ssp370','ssp585'};
Data_type = {'pr','tas'};

save_path_1 = ['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2018-2058\1-origin-data\',model_name{1},'\'];
save_path_2 = ['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2018-2058\2-data-by-year\',model_name{1},'\'];
% CMIP6_model_Tas_Pr_2018_2058 = cell(2058-2018+1,2);
cd(save_path_1)

% 文件夹下面所有的文件
namelist_all = dir([save_path_1,'*.mat']);
name_list = {namelist_all(:).name};

% % 查找索引
% k1 = find(file_ind_1 == 1);
% k2 = find(file_ind_2 == 1);

year_range = nan(length(name_list)/8,2);
for i = 1 : length(name_list)/8
    year_range(i,1) = 2015 + (i-1)*5;
    year_range(i,2) = 2019 + (i-1)*5;
end

% 计算每一年的天数
clear i
day_year_all = nan(length(year_range(1):year_range(end)),1);
for i = 1 : length(day_year_all)
    day_year_all(i) = leapyear(i + 2014) + 365; % 考虑润平年
%     day_year_all(i) = 365; % 不考虑润平年
end

clear i
for i = 1 : length(name_list)/8 % 年份间隔循环
    year_part = [num2str(year_range(i,1)),'_',num2str(year_range(i,2))];
    % 计算相应年份的提取索引
    year_data_index = nan(length(year_range(i,1):year_range(i,2)),2);
    data_year_part = day_year_all(year_range(i,1) - 2014 : year_range(i,2) - 2014);
    for n = year_range(i,1):year_range(i,2)
        year_data_index(n-year_range(i,1)+1,1) = 1 + sum(data_year_part(1 : n - year_range(i,1)));
        year_data_index(n-year_range(i,1)+1,2) = sum(data_year_part(1 : n - year_range(i,1) + 1));
    end
    
    for j = 1 : length(SSP_type) % 未来情景循环
        for m = 1 : length(Data_type) % 数据类型循环
            filename_1 = [model_name{1},'_',Data_type{m},'_',SSP_type{j},'_CN_',year_part,'.mat'];
            load(filename_1)
            
            for year = year_range(i,1) : year_range(i,2)
                Pr_or_Tas_year = Pr_or_Tas(:,:,year_data_index(year - year_range(i,1) + 1,1): year_data_index(year - year_range(i,1) + 1,2));
                filename2 = [model_name{1},'_',Data_type{m},'_',SSP_type{j},'_CN_',num2str(year),'.mat'];
                save([save_path_2,filename2],'Pr_or_Tas_year','Lon_CN','Lat_CN')
                clear filename2 Pr_or_Tas_year
            end
            clear filename_1 Pr_or_Tas
        end
         disp([SSP_type{j},'_',year_part,' is complete!'])
    end
    clear year_data_index data_year_part n year_part
end

%% NorESM2-LM 6a ✔ 不考虑润平年
% 原始文件tas_day_NorESM2-LM_ssp126_r1i1p1f1_gn_20410101-20501231.nc中，时间就是少了一个，强制补充一个nan矩阵给它
clear;clc;
model_name = {'NorESM2-LM'};
SSP_type = {'ssp126','ssp245','ssp370','ssp585'};
Data_type = {'pr','tas'};

save_path_1 = ['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2018-2058\1-origin-data\',model_name{1},'\'];
save_path_2 = ['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2018-2058\2-data-by-year\',model_name{1},'\'];
% CMIP6_model_Tas_Pr_2018_2058 = cell(2058-2018+1,2);
cd(save_path_1)

% 文件夹下面所有的文件
namelist_all = dir([save_path_1,'*.mat']);
name_list = {namelist_all(:).name};

% % 查找索引
% k1 = find(file_ind_1 == 1);
% k2 = find(file_ind_2 == 1);

year_range = nan(length(name_list)/8,2);
for i = 1 : length(name_list)/8
    if i == 1
        year_range(i,1) = 2015;
        year_range(i,2) = 2020;
    else
        year_range(i,1) = 2021 + (i-2)*10;
        year_range(i,2) = 2030 + (i-2)*10;
    end
end

% 计算每一年的天数
clear i
day_year_all = nan(length(year_range(1):year_range(end)),1);
for i = 1 : length(day_year_all)
%     day_year_all(i) = leapyear(i + 2014) + 365; % 考虑润平年
    day_year_all(i) = 365; % 不考虑润平年
end

clear i
for i = 1 : length(name_list)/8 % 年份间隔循环
    year_part = [num2str(year_range(i,1)),'_',num2str(year_range(i,2))];
    % 计算相应年份的提取索引
    year_data_index = nan(length(year_range(i,1):year_range(i,2)),2);
    data_year_part = day_year_all(year_range(i,1) - 2014 : year_range(i,2) - 2014);
    for n = year_range(i,1):year_range(i,2)
        year_data_index(n-year_range(i,1)+1,1) = 1 + sum(data_year_part(1 : n - year_range(i,1)));
        year_data_index(n-year_range(i,1)+1,2) = sum(data_year_part(1 : n - year_range(i,1) + 1));
    end
    
    for j = 1 : length(SSP_type) % 未来情景循环
        for m = 1 : length(Data_type) % 数据类型循环
            filename_1 = [model_name{1},'_',Data_type{m},'_',SSP_type{j},'_CN_',year_part,'.mat'];
            load(filename_1)
            
%             % 强制补充缺失的一日
%             Pr_or_Tas_supply = nan(size(Pr_or_Tas,1),size(Pr_or_Tas,2));
%             Pr_or_Tas(:,:,size(Pr_or_Tas,3) + 1) = Pr_or_Tas_supply;
%             save([save_path_1,filename_1],'Pr_or_Tas','Lon_CN','Lat_CN')  
            for year = year_range(i,1) : year_range(i,2)
                Pr_or_Tas_year = Pr_or_Tas(:,:,year_data_index(year - year_range(i,1) + 1,1): year_data_index(year - year_range(i,1) + 1,2));
                filename2 = [model_name{1},'_',Data_type{m},'_',SSP_type{j},'_CN_',num2str(year),'.mat'];
                save([save_path_2,filename2],'Pr_or_Tas_year','Lon_CN','Lat_CN')
                clear filename2 Pr_or_Tas_year
            end
            clear filename_1 Pr_or_Tas
        end
         disp([SSP_type{j},'_',year_part,' is complete!'])
    end
    clear year_data_index data_year_part n year_part
end

%% NorESM2-MM 6a ✔ 不考虑润平年
clear;clc;
model_name = {'NorESM2-MM'};
SSP_type = {'ssp126','ssp245','ssp370','ssp585'};
Data_type = {'pr','tas'};

save_path_1 = ['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2018-2058\1-origin-data\',model_name{1},'\'];
save_path_2 = ['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2018-2058\2-data-by-year\',model_name{1},'\'];
% CMIP6_model_Tas_Pr_2018_2058 = cell(2058-2018+1,2);
cd(save_path_1)

% 文件夹下面所有的文件
namelist_all = dir([save_path_1,'*.mat']);
name_list = {namelist_all(:).name};

% % 查找索引
% k1 = find(file_ind_1 == 1);
% k2 = find(file_ind_2 == 1);

year_range = nan(length(name_list)/8,2);
for i = 1 : length(name_list)/8
    if i == 1
        year_range(i,1) = 2015;
        year_range(i,2) = 2020;
    else
        year_range(i,1) = 2021 + (i-2)*10;
        year_range(i,2) = 2030 + (i-2)*10;
    end
end

% 计算每一年的天数
clear i
day_year_all = nan(length(year_range(1):year_range(end)),1);
for i = 1 : length(day_year_all)
%     day_year_all(i) = leapyear(i + 2014) + 365; % 考虑润平年
    day_year_all(i) = 365; % 不考虑润平年
end

clear i
for i = 1 : length(name_list)/8 % 年份间隔循环
    year_part = [num2str(year_range(i,1)),'_',num2str(year_range(i,2))];
    % 计算相应年份的提取索引
    year_data_index = nan(length(year_range(i,1):year_range(i,2)),2);
    data_year_part = day_year_all(year_range(i,1) - 2014 : year_range(i,2) - 2014);
    for n = year_range(i,1):year_range(i,2)
        year_data_index(n-year_range(i,1)+1,1) = 1 + sum(data_year_part(1 : n - year_range(i,1)));
        year_data_index(n-year_range(i,1)+1,2) = sum(data_year_part(1 : n - year_range(i,1) + 1));
    end
    
    for j = 1 : length(SSP_type) % 未来情景循环
        for m = 1 : length(Data_type) % 数据类型循环
            filename_1 = [model_name{1},'_',Data_type{m},'_',SSP_type{j},'_CN_',year_part,'.mat'];
            load(filename_1)
            
            for year = year_range(i,1) : year_range(i,2)
                Pr_or_Tas_year = Pr_or_Tas(:,:,year_data_index(year - year_range(i,1) + 1,1): year_data_index(year - year_range(i,1) + 1,2));
                filename2 = [model_name{1},'_',Data_type{m},'_',SSP_type{j},'_CN_',num2str(year),'.mat'];
                save([save_path_2,filename2],'Pr_or_Tas_year','Lon_CN','Lat_CN')
                clear filename2 Pr_or_Tas_year
            end
            clear filename_1 Pr_or_Tas
        end
         disp([SSP_type{j},'_',year_part,' is complete!'])
    end
    clear year_data_index data_year_part n year_part
end

%% MIROC6 10a ✔ 考虑润平年
clear;clc;
model_name = {'MIROC6'};
SSP_type = {'ssp126','ssp245','ssp370','ssp585'};
Data_type = {'pr','tas'};

save_path_1 = ['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2018-2058\1-origin-data\',model_name{1},'\'];
save_path_2 = ['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2018-2058\2-data-by-year\',model_name{1},'\'];
% CMIP6_model_Tas_Pr_2018_2058 = cell(2058-2018+1,2);
cd(save_path_1)

% 文件夹下面所有的文件
namelist_all = dir([save_path_1,'*.mat']);
name_list = {namelist_all(:).name};

% % 查找索引
% k1 = find(file_ind_1 == 1);
% k2 = find(file_ind_2 == 1);

year_range = nan(length(name_list)/8,2);
for i = 1 : length(name_list)/8
    year_range(i,1) = 2015 + (i-1)*10;
    year_range(i,2) = 2024 + (i-1)*10;
end

% 计算每一年的天数
clear i
day_year_all = nan(length(year_range(1):year_range(end)),1);
for i = 1 : length(day_year_all)
    day_year_all(i) = leapyear(i + 2014) + 365; % 考虑润平年
%     day_year_all(i) = 365; % 不考虑润平年
end

clear i
for i = 1 : length(name_list)/8 % 年份间隔循环
    year_part = [num2str(year_range(i,1)),'_',num2str(year_range(i,2))];
    % 计算相应年份的提取索引
    year_data_index = nan(length(year_range(i,1):year_range(i,2)),2);
    data_year_part = day_year_all(year_range(i,1) - 2014 : year_range(i,2) - 2014);
    for n = year_range(i,1):year_range(i,2)
        year_data_index(n-year_range(i,1)+1,1) = 1 + sum(data_year_part(1 : n - year_range(i,1)));
        year_data_index(n-year_range(i,1)+1,2) = sum(data_year_part(1 : n - year_range(i,1) + 1));
    end
    
    for j = 1 : length(SSP_type) % 未来情景循环
        for m = 1 : length(Data_type) % 数据类型循环
            filename_1 = [model_name{1},'_',Data_type{m},'_',SSP_type{j},'_CN_',year_part,'.mat'];
            load(filename_1)
            
            for year = year_range(i,1) : year_range(i,2)
                Pr_or_Tas_year = Pr_or_Tas(:,:,year_data_index(year - year_range(i,1) + 1,1): year_data_index(year - year_range(i,1) + 1,2));
                filename2 = [model_name{1},'_',Data_type{m},'_',SSP_type{j},'_CN_',num2str(year),'.mat'];
                save([save_path_2,filename2],'Pr_or_Tas_year','Lon_CN','Lat_CN')
                clear filename2 Pr_or_Tas_year
            end
            clear filename_1 Pr_or_Tas
        end
         disp([SSP_type{j},'_',year_part,' is complete!'])
    end
    clear year_data_index data_year_part n year_part
end


%% TaiESM1 10a ✔ 不考虑润平年
clear;clc;
model_name = {'TaiESM1'};
SSP_type = {'ssp126','ssp245','ssp370','ssp585'};
Data_type = {'pr','tas'};

save_path_1 = ['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2018-2058\1-origin-data\',model_name{1},'\'];
save_path_2 = ['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2018-2058\2-data-by-year\',model_name{1},'\'];
% CMIP6_model_Tas_Pr_2018_2058 = cell(2058-2018+1,2);
cd(save_path_1)

% 文件夹下面所有的文件
namelist_all = dir([save_path_1,'*.mat']);
name_list = {namelist_all(:).name};

% % 查找索引
% k1 = find(file_ind_1 == 1);
% k2 = find(file_ind_2 == 1);

year_range = nan(length(name_list)/8,2);
for i = 1 : length(name_list)/8
    year_range(i,1) = 2015 + (i-1)*10;
    year_range(i,2) = 2024 + (i-1)*10;
end

% 计算每一年的天数
clear i
day_year_all = nan(length(year_range(1):year_range(end)),1);
for i = 1 : length(day_year_all)
%     day_year_all(i) = leapyear(i + 2014) + 365; % 考虑润平年
    day_year_all(i) = 365; % 不考虑润平年
end

clear i
for i = 1 : length(name_list)/8 % 年份间隔循环
    year_part = [num2str(year_range(i,1)),'_',num2str(year_range(i,2))];
    % 计算相应年份的提取索引
    year_data_index = nan(length(year_range(i,1):year_range(i,2)),2);
    data_year_part = day_year_all(year_range(i,1) - 2014 : year_range(i,2) - 2014);
    for n = year_range(i,1):year_range(i,2)
        year_data_index(n-year_range(i,1)+1,1) = 1 + sum(data_year_part(1 : n - year_range(i,1)));
        year_data_index(n-year_range(i,1)+1,2) = sum(data_year_part(1 : n - year_range(i,1) + 1));
    end
    
    for j = 1 : length(SSP_type) % 未来情景循环
        for m = 1 : length(Data_type) % 数据类型循环
            filename_1 = [model_name{1},'_',Data_type{m},'_',SSP_type{j},'_CN_',year_part,'.mat'];
            load(filename_1)
            
            for year = year_range(i,1) : year_range(i,2)
                Pr_or_Tas_year = Pr_or_Tas(:,:,year_data_index(year - year_range(i,1) + 1,1): year_data_index(year - year_range(i,1) + 1,2));
                filename2 = [model_name{1},'_',Data_type{m},'_',SSP_type{j},'_CN_',num2str(year),'.mat'];
                save([save_path_2,filename2],'Pr_or_Tas_year','Lon_CN','Lat_CN')
                clear filename2 Pr_or_Tas_year
            end
            clear filename_1 Pr_or_Tas
        end
         disp([SSP_type{j},'_',year_part,' is complete!'])
    end
    clear year_data_index data_year_part n year_part
end


%% MPI-ESM1-2-LR 20a ✔ 考虑润平年
clear;clc;
model_name = {'MPI-ESM1-2-LR'};
SSP_type = {'ssp126','ssp245','ssp370','ssp585'};
Data_type = {'pr','tas'};

save_path_1 = ['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2018-2058\1-origin-data\',model_name{1},'\'];
save_path_2 = ['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2018-2058\2-data-by-year\',model_name{1},'\'];
% CMIP6_model_Tas_Pr_2018_2058 = cell(2058-2018+1,2);
cd(save_path_1)

% 文件夹下面所有的文件
namelist_all = dir([save_path_1,'*.mat']);
name_list = {namelist_all(:).name};

% % 查找索引
% k1 = find(file_ind_1 == 1);
% k2 = find(file_ind_2 == 1);

year_range = nan(length(name_list)/8,2);
for i = 1 : length(name_list)/8
    year_range(i,1) = 2015 + (i-1)*20;
    year_range(i,2) = 2034 + (i-1)*20;
end

% 计算每一年的天数
clear i
day_year_all = nan(length(year_range(1):year_range(end)),1);
for i = 1 : length(day_year_all)
    day_year_all(i) = leapyear(i + 2014) + 365; % 考虑润平年
%     day_year_all(i) = 365; % 不考虑润平年
end

clear i
for i = 1 : length(name_list)/8 % 年份间隔循环
    year_part = [num2str(year_range(i,1)),'_',num2str(year_range(i,2))];
    % 计算相应年份的提取索引
    year_data_index = nan(length(year_range(i,1):year_range(i,2)),2);
    data_year_part = day_year_all(year_range(i,1) - 2014 : year_range(i,2) - 2014);
    for n = year_range(i,1):year_range(i,2)
        year_data_index(n-year_range(i,1)+1,1) = 1 + sum(data_year_part(1 : n - year_range(i,1)));
        year_data_index(n-year_range(i,1)+1,2) = sum(data_year_part(1 : n - year_range(i,1) + 1));
    end
    
    for j = 1 : length(SSP_type) % 未来情景循环
        for m = 1 : length(Data_type) % 数据类型循环
            filename_1 = [model_name{1},'_',Data_type{m},'_',SSP_type{j},'_CN_',year_part,'.mat'];
            load(filename_1)
            
            for year = year_range(i,1) : year_range(i,2)
                Pr_or_Tas_year = Pr_or_Tas(:,:,year_data_index(year - year_range(i,1) + 1,1): year_data_index(year - year_range(i,1) + 1,2));
                filename2 = [model_name{1},'_',Data_type{m},'_',SSP_type{j},'_CN_',num2str(year),'.mat'];
                save([save_path_2,filename2],'Pr_or_Tas_year','Lon_CN','Lat_CN')
                clear filename2 Pr_or_Tas_year
            end
            clear filename_1 Pr_or_Tas
        end
         disp([SSP_type{j},'_',year_part,' is complete!'])
    end
    clear year_data_index data_year_part n year_part
end

%% BCC-CSM2-MR 25a ✔ 不考虑润平年
clear;clc;
model_name = {'BCC-CSM2-MR'};
SSP_type = {'ssp126','ssp245','ssp370','ssp585'};
Data_type = {'pr','tas'};

save_path_1 = ['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2018-2058\1-origin-data\',model_name{1},'\'];
save_path_2 = ['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2018-2058\2-data-by-year\',model_name{1},'\'];
% CMIP6_model_Tas_Pr_2018_2058 = cell(2058-2018+1,2);
cd(save_path_1)

% 文件夹下面所有的文件
namelist_all = dir([save_path_1,'*.mat']);
name_list = {namelist_all(:).name};

% % 查找索引
% k1 = find(file_ind_1 == 1);
% k2 = find(file_ind_2 == 1);

year_range = nan(length(name_list)/8,2);
for i = 1 : length(name_list)/8
    year_range(i,1) = 2015 + (i-1)*25;
    year_range(i,2) = 2039 + (i-1)*25;
end

% 计算每一年的天数
clear i
day_year_all = nan(length(year_range(1):year_range(end)),1);
for i = 1 : length(day_year_all)
%     day_year_all(i) = leapyear(i + 2014) + 365; % 考虑润平年
    day_year_all(i) = 365; % 不考虑润平年
end

clear i
for i = 1 : length(name_list)/8 % 年份间隔循环
    year_part = [num2str(year_range(i,1)),'_',num2str(year_range(i,2))];
    % 计算相应年份的提取索引
    year_data_index = nan(length(year_range(i,1):year_range(i,2)),2);
    data_year_part = day_year_all(year_range(i,1) - 2014 : year_range(i,2) - 2014);
    for n = year_range(i,1):year_range(i,2)
        year_data_index(n-year_range(i,1)+1,1) = 1 + sum(data_year_part(1 : n - year_range(i,1)));
        year_data_index(n-year_range(i,1)+1,2) = sum(data_year_part(1 : n - year_range(i,1) + 1));
    end
    
    for j = 1 : length(SSP_type) % 未来情景循环
        for m = 1 : length(Data_type) % 数据类型循环
            filename_1 = [model_name{1},'_',Data_type{m},'_',SSP_type{j},'_CN_',year_part,'.mat'];
            load(filename_1)
            
            for year = year_range(i,1) : year_range(i,2)
                Pr_or_Tas_year = Pr_or_Tas(:,:,year_data_index(year - year_range(i,1) + 1,1): year_data_index(year - year_range(i,1) + 1,2));
                filename2 = [model_name{1},'_',Data_type{m},'_',SSP_type{j},'_CN_',num2str(year),'.mat'];
                save([save_path_2,filename2],'Pr_or_Tas_year','Lon_CN','Lat_CN')
                clear filename2 Pr_or_Tas_year
            end
            clear filename_1 Pr_or_Tas
        end
         disp([SSP_type{j},'_',year_part,' is complete!'])
    end
    clear year_data_index data_year_part n year_part
end

%% MRI-ESM2-0 50a ✔ 考虑润平年
clear;clc;
model_name = {'MRI-ESM2-0'};
SSP_type = {'ssp126','ssp245','ssp370','ssp585'};
Data_type = {'pr','tas'};

save_path_1 = ['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2018-2058\1-origin-data\',model_name{1},'\'];
save_path_2 = ['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2018-2058\2-data-by-year\',model_name{1},'\'];
% CMIP6_model_Tas_Pr_2018_2058 = cell(2058-2018+1,2);
cd(save_path_1)

% 文件夹下面所有的文件
namelist_all = dir([save_path_1,'*.mat']);
name_list = {namelist_all(:).name};

% % 查找索引
% k1 = find(file_ind_1 == 1);
% k2 = find(file_ind_2 == 1);

year_range = nan(length(name_list)/8,2);
for i = 1 : length(name_list)/8
    year_range(i,1) = 2015;
    year_range(i,2) = 2064;
end

% 计算每一年的天数
clear i
day_year_all = nan(length(year_range(1):year_range(end)),1);
for i = 1 : length(day_year_all)
    day_year_all(i) = leapyear(i + 2014) + 365; % 考虑润平年
%     day_year_all(i) = 365; % 不考虑润平年
end

clear i
for i = 1 : length(name_list)/8 % 年份间隔循环
    year_part = [num2str(year_range(i,1)),'_',num2str(year_range(i,2))];
    % 计算相应年份的提取索引
    year_data_index = nan(length(year_range(i,1):year_range(i,2)),2);
    data_year_part = day_year_all(year_range(i,1) - 2014 : year_range(i,2) - 2014);
    for n = year_range(i,1):year_range(i,2)
        year_data_index(n-year_range(i,1)+1,1) = 1 + sum(data_year_part(1 : n - year_range(i,1)));
        year_data_index(n-year_range(i,1)+1,2) = sum(data_year_part(1 : n - year_range(i,1) + 1));
    end
    
    for j = 1 : length(SSP_type) % 未来情景循环
        for m = 1 : length(Data_type) % 数据类型循环
            filename_1 = [model_name{1},'_',Data_type{m},'_',SSP_type{j},'_CN_',year_part,'.mat'];
            load(filename_1)
            
            for year = year_range(i,1) : year_range(i,2)
                Pr_or_Tas_year = Pr_or_Tas(:,:,year_data_index(year - year_range(i,1) + 1,1): year_data_index(year - year_range(i,1) + 1,2));
                filename2 = [model_name{1},'_',Data_type{m},'_',SSP_type{j},'_CN_',num2str(year),'.mat'];
                save([save_path_2,filename2],'Pr_or_Tas_year','Lon_CN','Lat_CN')
                clear filename2 Pr_or_Tas_year
            end
            clear filename_1 Pr_or_Tas
        end
         disp([SSP_type{j},'_',year_part,' is complete!'])
    end
    clear year_data_index data_year_part n year_part
end


%% CanESM5 100a ✔ 不考虑润平年
clear;clc;
model_name = {'CanESM5'};
SSP_type = {'ssp126','ssp245','ssp370','ssp585'};
Data_type = {'pr','tas'};

save_path_1 = ['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2018-2058\1-origin-data\',model_name{1},'\'];
save_path_2 = ['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2018-2058\2-data-by-year\',model_name{1},'\'];
% CMIP6_model_Tas_Pr_2018_2058 = cell(2058-2018+1,2);
cd(save_path_1)

% 文件夹下面所有的文件
namelist_all = dir([save_path_1,'*.mat']);
name_list = {namelist_all(:).name};

% % 查找索引
% k1 = find(file_ind_1 == 1);
% k2 = find(file_ind_2 == 1);

year_range = nan(length(name_list)/8,2);
for i = 1 : length(name_list)/8
    year_range(i,1) = 2015;
    year_range(i,2) = 2100;
end

% 计算每一年的天数
clear i
day_year_all = nan(length(year_range(1):year_range(end)),1);
for i = 1 : length(day_year_all)
%     day_year_all(i) = leapyear(i + 2014) + 365; % 考虑润平年
    day_year_all(i) = 365; % 不考虑润平年
end

clear i
for i = 1 : length(name_list)/8 % 年份间隔循环
    year_part = [num2str(year_range(i,1)),'_',num2str(year_range(i,2))];
    % 计算相应年份的提取索引
    year_data_index = nan(length(year_range(i,1):year_range(i,2)),2);
    data_year_part = day_year_all(year_range(i,1) - 2014 : year_range(i,2) - 2014);
    for n = year_range(i,1):year_range(i,2)
        year_data_index(n-year_range(i,1)+1,1) = 1 + sum(data_year_part(1 : n - year_range(i,1)));
        year_data_index(n-year_range(i,1)+1,2) = sum(data_year_part(1 : n - year_range(i,1) + 1));
    end
    
    for j = 1 : length(SSP_type) % 未来情景循环
        for m = 1 : length(Data_type) % 数据类型循环
            filename_1 = [model_name{1},'_',Data_type{m},'_',SSP_type{j},'_CN_',year_part,'.mat'];
            load(filename_1)
            
            for year = year_range(i,1) : year_range(i,2)
                Pr_or_Tas_year = Pr_or_Tas(:,:,year_data_index(year - year_range(i,1) + 1,1): year_data_index(year - year_range(i,1) + 1,2));
                filename2 = [model_name{1},'_',Data_type{m},'_',SSP_type{j},'_CN_',num2str(year),'.mat'];
                save([save_path_2,filename2],'Pr_or_Tas_year','Lon_CN','Lat_CN')
                clear filename2 Pr_or_Tas_year
            end
            clear filename_1 Pr_or_Tas
        end
         disp([SSP_type{j},'_',year_part,' is complete!'])
    end
    clear year_data_index data_year_part n year_part
end

%% 根据逐年数据，统一为cell格式进行存储
%% 并且获取的时间长度限定为2018-2058年
clear;clc
model_name = {'MPI-ESM1-2-HR','IITM-ESM','NorESM2-LM','NorESM2-MM','MIROC6','TaiESM1','MPI-ESM1-2-LR','BCC-CSM2-MR','MRI-ESM2-0','CanESM5'};
SSP_type = {'ssp126','ssp245','ssp370','ssp585'};
Data_type = {'pr','tas'};


for i = 1 : length(model_name) % 选择模式读取数据
    save_peth_1 = ['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2018-2058\2-data-by-year\',model_name{i},'\'];
    cd(save_peth_1)
    for j = 1 : length(SSP_type)
        CMIP6_model_Pr_Tas_2018_2058 = cell(2058-2018+1,2);
        for year = 2018:2058
            for m = 1 : length(Data_type)
                filename_1 = [model_name{i},'_',Data_type{m},'_',SSP_type{j},'_CN_',num2str(year),'.mat'];
                load(filename_1)
                % 去除填充值
                Pr_or_Tas_year(Pr_or_Tas_year>1*10^19) = nan;
                % 单位转换
                if m == 1 % 降水转mm/day
                    Pr_or_Tas_year = Pr_or_Tas_year .* (24*3600);
                else % 温度转摄氏度
                    Pr_or_Tas_year = Pr_or_Tas_year - 273.15;
                end
                CMIP6_model_Pr_Tas_2018_2058{year - 2017,m} = Pr_or_Tas_year;
                clear filename_1 Pr_or_Tas_year
            end
        end
        filename2 = [model_name{i},'_',SSP_type{j},'_CN_2018_2058.mat'];
        save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2018-2058\3-process-cell-data\',filename2],'CMIP6_model_Pr_Tas_2018_2058','Lon_CN','Lat_CN')
         disp([model_name{i},'_',SSP_type{j},' is complete!'])
        clear CMIP6_model_Pr_Tas_2018_2058 Lon_CN Lat_CN filename2
    end
end
