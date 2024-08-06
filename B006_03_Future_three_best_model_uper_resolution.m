%% 这个文件将提取出来得未来时期CMIP6数据进行升尺度
%% 暂未预处理(0.1 mm/h)
%% 处理了填充值，温度和降水完成了单位转换(℃，mm/day)

% 2031-2060
clear;clc;
path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')
model_name = {'MPI-ESM1-2-HR','NorESM2-MM','MIROC6'};
SSP_type = {'ssp126','ssp245','ssp370','ssp585'};
Data_type = {'pr','tas'};

save_peth_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\3-process-cell-data\';
cd(save_peth_1)

% 读取整合到0.25°上的经纬度坐标
filename2 = 'CMFD_1d_Gini_025_scale_Sen_Trend_01mmh_1985_2014_from_Paper2.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\6-2-CMFD-025-scale-Gini-Sen-Trend\',filename2]);
[xx_025,yy_025] = meshgrid(Lon_025,Lat_025);
xx_025 = xx_025';
yy_025 = yy_025';
clear Gini_Sen_slope_1d

for i = 1 : length(model_name) % 选择模式读取数据
    for j = 1 : length(SSP_type)
        filename_1 = [model_name{i},'_',SSP_type{j},'_CN_2031_2060.mat'];
        load(filename_1)
        
        clear filename_1
        % 将模型对应使用的经纬度插值为经纬度网格
        [xx_model,yy_model] = meshgrid(Lon_CN,Lat_CN);
        xx_model = xx_model';
        yy_model = yy_model';
        clear Lon_CN Lat_CN
        
        % 设立0.25°的模型cell库
        CMIP6_model_Pr_025_scale_2031_2060 = cell(length(CMIP6_model_Pr_Tas_2031_2060),1);
        CMIP6_model_Tas_025_scale_2031_2060 = cell(length(CMIP6_model_Pr_Tas_2031_2060),1);
        for year = 2031:2060
            % 当年日降水三维矩阵
            Model_Pre_year = CMIP6_model_Pr_Tas_2031_2060{year-2030,1};
            % 当年日均温三维矩阵
            Model_Tas_year = CMIP6_model_Pr_Tas_2031_2060{year-2030,2};
            
            Model_daily_pr_025_scale_year = nan(size(xx_025,1),size(xx_025,2),size(Model_Pre_year,3));
            Model_daily_tas_025_scale_year = nan(size(xx_025,1),size(xx_025,2),size(Model_Pre_year,3));
            % 进一步在日循环
            for m = 1 : size(Model_Pre_year,3)
                Model_daily_pr_day = Model_Pre_year(:,:,m);
                Model_daily_tas_day = Model_Tas_year(:,:,m);
                % 双线性插值到0.25°的网格
                Model_daily_pr_025_scale_year(:,:,m) = griddata(xx_model,yy_model,Model_daily_pr_day,xx_025,yy_025,'linear');
                Model_daily_tas_025_scale_year(:,:,m) = griddata(xx_model,yy_model,Model_daily_tas_day,xx_025,yy_025,'linear');
                clear Model_daily_pr_day Model_daily_tas_day
            end
            CMIP6_model_Pr_025_scale_2031_2060{year-2030,1} = Model_daily_pr_025_scale_year;
            CMIP6_model_Tas_025_scale_2031_2060{year-2030,2} = Model_daily_tas_025_scale_year;
            disp([num2str(year), ' of ',SSP_type{j},' of ',model_name{i}, ' is done!'])
            clear Model_daily_pr_025_scale_year Model_daily_tas_025_scale_year
        end
        clear filename2 xx_model yy_model

        filename2 = [model_name{i},'_',SSP_type{j},'_Pr_CN_025_scale_2031_2060.mat'];
        save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\5-2-future-pr-and-Tas-025-scale-cell-data\',filename2],'CMIP6_model_Pr_025_scale_2031_2060','xx_025','yy_025')
        clear filename2
        filename2 = [model_name{i},'_',SSP_type{j},'_Tas_CN_025_scale_2031_2060.mat'];
        save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\5-2-future-pr-and-Tas-025-scale-cell-data\',filename2],'CMIP6_model_Tas_025_scale_2031_2060','xx_025','yy_025')
        clear CMIP6_model_Pr_025_scale_2031_2060 CMIP6_model_Tas_025_scale_2031_2060
    end
