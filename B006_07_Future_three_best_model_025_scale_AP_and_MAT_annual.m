%% 根据提取出来的未来降水情况，计算不同情境下逐年年均温和年降水量
%% 主要是三个表现最好的模型
%% 空间分辨率升为0.25°

clear;clc;
path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')
model_name = {'MPI-ESM1-2-HR','NorESM2-MM','MIROC6'};
SSP_type = {'ssp126','ssp245','ssp370','ssp585'};

save_peth_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\6-1-future-025-scale-MAT-AP\';
cd(save_peth_1)

% 读取经纬度坐标信息
filename_1 = ['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\6-2-future-025-scale-ensemble-climatic-MAT-AP\Geography Inform.mat'];
load(filename_1)

for j = 1 : length(SSP_type)
    % 读取CMIP6三个模型下这种情景计算出来的30年基尼系数的气候态
    Model_MAT_3_model_ensemble_annual = nan(size(xx_025,1),size(xx_025,2),30);
    for year = 1 : 30
        Model_MAT_3_model = nan(size(xx_025,1),size(xx_025,2),3);
        for i = 1 : length(model_name) % 选择模式读取数据
            filename_1 = [model_name{i},'_',SSP_type{j},'_Tas_025_scale_CN_2031_2060.mat'];
            load(filename_1)
            
            % 提取模型其中的一年
            Model_MAT_3_model(:,:,i) = Model_MAT_025_scale_2031_2060(:,:,year);
            clear Model_MAT_025_scale_2031_2060
            clear filename_1
        end
        Model_MAT_3_model_ensemble_annual(:,:,year) = nanmean(Model_MAT_3_model,3);
        clear Model_MAT_3_model
    end
    filename2 = [SSP_type{j},'_3_Model_ensemble_annual_MAT_025_scale_CN_2031_2060.mat'];
    save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\6-3-future-025-scale-ensemble-annual-MAT-AP\',filename2],'Model_MAT_3_model_ensemble_annual','xx_025','yy_025')
    disp([SSP_type{j},' is complete!'])
    clear Model_MAT_3_model_ensemble_annual filename2
end

%% 逐年降水量

clear;clc;
path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')
model_name = {'MPI-ESM1-2-HR','NorESM2-MM','MIROC6'};
SSP_type = {'ssp126','ssp245','ssp370','ssp585'};

save_peth_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\6-1-future-025-scale-MAT-AP\';
cd(save_peth_1)

% 读取经纬度坐标信息
filename_1 = ['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\6-2-future-025-scale-ensemble-climatic-MAT-AP\Geography Inform.mat'];
load(filename_1)

for j = 1 : length(SSP_type)
    % 读取CMIP6三个模型下这种情景计算出来的30年基尼系数的气候态
    Model_AP_3_model_ensemble_annual = nan(size(xx_025,1),size(xx_025,2),30);
    for year = 1 : 30
        Model_AP_3_model = nan(size(xx_025,1),size(xx_025,2),3);
        for i = 1 : length(model_name) % 选择模式读取数据
            filename_1 = [model_name{i},'_',SSP_type{j},'_Pr_025_scale_CN_2031_2060.mat'];
            load(filename_1)
            
            % 提取模型其中的一年
            Model_AP_3_model(:,:,i) = Model_AP_025_scale_2031_2060(:,:,year);
            clear Model_AP_025_scale_2031_2060
            clear filename_1
        end
        Model_AP_3_model_ensemble_annual(:,:,year) = nanmean(Model_AP_3_model,3);
        clear Model_AP_3_model
    end
    filename2 = [SSP_type{j},'_3_Model_ensemble_annual_AP_025_scale_CN_2031_2060.mat'];
    save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\6-3-future-025-scale-ensemble-annual-MAT-AP\',filename2],'Model_AP_3_model_ensemble_annual','xx_025','yy_025')
    disp([SSP_type{j},' is complete!'])
    clear Model_AP_3_model_ensemble_annual filename2
end