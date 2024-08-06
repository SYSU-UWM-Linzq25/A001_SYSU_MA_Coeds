%% 根据提取出来的未来降水情况，计算基尼系数
%% 主要是三个表现最好的模型
%% 空间分辨率升为0.25°
%% 阈值统一为0.1 mm/h


%% 针对三个模型计算的基尼系数，计算集合平均
%% 这里因为后续要进行年均温和年降水量的研究，所以进行逐年的研究

clear;clc;
path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')
model_name = {'MPI-ESM1-2-HR','NorESM2-MM','MIROC6'};
SSP_type = {'ssp126','ssp245','ssp370','ssp585'};

save_peth_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\7-2-future-Gini-025-scale\';
cd(save_peth_1)
% 读取经纬度坐标信息
filename_1 = ['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\6-2-future-025-scale-ensemble-climatic-MAT-AP\Geography Inform.mat'];
load(filename_1)

for j = 1 : length(SSP_type)
    % 读取CMIP6三个模型下这种情景计算出来的30年基尼系数的气候态
    Model_GI_3_model_ensemble_annual = nan(size(xx_025,1),size(xx_025,2),30);
    for year = 1 : 30
        Model_GI_3_model = nan(size(xx_025,1),size(xx_025,2),3);
        for i = 1 : length(model_name) % 选择模式读取数据
            filename_1 = [model_name{i},'_',SSP_type{j},'_025_scale_Gini_CN_2031_2060.mat'];
            load(filename_1)
            
            % 提取模型其中的一年
            Model_GI_3_model(:,:,i) = Model_pre_G_025_scale_2031_2060{year,1};
            clear Model_pre_G_025_scale_2031_2060
            clear filename_1
        end
        Model_GI_3_model_ensemble_annual(:,:,year) = nanmean(Model_GI_3_model,3);
        clear Model_GI_3_model
    end
    filename2 = [SSP_type{j},'_3_Model_ensemble_annual_GI_025_scale_CN_2031_2060.mat'];
    save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\7-4-future-025-ensemble-annual-GI\',filename2],'Model_GI_3_model_ensemble_annual','xx_025','yy_025')
    disp([SSP_type{j},' is complete!'])
    clear Model_GI_3_model_ensemble_annual filename2
end
