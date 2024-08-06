%% 根据提取出来的三个未来模式以及分开提取的两个时间段
%% 计算多年平均降水量和多年平均温度

clear;clc
path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')
model_name = {'MPI-ESM1-2-HR','NorESM2-MM','MIROC6'};
SSP_type = {'ssp126','ssp245','ssp370','ssp585'};
Data_type = {'pr','tas'};

save_peth_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\3-process-cell-data\';
cd(save_peth_1)

% 2031-2060
for i = 1 : length(model_name) % 选择模式读取数据
    for j = 1 : length(SSP_type)
        filename_1 = [model_name{i},'_',SSP_type{j},'_CN_2031_2060.mat'];
        load(filename_1)
        
        Model_AP_2031_2060 = nan(length(Lon_CN),length(Lat_CN),2060-2031+1);
        Model_MAT_2031_2060 = nan(length(Lon_CN),length(Lat_CN),2060-2031+1);
        for year = 2031:2060
            % 当年日降水三维矩阵
            Model_Pre_year = CMIP6_model_Pr_Tas_2031_2060{year-2030,1};
            % 求年降水量
            Model_AP_2031_2060(:,:,year-2030) = nansum(Model_Pre_year,3);
            % 当年温度三维矩阵
            Model_Tas_year = CMIP6_model_Pr_Tas_2031_2060{year-2030,2};
            % 求年降水量
            Model_MAT_2031_2060(:,:,year-2030) = nanmean(Model_Tas_year,3);
            clear Model_Tas_year Model_Pre_year
        end
        filename2 = [model_name{i},'_',SSP_type{j},'_MAT_and_AP_CN_2031_2060.mat'];
        save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\4-origin-scale-MAT-AP\2031-2060\',filename2],'Model_MAT_2031_2060','Model_AP_2031_2060','Lon_CN','Lat_CN')
        disp([model_name{i},'_',SSP_type{j},' is complete!'])
        clear Model_MAT_2031_2060 Lon_CN Lat_CN filename2 filename_1 Model_AP_2031_2060
    end
end

%% 2070-2099

clear;clc
path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')
model_name = {'MPI-ESM1-2-HR','NorESM2-MM','MIROC6'};
SSP_type = {'ssp126','ssp245','ssp370','ssp585'};
Data_type = {'pr','tas'};

save_peth_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\3-process-cell-data\';
cd(save_peth_1)

for i = 1 : length(model_name) % 选择模式读取数据
    for j = 1 : length(SSP_type)
        filename_1 = [model_name{i},'_',SSP_type{j},'_CN_2070_2099.mat'];
        load(filename_1)
        
        Model_AP_2070_2099 = nan(length(Lon_CN),length(Lat_CN),2099-2070+1);
        Model_MAT_2070_2099 = nan(length(Lon_CN),length(Lat_CN),2099-2070+1);
        for year = 2070:2099
            % 当年日降水三维矩阵
            Model_Pre_year = CMIP6_model_Pr_Tas_2070_2099{year-2069,1};
            % 求年降水量
            Model_AP_2070_2099(:,:,year-2069) = nansum(Model_Pre_year,3);
            % 当年温度三维矩阵
            Model_Tas_year = CMIP6_model_Pr_Tas_2070_2099{year-2069,2};
            % 求年降水量
            Model_MAT_2070_2099(:,:,year-2069) = nanmean(Model_Tas_year,3);
            clear Model_Tas_year Model_Pre_year
        end
        filename2 = [model_name{i},'_',SSP_type{j},'_MAT_and_AP_CN_2070_2099.mat'];
        save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\4-origin-scale-MAT-AP\2070-2099\',filename2],'Model_MAT_2070_2099','Model_AP_2070_2099','Lon_CN','Lat_CN')
        disp([model_name{i},'_',SSP_type{j},' is complete!'])
        clear Model_MAT_2070_2099 Lon_CN Lat_CN filename2 filename_1 Model_AP_2070_2099
    end
end