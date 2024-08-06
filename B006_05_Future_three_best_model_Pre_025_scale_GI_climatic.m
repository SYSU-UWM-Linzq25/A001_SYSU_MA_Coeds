%% 根据提取出来的未来降水情况，计算基尼系数
%% 主要是三个表现最好的模型
%% 空间分辨率升为0.25°
%% 阈值统一为0.1 mm/h

% 2031-2060
clear;clc;
path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')
model_name = {'MPI-ESM1-2-HR','NorESM2-MM','MIROC6'};
SSP_type = {'ssp126','ssp245','ssp370','ssp585'};
Data_type = {'pr','tas'};

save_peth_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\5-2-future-pr-and-Tas-025-scale-cell-data\';
cd(save_peth_1)

for i = 1 : length(model_name) % 选择模式读取数据
    for j = 1 : length(SSP_type)
        filename_1 = [model_name{i},'_',SSP_type{j},'_Pr_CN_025_scale_2031_2060.mat'];
        load(filename_1)
        clear filename_1
        Model_pre_G_025_scale_2031_2060 = cell(2060-2031+1,1);
        for year = 2031:2060
            % 当年降水
            Model_Pre_year = CMIP6_model_Pr_025_scale_2031_2060{year-2030,1};
            % 预处理
            Model_Pre_year(Model_Pre_year < 2.4) = 0;
            % 这里只是将前两维展开为1维，这样第三维还是表征一年的降水序列
            Model_Pre_year_2D = reshape(Model_Pre_year,[],size(Model_Pre_year,3));
            % 计算基尼系数
            % 按照行计算
            G_1D = ginicoeff(Model_Pre_year_2D,2,true);
            % 重新转换成二维
            Model_pre_G_025_scale_2031_2060{year-2030,1} = reshape(G_1D,[size(Model_Pre_year,1),size(Model_Pre_year,2)]);
            clear Model_Pre_year Model_Pre_year_2D G_1D
        end
        filename2 = [model_name{i},'_',SSP_type{j},'_025_scale_Gini_CN_2031_2060.mat'];
        save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\7-2-future-Gini-025-scale\',filename2],'Model_pre_G_025_scale_2031_2060','xx_025','yy_025')
        disp([model_name{i},'_',SSP_type{j},' is complete!'])
        clear Model_pre_G_025_scale_2031_2060 xx_025 yy_025 filename2 filename_1 CMIP6_model_Pr_025_scale_2031_2060
    end
end

%% 2070-2099
clear;clc;
path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')
model_name = {'MPI-ESM1-2-HR','NorESM2-MM','MIROC6'};
SSP_type = {'ssp126','ssp245','ssp370','ssp585'};
Data_type = {'pr','tas'};

save_peth_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\5-2-future-pr-and-Tas-025-scale-cell-data\';
cd(save_peth_1)

for i = 1 : length(model_name) % 选择模式读取数据
    for j = 1 : length(SSP_type)
        filename_1 = [model_name{i},'_',SSP_type{j},'_Pr_CN_025_scale_2070_2099.mat'];
        load(filename_1)
        
        Model_pre_G_025_scale_2070_2099 = cell(2099-2070+1,1);
        for year = 2070:2099
            % 当年降水
            Model_Pre_year = CMIP6_model_Pr_025_scale_2070_2099{year-2069,1};
            % 预处理
            Model_Pre_year(Model_Pre_year < 2.4) = 0;
            % 这里只是将前两维展开为1维，这样第三维还是表征一年的降水序列
            Model_Pre_year_2D = reshape(Model_Pre_year,[],size(Model_Pre_year,3));
            % 计算基尼系数
            % 按照行计算
            G_1D = ginicoeff(Model_Pre_year_2D,2,true);
            % 重新转换成二维
            Model_pre_G_025_scale_2070_2099{year-2069,1} = reshape(G_1D,[size(Model_Pre_year,1),size(Model_Pre_year,2)]);
            clear Model_Pre_year Model_Pre_year_2D G_1D
        end
        filename2 = [model_name{i},'_',SSP_type{j},'_025_scale_Gini_CN_2070_2099.mat'];
        save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\7-2-future-Gini-025-scale\',filename2],'Model_pre_G_025_scale_2070_2099','xx_025','yy_025')
        disp([model_name{i},'_',SSP_type{j},' is complete!'])
        clear Model_pre_G_025_scale_2070_2099 yy_025 Lat_CN filename2 filename_1 CMIP6_model_Pr_025_scale_2070_2099
    end
end


%% 针对三个模型计算的基尼系数，计算集合平均
%% 这里同样的，集合平均的应该是基尼系数的多年平均值，也就是基尼系数的气候态，而不是逐年的基尼系数去三个模型平均
%% 所以这里计算的是三个模型各自30a的多年平均，然后再3个模型取平均

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
    Model_GI_3_model_multiyear_mean = nan(size(xx_025,1),size(xx_025,2),3);
    for i = 1 : length(model_name) % 选择模式读取数据
        filename_1 = [model_name{i},'_',SSP_type{j},'_025_scale_Gini_CN_2031_2060.mat'];
        load(filename_1)
        
        % 这里多一个步骤，从cell转成三维矩阵
        Model_pre_G_025_scale_2031_2060_3D = cell_to_3D_matrix(Model_pre_G_025_scale_2031_2060);
        clear Model_pre_G_025_scale_2031_2060
        
        Model_GI_3_model_multiyear_mean(:,:,i) = nanmean(Model_pre_G_025_scale_2031_2060_3D,3);
        clear filename_1 Model_pre_G_025_scale_2031_2060_3D
    end
    Model_GI_ensemble_climatic_GI = nanmean(Model_GI_3_model_multiyear_mean,3);
    
    filename2 = [SSP_type{j},'_3_Model_ensemble_climatic_GI_025_scale_CN_2031_2060.mat'];
    save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\7-3-future-025-scale-ensemble-climatic-GI\',filename2],'Model_GI_ensemble_climatic_GI','xx_025','yy_025')
    disp([SSP_type{j},' is complete!'])
    clear Model_GI_ensemble_climatic_GI
end 

% 2070-2099
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
    Model_GI_3_model_multiyear_mean = nan(size(xx_025,1),size(xx_025,2),3);
    for i = 1 : length(model_name) % 选择模式读取数据
        filename_1 = [model_name{i},'_',SSP_type{j},'_025_scale_Gini_CN_2070_2099.mat'];
        load(filename_1)
        
        % 这里多一个步骤，从cell转成三维矩阵
        Model_pre_G_025_scale_2031_2060_3D = cell_to_3D_matrix(Model_pre_G_025_scale_2070_2099);
        clear Model_pre_G_025_scale_2070_2099
        
        Model_GI_3_model_multiyear_mean(:,:,i) = nanmean(Model_pre_G_025_scale_2031_2060_3D,3);
        clear filename_1 Model_pre_G_025_scale_2031_2060_3D
    end
    Model_GI_ensemble_climatic_GI = nanmean(Model_GI_3_model_multiyear_mean,3);
    
    filename2 = [SSP_type{j},'_3_Model_ensemble_climatic_GI_025_scale_CN_2070_2099.mat'];
    save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\7-3-future-025-scale-ensemble-climatic-GI\',filename2],'Model_GI_ensemble_climatic_GI','xx_025','yy_025')
    disp([SSP_type{j},' is complete!'])
    clear Model_GI_ensemble_climatic_GI
end 
