%% 这个文件根据初步提取出来的历史时期数据进一步的处理
%% 包括单位的转换，润平年问题，统一存储为cell格式
%% 首先将数据进行逐年存储

%% MPI-ESM1-2-HR 5a ✔ 考虑润平年

clear;clc;
model_name = {'MPI-ESM1-2-HR'};
Data_type = {'pr','tas'};

save_path_1 = ['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2018-2058\7-history-pr\',model_name{1},'\'];
save_path_2 = ['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2018-2058\7-2-history-pr-by-year\',model_name{1},'\'];

cd(save_path_1)

% 文件夹下面所有的文件
namelist_all = dir([save_path_1,'*.mat']);
name_list = {namelist_all(:).name};

year_range = nan(length(name_list),2);
for i = 1 : length(name_list)
    year_range(i,1) = 1975 + (i-1)*5;
    year_range(i,2) = 1979 + (i-1)*5;
end

% 计算每一年的天数
clear i
day_year_all = nan(length(year_range(1):year_range(end)),1);
year_range_2 = year_range(1):year_range(end);
for i = 1 : length(day_year_all)
    day_year_all(i) = leapyear(year_range_2(i)) + 365; % 考虑润平年
%     day_year_all(i) = 365; % 不考虑润平年
end

clear i
for i = 1 : length(name_list) % 年份间隔循环
    year_part = [num2str(year_range(i,1)),'_',num2str(year_range(i,2))];
    % 计算相应年份的提取索引
    year_data_index = nan(length(year_range(i,1):year_range(i,2)),2);
    data_year_part = day_year_all(year_range(i,1) - year_range(1) + 1 : year_range(i,2) - year_range(1) + 1);
    for n = year_range(i,1):year_range(i,2)
        year_data_index(n-year_range(i,1)+1,1) = 1 + sum(data_year_part(1 : n - year_range(i,1)));
        year_data_index(n-year_range(i,1)+1,2) = sum(data_year_part(1 : n - year_range(i,1) + 1));
    end
    
    filename_1 = [model_name{1},'_historical_pr_CN_',year_part,'.mat'];
    load(filename_1)
    
    for year = year_range(i,1) : year_range(i,2)
        Pr_year = Pr_His(:,:,year_data_index(year - year_range(i,1) + 1,1): year_data_index(year - year_range(i,1) + 1,2));
        filename2 = [model_name{1},'_historical_pr_CN_',num2str(year),'.mat'];
        save([save_path_2,filename2],'Pr_year','Lon_CN','Lat_CN')
        clear filename2 Pr_year
    end
    clear filename_1 Pr_His
    disp([year_part,' is done!'])
end


%% IITM-ESM 5a ✔ 考虑润平年
clear;clc;
model_name = {'IITM-ESM'};

save_path_1 = ['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2018-2058\7-history-pr\',model_name{1},'\'];
save_path_2 = ['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2018-2058\7-2-history-pr-by-year\',model_name{1},'\'];

cd(save_path_1)

% 文件夹下面所有的文件
namelist_all = dir([save_path_1,'*.mat']);
name_list = {namelist_all(:).name};

year_range = nan(length(name_list),2);
for i = 1 : length(name_list)
    year_range(i,1) = 1975 + (i-1)*5;
    year_range(i,2) = 1979 + (i-1)*5;
end

% 计算每一年的天数
clear i
day_year_all = nan(length(year_range(1):year_range(end)),1);
year_range_2 = year_range(1):year_range(end);
for i = 1 : length(day_year_all)
    day_year_all(i) = leapyear(year_range_2(i)) + 365; % 考虑润平年
%     day_year_all(i) = 365; % 不考虑润平年
end

clear i
for i = 1 : length(name_list) % 年份间隔循环
    year_part = [num2str(year_range(i,1)),'_',num2str(year_range(i,2))];
    % 计算相应年份的提取索引
    year_data_index = nan(length(year_range(i,1):year_range(i,2)),2);
    data_year_part = day_year_all(year_range(i,1) - year_range(1) + 1 : year_range(i,2) - year_range(1) + 1);
    for n = year_range(i,1):year_range(i,2)
        year_data_index(n-year_range(i,1)+1,1) = 1 + sum(data_year_part(1 : n - year_range(i,1)));
        year_data_index(n-year_range(i,1)+1,2) = sum(data_year_part(1 : n - year_range(i,1) + 1));
    end
    
    filename_1 = [model_name{1},'_historical_pr_CN_',year_part,'.mat'];
    load(filename_1)
    
    for year = year_range(i,1) : year_range(i,2)
        Pr_year = Pr_His(:,:,year_data_index(year - year_range(i,1) + 1,1): year_data_index(year - year_range(i,1) + 1,2));
        filename2 = [model_name{1},'_historical_pr_CN_',num2str(year),'.mat'];
        save([save_path_2,filename2],'Pr_year','Lon_CN','Lat_CN')
        clear filename2 Pr_year
    end
    clear filename_1 Pr_His
    disp([year_part,' is done!'])
end

%% NorESM2-LM 6a ✔ 不考虑润平年

clear;clc;
model_name = {'NorESM2-LM'};

save_path_1 = ['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2018-2058\7-history-pr\',model_name{1},'\'];
save_path_2 = ['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2018-2058\7-2-history-pr-by-year\',model_name{1},'\'];

cd(save_path_1)

% 文件夹下面所有的文件
namelist_all = dir([save_path_1,'*.mat']);
name_list = {namelist_all(:).name};

year_range = nan(length(name_list),2);
for i = 1 : length(name_list)
   if i == length(name_list)
        year_range(i,1) = 2010;
        year_range(i,2) = 2014;
    else
        year_range(i,1) = 1970 + (i-1)*10;
        year_range(i,2) = 1979 + (i-1)*10;
    end
end

% 计算每一年的天数
clear i
day_year_all = nan(length(year_range(1):year_range(end)),1);
year_range_2 = year_range(1):year_range(end);
for i = 1 : length(day_year_all)
%     day_year_all(i) = leapyear(year_range_2(i)) + 365; % 考虑润平年
    day_year_all(i) = 365; % 不考虑润平年
end

clear i
for i = 1 : length(name_list) % 年份间隔循环
    year_part = [num2str(year_range(i,1)),'_',num2str(year_range(i,2))];
    % 计算相应年份的提取索引
    year_data_index = nan(length(year_range(i,1):year_range(i,2)),2);
    data_year_part = day_year_all(year_range(i,1) - year_range(1) + 1 : year_range(i,2) - year_range(1) + 1);
    for n = year_range(i,1):year_range(i,2)
        year_data_index(n-year_range(i,1)+1,1) = 1 + sum(data_year_part(1 : n - year_range(i,1)));
        year_data_index(n-year_range(i,1)+1,2) = sum(data_year_part(1 : n - year_range(i,1) + 1));
    end
    
    filename_1 = [model_name{1},'_historical_pr_CN_',year_part,'.mat'];
    load(filename_1)
    
    for year = year_range(i,1) : year_range(i,2)
        Pr_year = Pr_His(:,:,year_data_index(year - year_range(i,1) + 1,1): year_data_index(year - year_range(i,1) + 1,2));
        filename2 = [model_name{1},'_historical_pr_CN_',num2str(year),'.mat'];
        save([save_path_2,filename2],'Pr_year','Lon_CN','Lat_CN')
        clear filename2 Pr_year
    end
    clear filename_1 Pr_His
    disp([year_part,' is done!'])
end

%% NorESM2-MM 6a ✔ 不考虑润平年

clear;clc;
model_name = {'NorESM2-MM'};

save_path_1 = ['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2018-2058\7-history-pr\',model_name{1},'\'];
save_path_2 = ['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2018-2058\7-2-history-pr-by-year\',model_name{1},'\'];

cd(save_path_1)

% 文件夹下面所有的文件
namelist_all = dir([save_path_1,'*.mat']);
name_list = {namelist_all(:).name};

year_range = nan(length(name_list),2);
for i = 1 : length(name_list)
   if i == length(name_list)
        year_range(i,1) = 2010;
        year_range(i,2) = 2014;
    else
        year_range(i,1) = 1970 + (i-1)*10;
        year_range(i,2) = 1979 + (i-1)*10;
    end
end

% 计算每一年的天数
clear i
day_year_all = nan(length(year_range(1):year_range(end)),1);
year_range_2 = year_range(1):year_range(end);
for i = 1 : length(day_year_all)
%     day_year_all(i) = leapyear(year_range_2(i)) + 365; % 考虑润平年
    day_year_all(i) = 365; % 不考虑润平年
end

clear i
for i = 1 : length(name_list) % 年份间隔循环
    year_part = [num2str(year_range(i,1)),'_',num2str(year_range(i,2))];
    % 计算相应年份的提取索引
    year_data_index = nan(length(year_range(i,1):year_range(i,2)),2);
    data_year_part = day_year_all(year_range(i,1) - year_range(1) + 1 : year_range(i,2) - year_range(1) + 1);
    for n = year_range(i,1):year_range(i,2)
        year_data_index(n-year_range(i,1)+1,1) = 1 + sum(data_year_part(1 : n - year_range(i,1)));
        year_data_index(n-year_range(i,1)+1,2) = sum(data_year_part(1 : n - year_range(i,1) + 1));
    end
    
    filename_1 = [model_name{1},'_historical_pr_CN_',year_part,'.mat'];
    load(filename_1)
    
    for year = year_range(i,1) : year_range(i,2)
        Pr_year = Pr_His(:,:,year_data_index(year - year_range(i,1) + 1,1): year_data_index(year - year_range(i,1) + 1,2));
        filename2 = [model_name{1},'_historical_pr_CN_',num2str(year),'.mat'];
        save([save_path_2,filename2],'Pr_year','Lon_CN','Lat_CN')
        clear filename2 Pr_year
    end
    clear filename_1 Pr_His
    disp([year_part,' is done!'])
end

%% MIROC6 10a ✔ 考虑润平年

clear;clc;
model_name = {'MIROC6'};

save_path_1 = ['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2018-2058\7-history-pr\',model_name{1},'\'];
save_path_2 = ['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2018-2058\7-2-history-pr-by-year\',model_name{1},'\'];

cd(save_path_1)

% 文件夹下面所有的文件
namelist_all = dir([save_path_1,'*.mat']);
name_list = {namelist_all(:).name};

year_range = nan(length(name_list),2);
for i = 1 : length(name_list)
   if i == length(name_list)
        year_range(i,1) = 2010;
        year_range(i,2) = 2014;
    else
        year_range(i,1) = 1970 + (i-1)*10;
        year_range(i,2) = 1979 + (i-1)*10;
    end
end

% 计算每一年的天数
clear i
day_year_all = nan(length(year_range(1):year_range(end)),1);
year_range_2 = year_range(1):year_range(end);
for i = 1 : length(day_year_all)
    day_year_all(i) = leapyear(year_range_2(i)) + 365; % 考虑润平年
%     day_year_all(i) = 365; % 不考虑润平年
end

clear i
for i = 1 : length(name_list) % 年份间隔循环
    year_part = [num2str(year_range(i,1)),'_',num2str(year_range(i,2))];
    % 计算相应年份的提取索引
    year_data_index = nan(length(year_range(i,1):year_range(i,2)),2);
    data_year_part = day_year_all(year_range(i,1) - year_range(1) + 1 : year_range(i,2) - year_range(1) + 1);
    for n = year_range(i,1):year_range(i,2)
        year_data_index(n-year_range(i,1)+1,1) = 1 + sum(data_year_part(1 : n - year_range(i,1)));
        year_data_index(n-year_range(i,1)+1,2) = sum(data_year_part(1 : n - year_range(i,1) + 1));
    end
    
    filename_1 = [model_name{1},'_historical_pr_CN_',year_part,'.mat'];
    load(filename_1)
    
    for year = year_range(i,1) : year_range(i,2)
        Pr_year = Pr_His(:,:,year_data_index(year - year_range(i,1) + 1,1): year_data_index(year - year_range(i,1) + 1,2));
        filename2 = [model_name{1},'_historical_pr_CN_',num2str(year),'.mat'];
        save([save_path_2,filename2],'Pr_year','Lon_CN','Lat_CN')
        clear filename2 Pr_year
    end
    clear filename_1 Pr_His
    disp([year_part,' is done!'])
end

%% TaiESM1 10a ✔ 不考虑润平年

clear;clc;
model_name = {'TaiESM1'};

save_path_1 = ['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2018-2058\7-history-pr\',model_name{1},'\'];
save_path_2 = ['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2018-2058\7-2-history-pr-by-year\',model_name{1},'\'];

cd(save_path_1)

% 文件夹下面所有的文件
namelist_all = dir([save_path_1,'*.mat']);
name_list = {namelist_all(:).name};

year_range = nan(length(name_list),2);
for i = 1 : length(name_list)
   if i == length(name_list)
        year_range(i,1) = 2010;
        year_range(i,2) = 2014;
    else
        year_range(i,1) = 1970 + (i-1)*10;
        year_range(i,2) = 1979 + (i-1)*10;
    end
end

% 计算每一年的天数
clear i
day_year_all = nan(length(year_range(1):year_range(end)),1);
year_range_2 = year_range(1):year_range(end);
for i = 1 : length(day_year_all)
%     day_year_all(i) = leapyear(year_range_2(i)) + 365; % 考虑润平年
    day_year_all(i) = 365; % 不考虑润平年
end

clear i
for i = 1 : length(name_list) % 年份间隔循环
    year_part = [num2str(year_range(i,1)),'_',num2str(year_range(i,2))];
    % 计算相应年份的提取索引
    year_data_index = nan(length(year_range(i,1):year_range(i,2)),2);
    data_year_part = day_year_all(year_range(i,1) - year_range(1) + 1 : year_range(i,2) - year_range(1) + 1);
    for n = year_range(i,1):year_range(i,2)
        year_data_index(n-year_range(i,1)+1,1) = 1 + sum(data_year_part(1 : n - year_range(i,1)));
        year_data_index(n-year_range(i,1)+1,2) = sum(data_year_part(1 : n - year_range(i,1) + 1));
    end
    
    filename_1 = [model_name{1},'_historical_pr_CN_',year_part,'.mat'];
    load(filename_1)
    
    for year = year_range(i,1) : year_range(i,2)
        Pr_year = Pr_His(:,:,year_data_index(year - year_range(i,1) + 1,1): year_data_index(year - year_range(i,1) + 1,2));
        filename2 = [model_name{1},'_historical_pr_CN_',num2str(year),'.mat'];
        save([save_path_2,filename2],'Pr_year','Lon_CN','Lat_CN')
        clear filename2 Pr_year
    end
    clear filename_1 Pr_His
    disp([year_part,' is done!'])
end

%% MPI-ESM1-2-LR 20a ✔ 考虑润平年

clear;clc;
model_name = {'MPI-ESM1-2-LR'};

save_path_1 = ['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2018-2058\7-history-pr\',model_name{1},'\'];
save_path_2 = ['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2018-2058\7-2-history-pr-by-year\',model_name{1},'\'];

cd(save_path_1)

% 文件夹下面所有的文件
namelist_all = dir([save_path_1,'*.mat']);
name_list = {namelist_all(:).name};

year_range = nan(length(name_list),2);
for i = 1 : length(name_list)
   if i == length(name_list)
        year_range(i,1) = 2010;
        year_range(i,2) = 2014;
    else
        year_range(i,1) = 1970 + (i-1)*20;
        year_range(i,2) = 1989 + (i-1)*20;
    end
end

% 计算每一年的天数
clear i
day_year_all = nan(length(year_range(1):year_range(end)),1);
year_range_2 = year_range(1):year_range(end);
for i = 1 : length(day_year_all)
    day_year_all(i) = leapyear(year_range_2(i)) + 365; % 考虑润平年
%     day_year_all(i) = 365; % 不考虑润平年
end

clear i
for i = 1 : length(name_list) % 年份间隔循环
    year_part = [num2str(year_range(i,1)),'_',num2str(year_range(i,2))];
    % 计算相应年份的提取索引
    year_data_index = nan(length(year_range(i,1):year_range(i,2)),2);
    data_year_part = day_year_all(year_range(i,1) - year_range(1) + 1 : year_range(i,2) - year_range(1) + 1);
    for n = year_range(i,1):year_range(i,2)
        year_data_index(n-year_range(i,1)+1,1) = 1 + sum(data_year_part(1 : n - year_range(i,1)));
        year_data_index(n-year_range(i,1)+1,2) = sum(data_year_part(1 : n - year_range(i,1) + 1));
    end
    
    filename_1 = [model_name{1},'_historical_pr_CN_',year_part,'.mat'];
    load(filename_1)
    
    for year = year_range(i,1) : year_range(i,2)
        Pr_year = Pr_His(:,:,year_data_index(year - year_range(i,1) + 1,1): year_data_index(year - year_range(i,1) + 1,2));
        filename2 = [model_name{1},'_historical_pr_CN_',num2str(year),'.mat'];
        save([save_path_2,filename2],'Pr_year','Lon_CN','Lat_CN')
        clear filename2 Pr_year
    end
    clear filename_1 Pr_His
    disp([year_part,' is done!'])
end

%% BCC-CSM2-MR 25a ✔ 不考虑润平年

clear;clc;
model_name = {'BCC-CSM2-MR'};

save_path_1 = ['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2018-2058\7-history-pr\',model_name{1},'\'];
save_path_2 = ['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2018-2058\7-2-history-pr-by-year\',model_name{1},'\'];

cd(save_path_1)

% 文件夹下面所有的文件
namelist_all = dir([save_path_1,'*.mat']);
name_list = {namelist_all(:).name};

year_range = nan(length(name_list),2);
for i = 1 : length(name_list)
   if i == length(name_list)
        year_range(i,1) = 2000;
        year_range(i,2) = 2014;
    else
        year_range(i,1) = 1975 + (i-1)*25;
        year_range(i,2) = 1999 + (i-1)*25;
    end
end

% 计算每一年的天数
clear i
day_year_all = nan(length(year_range(1):year_range(end)),1);
year_range_2 = year_range(1):year_range(end);
for i = 1 : length(day_year_all)
%     day_year_all(i) = leapyear(year_range_2(i)) + 365; % 考虑润平年
    day_year_all(i) = 365; % 不考虑润平年
end

clear i
for i = 1 : length(name_list) % 年份间隔循环
    year_part = [num2str(year_range(i,1)),'_',num2str(year_range(i,2))];
    % 计算相应年份的提取索引
    year_data_index = nan(length(year_range(i,1):year_range(i,2)),2);
    data_year_part = day_year_all(year_range(i,1) - year_range(1) + 1 : year_range(i,2) - year_range(1) + 1);
    for n = year_range(i,1):year_range(i,2)
        year_data_index(n-year_range(i,1)+1,1) = 1 + sum(data_year_part(1 : n - year_range(i,1)));
        year_data_index(n-year_range(i,1)+1,2) = sum(data_year_part(1 : n - year_range(i,1) + 1));
    end
    
    filename_1 = [model_name{1},'_historical_pr_CN_',year_part,'.mat'];
    load(filename_1)
    
    for year = year_range(i,1) : year_range(i,2)
        Pr_year = Pr_His(:,:,year_data_index(year - year_range(i,1) + 1,1): year_data_index(year - year_range(i,1) + 1,2));
        filename2 = [model_name{1},'_historical_pr_CN_',num2str(year),'.mat'];
        save([save_path_2,filename2],'Pr_year','Lon_CN','Lat_CN')
        clear filename2 Pr_year
    end
    clear filename_1 Pr_His
    disp([year_part,' is done!'])
end

%% MRI-ESM2-0 50a ✔ 考虑润平年

clear;clc;
model_name = {'MRI-ESM2-0'};

save_path_1 = ['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2018-2058\7-history-pr\',model_name{1},'\'];
save_path_2 = ['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2018-2058\7-2-history-pr-by-year\',model_name{1},'\'];

cd(save_path_1)

% 文件夹下面所有的文件
namelist_all = dir([save_path_1,'*.mat']);
name_list = {namelist_all(:).name};

year_range = nan(length(name_list),2);
for i = 1 : length(name_list)
   if i == length(name_list)
        year_range(i,1) = 2000;
        year_range(i,2) = 2014;
    else
        year_range(i,1) = 1950 + (i-1)*50;
        year_range(i,2) = 1999 + (i-1)*50;
    end
end

% 计算每一年的天数
clear i
day_year_all = nan(length(year_range(1):year_range(end)),1);
year_range_2 = year_range(1):year_range(end);
for i = 1 : length(day_year_all)
    day_year_all(i) = leapyear(year_range_2(i)) + 365; % 考虑润平年
%     day_year_all(i) = 365; % 不考虑润平年
end

clear i
for i = 1 : length(name_list) % 年份间隔循环
    year_part = [num2str(year_range(i,1)),'_',num2str(year_range(i,2))];
    % 计算相应年份的提取索引
    year_data_index = nan(length(year_range(i,1):year_range(i,2)),2);
    data_year_part = day_year_all(year_range(i,1) - year_range(1) + 1 : year_range(i,2) - year_range(1) + 1);
    for n = year_range(i,1):year_range(i,2)
        year_data_index(n-year_range(i,1)+1,1) = 1 + sum(data_year_part(1 : n - year_range(i,1)));
        year_data_index(n-year_range(i,1)+1,2) = sum(data_year_part(1 : n - year_range(i,1) + 1));
    end
    
    filename_1 = [model_name{1},'_historical_pr_CN_',year_part,'.mat'];
    load(filename_1)
    
    for year = year_range(i,1) : year_range(i,2)
        Pr_year = Pr_His(:,:,year_data_index(year - year_range(i,1) + 1,1): year_data_index(year - year_range(i,1) + 1,2));
        filename2 = [model_name{1},'_historical_pr_CN_',num2str(year),'.mat'];
        save([save_path_2,filename2],'Pr_year','Lon_CN','Lat_CN')
        clear filename2 Pr_year
    end
    clear filename_1 Pr_His
    disp([year_part,' is done!'])
end

%% CanESM5 100a ✔ 不考虑润平年

clear;clc;
model_name = {'CanESM5'};

save_path_1 = ['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2018-2058\7-history-pr\',model_name{1},'\'];
save_path_2 = ['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2018-2058\7-2-history-pr-by-year\',model_name{1},'\'];

cd(save_path_1)

% 文件夹下面所有的文件
namelist_all = dir([save_path_1,'*.mat']);
name_list = {namelist_all(:).name};

year_range = nan(length(name_list),2);

year_range(1,1) = 1850;
year_range(1,2) = 2014;


% 计算每一年的天数
clear i
day_year_all = nan(length(year_range(1):year_range(end)),1);
year_range_2 = year_range(1):year_range(end);
for i = 1 : length(day_year_all)
%     day_year_all(i) = leapyear(year_range_2(i)) + 365; % 考虑润平年
    day_year_all(i) = 365; % 不考虑润平年
end

clear i
for i = 1 : length(name_list) % 年份间隔循环
    year_part = [num2str(year_range(i,1)),'_',num2str(year_range(i,2))];
    % 计算相应年份的提取索引
    year_data_index = nan(length(year_range(i,1):year_range(i,2)),2);
    data_year_part = day_year_all(year_range(i,1) - year_range(1) + 1 : year_range(i,2) - year_range(1) + 1);
    for n = year_range(i,1):year_range(i,2)
        year_data_index(n-year_range(i,1)+1,1) = 1 + sum(data_year_part(1 : n - year_range(i,1)));
        year_data_index(n-year_range(i,1)+1,2) = sum(data_year_part(1 : n - year_range(i,1) + 1));
    end
    
    filename_1 = [model_name{1},'_historical_pr_CN_',year_part,'.mat'];
    load(filename_1)
    
    for year = year_range(i,1) : year_range(i,2)
        Pr_year = Pr_His(:,:,year_data_index(year - year_range(i,1) + 1,1): year_data_index(year - year_range(i,1) + 1,2));
        filename2 = [model_name{1},'_historical_pr_CN_',num2str(year),'.mat'];
        save([save_path_2,filename2],'Pr_year','Lon_CN','Lat_CN')
        clear filename2 Pr_year
    end
    clear filename_1 Pr_His
    disp([year_part,' is done!'])
end

%% 根据逐年数据，统一为cell格式进行存储
%% 时间长度选定为1975-2014

clear;clc
model_name = {'MPI-ESM1-2-HR','IITM-ESM','NorESM2-LM','NorESM2-MM','MIROC6','TaiESM1','MPI-ESM1-2-LR','BCC-CSM2-MR','MRI-ESM2-0','CanESM5'};

for i = 1 : length(model_name) % 选择模式读取数据
    save_path_1 = ['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2018-2058\7-2-history-pr-by-year\',model_name{i},'\'];
    cd(save_path_1)
    CMIP6_model_HisPr_1975_2014 = cell(2014-1975+1,1);
    for year = 1975:2014
        filename_1 = [model_name{i},'_historical_pr_CN_',num2str(year),'.mat'];
        load(filename_1)
        % 去除填充值
        Pr_year(Pr_year>1*10^19) = nan;
        % 单位转换
        % 降水转mm/day
        Pr_year = Pr_year .* (24*3600);
        
        CMIP6_model_HisPr_1975_2014{year - 1974,1} = Pr_year;
        clear filename_1 Pr_year
    end
    filename2 = [model_name{i},'_CN_1975_2014.mat'];
    save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2018-2058\7-3-history-pr-process-cell-data\',filename2],'CMIP6_model_HisPr_1975_2014','Lon_CN','Lat_CN')
    disp([model_name{i},' is complete!'])
    clear CMIP6_model_HisPr_1975_2014 Lon_CN Lat_CN filename2
end