end

% 2070-2099
clear;clc;
path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')
model_name = {'MPI-ESM1-2-HR','NorESM2-MM','MIROC6'};
SSP_type = {'ssp126','ssp245','ssp370','ssp585'};
Data_type = {'pr','tas'};

save_peth_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\3-process-cell-data\';
cd(save_peth_1)

% 读取整合到0.25°上的经纬度坐标
filename2 = 'CMFD_1d_Gini_025_scale_Sen_Trend_01mmh_1985_2014_from_Paper2.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\6-2-CMFD-025-scale-Gini-Sen-Trend\',filename2]);
[xx_025,yy_025] = meshgrid(Lon_025,Lat_025);
xx_025 = xx_025';
yy_025 = yy_025';
clear Gini_Sen_slope_1d

for i = 1 : length(model_name) % 选择模式读取数据
    for j = 1 : length(SSP_type)
        filename_1 = [model_name{i},'_',SSP_type{j},'_CN_2070_2099.mat'];
        load(filename_1)
        
        clear filename_1
        % 将模型对应使用的经纬度插值为经纬度网格
        [xx_model,yy_model] = meshgrid(Lon_CN,Lat_CN);
        xx_model = xx_model';
        yy_model = yy_model';
        clear Lon_CN Lat_CN
        
        % 设立0.25°的模型cell库
        CMIP6_model_Pr_025_scale_2070_2099 = cell(length(CMIP6_model_Pr_Tas_2070_2099),1);
        CMIP6_model_Tas_025_scale_2070_2099 = cell(length(CMIP6_model_Pr_Tas_2070_2099),1);
        
        for year = 2070:2099
            % 当年日降水三维矩阵
            Model_Pre_year = CMIP6_model_Pr_Tas_2070_2099{year-2069,1};
            % 当年日均温三维矩阵
            Model_Tas_year = CMIP6_model_Pr_Tas_2070_2099{year-2069,2};
            
            Model_daily_pr_025_scale_year = nan(size(xx_025,1),size(xx_025,2),size(Model_Pre_year,3));
            Model_daily_tas_025_scale_year = nan(size(xx_025,1),size(xx_025,2),size(Model_Pre_year,3));
            % 进一步在日循环
            for m = 1 : size(Model_Pre_year,3)
                Model_daily_pr_day = Model_Pre_year(:,:,m);
                Model_daily_tas_day = Model_Tas_year(:,:,m);
                % 双线性插值到0.25°的网格
                Model_daily_pr_025_scale_year(:,:,m) = griddata(xx_model,yy_model,Model_daily_pr_day,xx_025,yy_025,'linear');
                Model_daily_tas_025_scale_year(:,:,m) = griddata(xx_model,yy_model,Model_daily_tas_day,xx_025,yy_025,'linear');
                clear Model_daily_pr_day Model_daily_tas_day
            end
            CMIP6_model_Pr_025_scale_2070_2099{year-2069,1} = Model_daily_pr_025_scale_year;
            CMIP6_model_Tas_025_scale_2070_2099{year-2069,2} = Model_daily_tas_025_scale_year;
            disp([num2str(year), ' of ',SSP_type{j},' of ',model_name{i}, ' is done!'])
            clear Model_daily_pr_025_scale_year Model_daily_tas_025_scale_year
        end
        clear filename2 xx_model yy_model

        filename2 = [model_name{i},'_',SSP_type{j},'_Pr_CN_025_scale_2070_2099.mat'];
        save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\5-2-future-pr-and-Tas-025-scale-cell-data\',filename2],'CMIP6_model_Pr_025_scale_2070_2099','xx_025','yy_025')
        clear filename2
        filename2 = [model_name{i},'_',SSP_type{j},'_Tas_CN_025_scale_2070_2099.mat'];
        save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\5-2-future-pr-and-Tas-025-scale-cell-data\',filename2],'CMIP6_model_Tas_025_scale_2070_2099','xx_025','yy_025')
        clear CMIP6_model_Pr_025_scale_2070_2099 CMIP6_model_Tas_025_scale_2070_2099
    end
end
