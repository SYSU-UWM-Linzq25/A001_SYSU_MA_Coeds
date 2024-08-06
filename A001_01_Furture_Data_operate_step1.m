%% 这个文件首先对CMIP6的未来数据进行处理
%% 由于杜师兄评价的是多年平均降水以及年际变率，可能不是很适合降水集中度
% 这里全部改成2015-2100年了

clear;clc

% 由于空间有限，先查看并提取一部分的模型数据

% 符合条件的模式
% 提取降水数据和温度数据
CMIP6_model_name = {'CMCC-CM2-SR5','CMCC-ESM2','EC-Earth3','IITM-ESM','INM-CM4-8',...
    'INM-CM5-0','MIROC6','MPI-ESM1-2-HR','MPI-ESM1-2-LR',...
    'MRI-ESM2-0','NorESM2-LM','NorESM2-MM','TaiESM1'};

%% 由于不同模式存储数据的方式不同，所以分开进行读取存储
% %% EC-Earth3 也是逐年存储的,2033年文件出错
% clear;clc
% SSP_type = {'SSP126','SSP245','SSP370','SSP585'};
% Data_type = {'pr','tas'};
% 
% % 读取CMFD的经纬度网格情况，从而提取中国地区的范围
% load('F:\File_of_MATLAB\关于3h尺度的CMFD降水数据研究2022.3.2\Data\LLT.mat')
% 
% for j = 1 : length(SSP_type)
%     CMIP6_model_Tas_Pr_2018_2058 = cell(2058-2018+1,2);
%     for m = 1 : length(Data_type)
%         save_path_1 = ['J:\2-Data\1-Precpitation Data\3-CMIP6\EC-Earth3\',SSP_type{j},'-',Data_type{m},'\'];
%         namelist_all = dir([save_path_1,'*.nc']);
%         name_list = {namelist_all(:).name}'; % 读取其中第二个数据，数据范围从2065-2100
%         file_ind_1 = contains(name_list,'2018'); % 包含2018年的文件名
%         file_ind_2 = contains(name_list,'2058'); % 包含2058年的文件名
%         % 查找索引
%         k1 = find(file_ind_1 == 1);
%         k2 = find(file_ind_2 == 1);
%         % 打开对应文件夹
%         cd(save_path_1)
%         % 读取经纬度和时间
%         Lon = ncread(name_list{k1},'lon');
%         Lat = ncread(name_list{k1},'lat');
%         time = ncread(name_list{k1},'time');
%         % 查找中国地区的经纬度范围，从而缩小提取数据大小
%         a = find(Lon(:) >= min(Lon_3h_scale) & Lon(:)<= max(Lon_3h_scale));%经度的指针
%         b = find(Lat(:) >= min(Lat_3h_scale) & Lat(:)<= max(Lat_3h_scale));%纬度的指针
%         Lon_CN = Lon(a);
%         Lat_CN = Lat(b);
%         year_index = 1;
%         for i = k1 : k2
%             Pr_or_Tas = ncread(name_list{i},Data_type{m},[1 1 1],[length(a) length(b) length(time)]);
%             CMIP6_model_Tas_Pr_2018_2058{year_index,m} = Pr_or_Tas;
%             year_index = year_index + 1;
%             clear Pr_or_Tas
%         end
%         clear Lon_CN Lat_CN a b Lon Lat time file_ind name_list namelist_all save_path_1 k1 k2 year_index
%     end
%     filename = ['EC-Earth3_',SSP_type{j},'_CN_2018_2058.mat'];
%     save(['F:\File_of_MATLAB\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2018-2058\',filename],'CMIP6_model_Tas_Pr_2018_2058','Lon_CN','Lat_CN')
%     disp(['SSP',SSP_type{j},' is complete!'])
% end

%% MPI-ESM1-2-HR 5年存一个数据
%% 考虑润平年
%% 这里分成两部分处理，首先从原始数据中提取中国地区，仍以5年的时间存储
% SSP370 tas 没有2100年数据
clear;clc
SSP_type = {'ssp126','ssp245','ssp370','ssp585'};
Data_type = {'pr','tas'};

% 读取CMFD的经纬度网格情况，从而提取中国地区的范围
load('F:\File_of_MATLAB\关于3h尺度的CMFD降水数据研究2022.3.2\Data\LLT.mat')

for j = 3 %: length(SSP_type)
%     CMIP6_model_Tas_Pr_2018_2058 = cell(2058-2018+1,2);
    for m = 2 %: length(Data_type)
        save_path_1 = ['Z:\CMIP6_WRCP_daily\MPI-ESM1-2-HR\',SSP_type{j},'-',Data_type{m},'\'];
        namelist_all = dir([save_path_1,'*.nc']);
        name_list = {namelist_all(:).name};
        
        file_ind_1 = contains(name_list,'2015'); % 包含2018年的文件名
        file_ind_2 = contains(name_list,'2099'); % 包含2100年的文件名
        % 查找索引
        k1 = find(file_ind_1 == 1);
        k2 = find(file_ind_2 == 1);
        
        year_range = nan(length(k1:k2),2);
        for i = k1 : k2
            year_range(i-k1+1,1) = 2015 + (i-k1)*5;
            year_range(i-k1+1,2) = 2019 + (i-k1)*5;
            if i == k2 % 最后一年
                year_range(i-k1+1,2) = 2099;
            else
                year_range(i-k1+1,2) = 2019 + (i-k1)*5;
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
        
        %         info1 = ncinfo(name_list{k1});
        %         info2 = ncinfo(name_list{k1+1});
        year_index = 1;
        for i = k1 : k2
            time = ncread(name_list{i},'time');
            Pr_or_Tas = ncread(name_list{i},Data_type{m},[a(1) b(1) 1],[length(a) length(b) length(time)]);
            filename = ['MPI-ESM1-2-HR_',Data_type{m},'_',SSP_type{j},'_CN_',num2str(year_range(i-k1+1,1)),'_',num2str(year_range(i-k1+1,2)),'.mat'];
            save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\1-origin-data\MPI-ESM1-2-HR\',filename],'Pr_or_Tas','Lon_CN','Lat_CN')
            clear Pr_or_Tas
        end
        clear a b Lon Lat time file_ind name_list namelist_all save_path_1 k1 k2 year_index
    end
    disp([SSP_type{j},' is complete!'])
    clear Lon_CN Lat_CN 
end

%% IITM-ESM 5年存一个数据
%% 考虑润平年
%% 这里分成两部分处理，首先从原始数据中提取中国地区，仍以5年的时间存储
clear;clc
SSP_type = {'ssp126','ssp245','ssp370','ssp585'};
Data_type = {'pr','tas'};

% 读取CMFD的经纬度网格情况，从而提取中国地区的范围
load('F:\File_of_MATLAB\关于3h尺度的CMFD降水数据研究2022.3.2\Data\LLT.mat')

for j = 1 : length(SSP_type)
%     CMIP6_model_Tas_Pr_2018_2058 = cell(2058-2018+1,2);
    for m = 1 : length(Data_type)
        save_path_1 = ['Z:\CMIP6_WRCP_daily\IITM-ESM\',SSP_type{j},'-',Data_type{m},'\'];
        namelist_all = dir([save_path_1,'*.nc']);
        name_list = {namelist_all(:).name};
        
        file_ind_1 = contains(name_list,'2015'); % 包含2018年的文件名
        file_ind_2 = contains(name_list,'2099'); % 包含2100年的文件名
        % 查找索引
        k1 = find(file_ind_1 == 1);
        k2 = find(file_ind_2 == 1);
        
        year_range = nan(length(k1:k2),2);
        for i = k1 : k2
            year_range(i-k1+1,1) = 2015 + (i-k1)*5;
            year_range(i-k1+1,2) = 2019 + (i-k1)*5;
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
        
        %         info1 = ncinfo(name_list{k1});
        %         info2 = ncinfo(name_list{k1+1});
        year_index = 1;
        for i = k1 : k2
            time = ncread(name_list{i},'time');
            Pr_or_Tas = ncread(name_list{i},Data_type{m},[a(1) b(1) 1],[length(a) length(b) length(time)]);
            filename = ['IITM-ESM_',Data_type{m},'_',SSP_type{j},'_CN_',num2str(year_range(i-k1+1,1)),'_',num2str(year_range(i-k1+1,2)),'.mat'];
            save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\1-origin-data\IITM-ESM\',filename],'Pr_or_Tas','Lon_CN','Lat_CN')
            clear Pr_or_Tas
        end
        clear a b Lon Lat time file_ind name_list namelist_all save_path_1 k1 k2 year_index
    end
    disp([SSP_type{j},' is complete!'])
    clear Lon_CN Lat_CN 
end


%% NorESM2-LM 6年存一个数据
%% 不区分润平年
%% 这里分成两部分处理，首先从原始数据中提取中国地区，仍以6年的时间存储
clear;clc
SSP_type = {'ssp126','ssp245','ssp370','ssp585'};
Data_type = {'pr','tas'};

% 读取CMFD的经纬度网格情况，从而提取中国地区的范围
load('F:\File_of_MATLAB\关于3h尺度的CMFD降水数据研究2022.3.2\Data\LLT.mat')

for j = 1 : length(SSP_type)
%     CMIP6_model_Tas_Pr_2018_2058 = cell(2058-2018+1,2);
    for m = 1 : length(Data_type)
        save_path_1 = ['Z:\CMIP6_WRCP_daily\NorESM2-LM\',SSP_type{j},'-',Data_type{m},'\'];
        namelist_all = dir([save_path_1,'*.nc']);
        name_list = {namelist_all(:).name};
        
        file_ind_1 = contains(name_list,'2015'); % 包含2018年的文件名
        file_ind_2 = contains(name_list,'2100'); % 包含2058年的文件名
        % 查找索引
        k1 = find(file_ind_1 == 1);
        k2 = find(file_ind_2 == 1);
        
        year_range = nan(length(k1:k2),2);
        for i = k1 : k2
            if i == k1 % 第一个文件从2015-2020年
                year_range(i-k1+1,1) = 2015;
                year_range(i-k1+1,2) = 2020;
            else
                year_range(i-k1+1,1) = 2021 + (i-k1-1)*10;
                year_range(i-k1+1,2) = 2030 + (i-k1-1)*10;
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
        
        %         info1 = ncinfo(name_list{k1});
        %         info2 = ncinfo(name_list{k1+1});
        year_index = 1;
        for i = k1 : k2
            time = ncread(name_list{i},'time');
            Pr_or_Tas = ncread(name_list{i},Data_type{m},[a(1) b(1) 1],[length(a) length(b) length(time)]);
            filename = ['NorESM2-LM_',Data_type{m},'_',SSP_type{j},'_CN_',num2str(year_range(i-k1+1,1)),'_',num2str(year_range(i-k1+1,2)),'.mat'];
            save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\1-origin-data\NorESM2-LM\',filename],'Pr_or_Tas','Lon_CN','Lat_CN')
            clear Pr_or_Tas
        end
        clear a b Lon Lat time file_ind name_list namelist_all save_path_1 k1 k2 year_index
    end
    disp([SSP_type{j},' is complete!'])
    clear Lon_CN Lat_CN 
end

%% NorESM2-MM 6年存一个数据
%% 不区分润平年
%% 这里分成两部分处理，首先从原始数据中提取中国地区，仍以6年的时间存储
clear;clc
SSP_type = {'ssp126','ssp245','ssp370','ssp585'};
Data_type = {'pr','tas'};

% 读取CMFD的经纬度网格情况，从而提取中国地区的范围
load('F:\File_of_MATLAB\关于3h尺度的CMFD降水数据研究2022.3.2\Data\LLT.mat')

for j = 1 : length(SSP_type)
%     CMIP6_model_Tas_Pr_2018_2058 = cell(2058-2018+1,2);
    for m = 1 : length(Data_type)
        save_path_1 = ['Z:\CMIP6_WRCP_daily\NorESM2-MM\',SSP_type{j},'-',Data_type{m},'\'];
        namelist_all = dir([save_path_1,'*.nc']);
        name_list = {namelist_all(:).name};
        
        file_ind_1 = contains(name_list,'2015'); % 包含2015年的文件名
        file_ind_2 = contains(name_list,'2100'); % 包含2100年的文件名
        % 查找索引
        k1 = find(file_ind_1 == 1);
        k2 = find(file_ind_2 == 1);
        
        year_range = nan(length(k1:k2),2);
        for i = k1 : k2
            if i == k1 % 第一个文件从2015-2020年
                year_range(i-k1+1,1) = 2015;
                year_range(i-k1+1,2) = 2020;
            else
                year_range(i-k1+1,1) = 2021 + (i-k1-1)*10;
                year_range(i-k1+1,2) = 2030 + (i-k1-1)*10;
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
        
        %         info1 = ncinfo(name_list{k1});
        %         info2 = ncinfo(name_list{k1+1});
        year_index = 1;
        for i = k1 : k2
            time = ncread(name_list{i},'time');
            Pr_or_Tas = ncread(name_list{i},Data_type{m},[a(1) b(1) 1],[length(a) length(b) length(time)]);
            filename = ['NorESM2-MM_',Data_type{m},'_',SSP_type{j},'_CN_',num2str(year_range(i-k1+1,1)),'_',num2str(year_range(i-k1+1,2)),'.mat'];
            save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\1-origin-data\NorESM2-MM\',filename],'Pr_or_Tas','Lon_CN','Lat_CN')
            clear Pr_or_Tas
        end
        clear a b Lon Lat time file_ind name_list namelist_all save_path_1 k1 k2 year_index
    end
    disp([SSP_type{j},' is complete!'])
    clear Lon_CN Lat_CN 
end


%% MIROC6 10年存一个数据
%% 并且区分润平年
%% 这里分成两部分处理，首先从原始数据中提取中国地区，仍以10年的时间存储
clear;clc
SSP_type = {'ssp126','ssp245','ssp370','ssp585'};
Data_type = {'pr','tas'};

% 读取CMFD的经纬度网格情况，从而提取中国地区的范围
load('F:\File_of_MATLAB\关于3h尺度的CMFD降水数据研究2022.3.2\Data\LLT.mat')

for j = 1 : length(SSP_type)
%     CMIP6_model_Tas_Pr_2018_2058 = cell(2058-2018+1,2);
    for m = 1 : length(Data_type)
        save_path_1 = ['Z:\CMIP6_WRCP_daily\MIROC6\',SSP_type{j},'-',Data_type{m},'\'];
        namelist_all = dir([save_path_1,'*.nc']);
        name_list = {namelist_all(:).name};
        
        file_ind_1 = contains(name_list,'2015'); % 包含2018年的文件名
        file_ind_2 = contains(name_list,'2100'); % 包含2100年的文件名
        % 查找索引
        k1 = find(file_ind_1 == 1);
        k2 = find(file_ind_2 == 1);
        
        year_range = nan(length(k1:k2),2);
        for i = k1 : k2
            year_range(i-k1+1,1) = 2015 + (i-k1)*10;
            if i == k2 % 最后一年
                year_range(i-k1+1,2) = 2100;
            else
                year_range(i-k1+1,2) = 2024 + (i-k1)*10;
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
        
        %         info1 = ncinfo(name_list{k1});
        %         info2 = ncinfo(name_list{k1+1});
        year_index = 1;
        for i = k1 : k2
            time = ncread(name_list{i},'time');
            Pr_or_Tas = ncread(name_list{i},Data_type{m},[a(1) b(1) 1],[length(a) length(b) length(time)]);
            filename = ['MIROC6_',Data_type{m},'_',SSP_type{j},'_CN_',num2str(year_range(i-k1+1,1)),'_',num2str(year_range(i-k1+1,2)),'.mat'];
            save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\1-origin-data\MIROC6\',filename],'Pr_or_Tas','Lon_CN','Lat_CN')
            clear Pr_or_Tas
        end
        clear a b Lon Lat time file_ind name_list namelist_all save_path_1 k1 k2 year_index
    end
    disp([SSP_type{j},' is complete!'])
    clear Lon_CN Lat_CN 
end

%% TaiESM1  10年存一个数据
%% 不考虑润平年
%% 这里分成两部分处理，首先从原始数据中提取中国地区，仍以10年的时间存储
clear;clc
SSP_type = {'ssp126','ssp245','ssp370','ssp585'};
Data_type = {'pr','tas'};

% 读取CMFD的经纬度网格情况，从而提取中国地区的范围
load('F:\File_of_MATLAB\关于3h尺度的CMFD降水数据研究2022.3.2\Data\LLT.mat')

for j = 1 : length(SSP_type)
%     CMIP6_model_Tas_Pr_2018_2058 = cell(2058-2018+1,2);
    for m = 1 : length(Data_type)
        save_path_1 = ['Z:\CMIP6_WRCP_daily\TaiESM1\',SSP_type{j},'-',Data_type{m},'\'];
        namelist_all = dir([save_path_1,'*.nc']);
        name_list = {namelist_all(:).name};
        
        file_ind_1 = contains(name_list,'2015'); % 包含2015年的文件名
        file_ind_2 = contains(name_list,'2100'); % 包含2100年的文件名
        % 查找索引
        k1 = find(file_ind_1 == 1);
        k2 = find(file_ind_2 == 1);
        
        year_range = nan(length(k1:k2),2);
        for i = k1 : k2
            year_range(i-k1+1,1) = 2015 + (i-k1)*10;
            if i == k2
                year_range(i-k1+1,2) = 2100;
            else
                year_range(i-k1+1,2) = 2024 + (i-k1)*10;
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
        
        %         info1 = ncinfo(name_list{k1});
        %         info2 = ncinfo(name_list{k1+1});
        year_index = 1;
        for i = k1 : k2
            time = ncread(name_list{i},'time');
            Pr_or_Tas = ncread(name_list{i},Data_type{m},[a(1) b(1) 1],[length(a) length(b) length(time)]);
            filename = ['TaiESM1_',Data_type{m},'_',SSP_type{j},'_CN_',num2str(year_range(i-k1+1,1)),'_',num2str(year_range(i-k1+1,2)),'.mat'];
            save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\1-origin-data\TaiESM1\',filename],'Pr_or_Tas','Lon_CN','Lat_CN')
            clear Pr_or_Tas
        end
        clear a b Lon Lat time file_ind name_list namelist_all save_path_1 k1 k2 year_index
    end
    disp([SSP_type{j},' is complete!'])
    clear Lon_CN Lat_CN 
end

%% CESM2-WACCM 10年存一个数据
%% SSP370 降水 ssp370-pr-2015-2024文件报错
% clear;clc
% SSP_type = {'ssp126','ssp245','ssp370','ssp585'};
% Data_type = {'pr','tas'};
% 
% % 读取CMFD的经纬度网格情况，从而提取中国地区的范围
% load('F:\File_of_MATLAB\关于3h尺度的CMFD降水数据研究2022.3.2\Data\LLT.mat')
% 
% for j = 1 : length(SSP_type)
% %     CMIP6_model_Tas_Pr_2018_2058 = cell(2058-2018+1,2);
%     for m = 1 : length(Data_type)
%         save_path_1 = ['Z:\CMIP6_WRCP_daily\CESM2-WACCM\',SSP_type{j},'-',Data_type{m},'\'];
%         namelist_all = dir([save_path_1,'*.nc']);
%         name_list = {namelist_all(:).name};
%         
%         file_ind_1 = contains(name_list,'2015'); % 包含2018年的文件名
%         file_ind_2 = contains(name_list,'2055'); % 包含2058年的文件名
%         % 查找索引
%         k1 = find(file_ind_1 == 1);
%         k2 = find(file_ind_2 == 1);
%         
%         year_range = nan(length(k1:k2),2);
%         for i = k1 : k2
%             year_range(i-k1+1,1) = 2015 + (i-k1)*10;
%             year_range(i-k1+1,2) = 2024 + (i-k1)*10;
%         end
%         
%         % 打开对应文件夹
%         cd(save_path_1)
%         % 读取经纬度和时间
%         Lon = ncread(name_list{k1},'lon');
%         Lat = ncread(name_list{k1},'lat');
%         % 查找中国地区的经纬度范围，从而缩小提取数据大小
%         a = find(Lon(:) >= min(Lon_3h_scale) & Lon(:)<= max(Lon_3h_scale));%经度的指针
%         b = find(Lat(:) >= min(Lat_3h_scale) & Lat(:)<= max(Lat_3h_scale));%纬度的指针
%         Lon_CN = Lon(a);
%         Lat_CN = Lat(b);
%         
%         %         info1 = ncinfo(name_list{k1});
%         %         info2 = ncinfo(name_list{k1+1});
%         year_index = 1;
%         for i = k1 : k2
%             time = ncread(name_list{i},'time');
%             Pr_or_Tas = ncread(name_list{i},Data_type{m},[1 1 1],[length(a) length(b) length(time)]);
%             filename = ['CESM2-WACCM_',Data_type{m},'_',SSP_type{j},'_CN_',num2str(year_range(i-k1+1,1)),'_',num2str(year_range(i-k1+1,2)),'.mat'];
%             save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2018-2058\1-origin-data\',filename],'Pr_or_Tas','Lon_CN','Lat_CN')
%             clear Pr_or_Tas
%         end
%         clear a b Lon Lat time file_ind name_list namelist_all save_path_1 k1 k2 year_index
%     end
%     disp([SSP_type{j},' is complete!'])
%     clear Lon_CN Lat_CN 
% end

%% MPI-ESM1-2-LR 20a存储一个数据
%% 考虑润平年
clear;clc
SSP_type = {'ssp126','ssp245','ssp370','ssp585'};
Data_type = {'pr','tas'};

% 读取CMFD的经纬度网格情况，从而提取中国地区的范围
load('F:\File_of_MATLAB\关于3h尺度的CMFD降水数据研究2022.3.2\Data\LLT.mat')

for j = 1 : length(SSP_type)
%     CMIP6_model_Tas_Pr_2018_2058 = cell(2058-2018+1,2);
    for m = 1 : length(Data_type)
        save_path_1 = ['Z:\CMIP6_WRCP_daily\MPI-ESM1-2-LR\',SSP_type{j},'-',Data_type{m},'\'];
        namelist_all = dir([save_path_1,'*.nc']);
        name_list = {namelist_all(:).name};
        
        file_ind_1 = contains(name_list,'2015'); % 包含2015年的文件名
        file_ind_2 = contains(name_list,'2100'); % 包含2100年的文件名
        % 查找索引
        k1 = find(file_ind_1 == 1);
        k2 = find(file_ind_2 == 1);
        
        year_range = nan(length(k1:k2),2);
        for i = k1 : k2
            year_range(i-k1+1,1) = 2015 + (i-k1)*20;
            if i == k2 % 最后一年
                year_range(i-k1+1,2) = 2100;
            else
                year_range(i-k1+1,2) = 2034 + (i-k1)*20;
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
        
        %         info1 = ncinfo(name_list{k1});
        %         info2 = ncinfo(name_list{k1+1});
        year_index = 1;
        for i = k1 : k2
            time = ncread(name_list{i},'time');
            Pr_or_Tas = ncread(name_list{i},Data_type{m},[a(1) b(1) 1],[length(a) length(b) length(time)]);
            filename = ['MPI-ESM1-2-LR_',Data_type{m},'_',SSP_type{j},'_CN_',num2str(year_range(i-k1+1,1)),'_',num2str(year_range(i-k1+1,2)),'.mat'];
            save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\1-origin-data\MPI-ESM1-2-LR\',filename],'Pr_or_Tas','Lon_CN','Lat_CN')
            clear Pr_or_Tas
        end
        clear a b Lon Lat time file_ind name_list namelist_all save_path_1 k1 k2 year_index
    end
    disp([SSP_type{j},' is complete!'])
    clear Lon_CN Lat_CN 
end


%% BCC-CSM2-MR 25a存储一个数据
%% 不考虑润平年
clear;clc
SSP_type = {'ssp126','ssp245','ssp370','ssp585'};
Data_type = {'pr','tas'};

% 读取CMFD的经纬度网格情况，从而提取中国地区的范围
load('F:\File_of_MATLAB\关于3h尺度的CMFD降水数据研究2022.3.2\Data\LLT.mat')

for j = 1 : length(SSP_type)
%     CMIP6_model_Tas_Pr_2018_2058 = cell(2058-2018+1,2);
    for m = 1 : length(Data_type)
        save_path_1 = ['Z:\CMIP6_WRCP_daily\BCC-CSM2-MR\',SSP_type{j},'-',Data_type{m},'\'];
        namelist_all = dir([save_path_1,'*.nc']);
        name_list = {namelist_all(:).name};
        
        file_ind_1 = contains(name_list,'2015'); % 包含2015年的文件名
        file_ind_2 = contains(name_list,'2100'); % 包含2100年的文件名
        % 查找索引
        k1 = find(file_ind_1 == 1);
        k2 = find(file_ind_2 == 1);
        
        year_range = nan(length(k1:k2),2);
        for i = k1 : k2
            year_range(i-k1+1,1) = 2015 + (i-k1)*25;
            if i == k2 % 最后一年
                year_range(i-k1+1,2) = 2100;
            else
                year_range(i-k1+1,2) = 2039 + (i-k1)*25;
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
        
        %         info1 = ncinfo(name_list{k1});
        %         info2 = ncinfo(name_list{k1+1});
        year_index = 1;
        for i = k1 : k2
            time = ncread(name_list{i},'time');
            Pr_or_Tas = ncread(name_list{i},Data_type{m},[a(1) b(1) 1],[length(a) length(b) length(time)]);
            filename = ['BCC-CSM2-MR_',Data_type{m},'_',SSP_type{j},'_CN_',num2str(year_range(i-k1+1,1)),'_',num2str(year_range(i-k1+1,2)),'.mat'];
            save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\1-origin-data\BCC-CSM2-MR\',filename],'Pr_or_Tas','Lon_CN','Lat_CN')
            clear Pr_or_Tas
        end
        clear a b Lon Lat time file_ind name_list namelist_all save_path_1 k1 k2 year_index
    end
    disp([SSP_type{j},' is complete!'])
    clear Lon_CN Lat_CN 
end



%% INM-CM4-8 50年存一个数据
%% SSP370 降水出现问题，无法读取
%% SSP585 降水出现问题，无法读取
% 
% clear;clc
% SSP_type = {'ssp126','ssp245'};
% Data_type = {'pr','tas'};
% 
% % 读取CMFD的经纬度网格情况，从而提取中国地区的范围
% load('F:\File_of_MATLAB\关于3h尺度的CMFD降水数据研究2022.3.2\Data\LLT.mat')
% 
% for j = 1 : length(SSP_type)
%     CMIP6_model_Tas_Pr_2018_2058 = cell(2058-2018+1,2);
%     for m = 1 : length(Data_type)
%         save_path_1 = ['J:\2-Data\1-Precpitation Data\3-CMIP6\INM-CM4-8\',SSP_type{j},'-',Data_type{m},'\'];
%         namelist_all = dir([save_path_1,'*.nc']);
%         name_list = namelist_all(1).name; % 读取其中第二个数据，数据范围从2065-2100
%         % 打开对应文件夹
%         cd(save_path_1)
%         % 读取经纬度和时间
%         Lon = ncread(name_list,'lon');
%         Lat = ncread(name_list,'lat');
%         time = ncread(name_list,'time');
%         % 查找中国地区的经纬度范围，从而缩小提取数据大小
%         a = find(Lon(:) >= min(Lon_3h_scale) & Lon(:)<= max(Lon_3h_scale));%经度的指针
%         b = find(Lat(:) >= min(Lat_3h_scale) & Lat(:)<= max(Lat_3h_scale));%纬度的指针
%         Lon_CN = Lon(a);
%         Lat_CN = Lat(b);
%         
% %         ncinfo(name_list)
%         
%         Pr_or_Tas = ncread(name_list,Data_type{m},[1 1 1],[length(a) length(b) length(time)]);
%         
%         for year_index = 2018 : 2058
%             CMIP6_model_Tas_Pr_2018_2058{year_index-2017,m} = Pr_or_Tas(:,:,(year_index-2015)*365 + 1 : (year_index-2014)*365);
%         end
%         clear a b Lon Lat time file_ind name_list namelist_all save_path_1 k1 k2 year_index Pr_or_Tas
%     end
%     filename = ['INM-CM4-8_',SSP_type{j},'_CN_2018_2058.mat'];
%     save(['F:\File_of_MATLAB\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2018-2058\',filename],'CMIP6_model_Tas_Pr_2018_2058','Lon_CN','Lat_CN')
%     disp([SSP_type{j},' is complete!'])
%     clear Lon_CN Lat_CN CMIP6_model_Tas_Pr_2018_2058
% end

%% INM-CM5-0 50年存一个数据
%% ssp126 无法读取
% clear;clc
% SSP_type = {'ssp245','ssp370','ssp585'};
% Data_type = {'pr','tas'};
% 
% % 读取CMFD的经纬度网格情况，从而提取中国地区的范围
% load('F:\File_of_MATLAB\关于3h尺度的CMFD降水数据研究2022.3.2\Data\LLT.mat')
% 
% for j = 1 : length(SSP_type)
%     CMIP6_model_Tas_Pr_2018_2058 = cell(2058-2018+1,2);
%     for m = 1 : length(Data_type)
%         save_path_1 = ['J:\2-Data\1-Precpitation Data\3-CMIP6\INM-CM5-0\',SSP_type{j},'-',Data_type{m},'\'];
%         namelist_all = dir([save_path_1,'*.nc']);
%         name_list = namelist_all(1).name; % 读取其中第二个数据，数据范围从2065-2100
%         % 打开对应文件夹
%         cd(save_path_1)
%         % 读取经纬度和时间
%         Lon = ncread(name_list,'lon');
%         Lat = ncread(name_list,'lat');
%         time = ncread(name_list,'time');
%         % 查找中国地区的经纬度范围，从而缩小提取数据大小
%         a = find(Lon(:) >= min(Lon_3h_scale) & Lon(:)<= max(Lon_3h_scale));%经度的指针
%         b = find(Lat(:) >= min(Lat_3h_scale) & Lat(:)<= max(Lat_3h_scale));%纬度的指针
%         Lon_CN = Lon(a);
%         Lat_CN = Lat(b);
%         
% %         ncinfo(name_list)
%         
%         Pr_or_Tas = ncread(name_list,Data_type{m},[1 1 1],[length(a) length(b) length(time)]);
%         
%         for year_index = 2018 : 2058
%             CMIP6_model_Tas_Pr_2018_2058{year_index-2017,m} = Pr_or_Tas(:,:,(year_index-2015)*365 + 1 : (year_index-2014)*365);
%         end
%         clear a b Lon Lat time file_ind name_list namelist_all save_path_1 k1 k2 year_index Pr_or_Tas
%     end
%     filename = ['INM-CM5-0_',SSP_type{j},'_CN_2018_2058.mat'];
%     save(['F:\File_of_MATLAB\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2018-2058\',filename],'CMIP6_model_Tas_Pr_2018_2058','Lon_CN','Lat_CN')
%     disp([SSP_type{j},' is complete!'])
%     clear Lon_CN Lat_CN CMIP6_model_Tas_Pr_2018_2058
% end

%% MRI-ESM2-0 50年存一个数据 
%% 考虑润平年
% 做到这里

clear;clc
SSP_type = {'ssp126','ssp245','ssp370','ssp585'};
Data_type = {'pr','tas'};

% 读取CMFD的经纬度网格情况，从而提取中国地区的范围
load('F:\File_of_MATLAB\关于3h尺度的CMFD降水数据研究2022.3.2\Data\LLT.mat')

for j = 1 : length(SSP_type)
    %     CMIP6_model_Tas_Pr_2018_2058 = cell(2058-2018+1,2);
    for m = 1 : length(Data_type)
        save_path_1 = ['Z:\CMIP6_WRCP_daily\MRI-ESM2-0\',SSP_type{j},'-',Data_type{m},'\'];
        namelist_all = dir([save_path_1,'*.nc']);
        name_list = {namelist_all(:).name};
        
        file_ind_1 = contains(name_list,'2015'); % 包含2015年的文件名
        file_ind_2 = contains(name_list,'2100'); % 包含2100年的文件名
        % 查找索引
        k1 = find(file_ind_1 == 1);
        k2 = find(file_ind_2 == 1);
        
        year_range = nan(length(k1:k2),2);
        for i = k1 : k2
            year_range(i-k1+1,1) = 2015 + (i-k1)*50;
            if i == k2 % 最后一年
                year_range(i-k1+1,2) = 2100;
            else
                year_range(i-k1+1,2) = 2064 + (i-k1)*50;
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
        
        %         info1 = ncinfo(name_list{k1});
        %         info2 = ncinfo(name_list{k1+1});
        year_index = 1;
        for i = k1 : k2
            time = ncread(name_list{i},'time');
            Pr_or_Tas = ncread(name_list{i},Data_type{m},[a(1) b(1) 1],[length(a) length(b) length(time)]);
            filename = ['MRI-ESM2-0_',Data_type{m},'_',SSP_type{j},'_CN_',num2str(year_range(i-k1+1,1)),'_',num2str(year_range(i-k1+1,2)),'.mat'];
            save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\1-origin-data\MRI-ESM2-0\',filename],'Pr_or_Tas','Lon_CN','Lat_CN')
            clear Pr_or_Tas
        end
        clear a b Lon Lat time file_ind name_list namelist_all save_path_1 k1 k2 year_index
        disp([SSP_type{j},' is complete!'])
        clear Lon_CN Lat_CN
    end
end

%% ACCESS-ESM1-5 50年存一个数据
%% SSP245 tas 2015-2064无法读取
% clear;clc
% SSP_type = {'ssp126','ssp245','ssp370','ssp585'};
% Data_type = {'pr','tas'};
% 
% % 读取CMFD的经纬度网格情况，从而提取中国地区的范围
% load('F:\File_of_MATLAB\关于3h尺度的CMFD降水数据研究2022.3.2\Data\LLT.mat')
% 
% for j = 1 : length(SSP_type)
% %     CMIP6_model_Tas_Pr_2018_2058 = cell(2058-2018+1,2);
%     for m = 1 : length(Data_type)
%         save_path_1 = ['Z:\CMIP6_WRCP_daily\ACCESS-ESM1-5\',SSP_type{j},'-',Data_type{m},'\'];
%         namelist_all = dir([save_path_1,'*.nc']);
%         name_list = namelist_all(1).name;
%         
%         % 打开对应文件夹
%         cd(save_path_1)
%         % 读取经纬度和时间
%         Lon = ncread(name_list,'lon');
%         Lat = ncread(name_list,'lat');
%         time = ncread(name_list,'time');
%         % 查找中国地区的经纬度范围，从而缩小提取数据大小
%         a = find(Lon(:) >= min(Lon_3h_scale) & Lon(:)<= max(Lon_3h_scale));%经度的指针
%         b = find(Lat(:) >= min(Lat_3h_scale) & Lat(:)<= max(Lat_3h_scale));%纬度的指针
%         Lon_CN = Lon(a);
%         Lat_CN = Lat(b);
%         
%         %         info1 = ncinfo(name_list{k1});
%         %         info2 = ncinfo(name_list{k1+1});
%         Pr_or_Tas = ncread(name_list,Data_type{m},[1 1 1],[length(a) length(b) length(time)]);
%         filename = ['ACCESS-ESM1-5_',Data_type{m},'_',SSP_type{j},'_CN_2015_2064.mat'];
%         save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2018-2058\1-origin-data\',filename],'Pr_or_Tas','Lon_CN','Lat_CN')
%         clear Pr_or_Tas
%         clear a b Lon Lat time file_ind name_list namelist_all save_path_1 k1 k2 year_index
%     end
%     disp([SSP_type{j},' is complete!'])
%     clear Lon_CN Lat_CN 
% end

%% CanESM5 100年存一个数据
%% 不考虑润平年
clear;clc
SSP_type = {'ssp126','ssp245','ssp370','ssp585'};
Data_type = {'pr','tas'};

% 读取CMFD的经纬度网格情况，从而提取中国地区的范围
load('F:\File_of_MATLAB\关于3h尺度的CMFD降水数据研究2022.3.2\Data\LLT.mat')

for j = 1 : length(SSP_type)
%     CMIP6_model_Tas_Pr_2018_2058 = cell(2058-2018+1,2);
    for m = 1 : length(Data_type)
        save_path_1 = ['Z:\CMIP6_WRCP_daily\CanESM5\',SSP_type{j},'-',Data_type{m},'\'];
        namelist_all = dir([save_path_1,'*.nc']);
        name_list = namelist_all(1).name;
        
        % 打开对应文件夹
        cd(save_path_1)
        % 读取经纬度和时间
        Lon = ncread(name_list,'lon');
        Lat = ncread(name_list,'lat');
        time = ncread(name_list,'time');
        % 查找中国地区的经纬度范围，从而缩小提取数据大小
        a = find(Lon(:) >= min(Lon_3h_scale) & Lon(:)<= max(Lon_3h_scale));%经度的指针
        b = find(Lat(:) >= min(Lat_3h_scale) & Lat(:)<= max(Lat_3h_scale));%纬度的指针
        Lon_CN = Lon(a);
        Lat_CN = Lat(b);
        
        %         info1 = ncinfo(name_list{k1});
        %         info2 = ncinfo(name_list{k1+1});
        Pr_or_Tas = ncread(name_list,Data_type{m},[a(1) b(1) 1],[length(a) length(b) length(time)]);
        filename = ['CanESM5_',Data_type{m},'_',SSP_type{j},'_CN_2015_2100.mat'];
        save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\1-origin-data\CanESM5\',filename],'Pr_or_Tas','Lon_CN','Lat_CN')
        clear Pr_or_Tas
        clear a b Lon Lat time file_ind name_list namelist_all save_path_1 k1 k2 year_index
    end
    disp([SSP_type{j},' is complete!'])
    clear Lon_CN Lat_CN 
end
