%% 根据CMIP6历史时期三个模型平均的基尼系数和年降水量，计算相关系数
%% 这里直接看集合平均的结果
%% 升尺度后统一的结果

clear;clc;

% 集合平均的年均温
save_peth_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\6-0-His-025-scale-MAT-AP\';
cd(save_peth_1)
filename_1 = 'Three_Model_ensemble_average_025_scale_AP_CN_1985_2014.mat';
load(filename_1)

% 集合平均的基尼系数
load('J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\5-1-His-pr-025-scale-Gini\asemble\Three_Model_ensemble_average_025_scale_Gini_CN_1985_2014.mat')

PCCs_1d_GI_AP = nan(size(Model_AP_ensemble_average_year,1),size(Model_AP_ensemble_average_year,2));
p_value_1d = nan(size(Model_AP_ensemble_average_year,1),size(Model_AP_ensemble_average_year,2));

% 计算相关系数和p值
for i = 1 : size(Model_AP_ensemble_average_year,1)
    for j = 1 : size(Model_AP_ensemble_average_year,2)
       
        GI_1d = Model_GI_ensemble_average_year(i,j,:);
        AP_1 = Model_AP_ensemble_average_year(i,j,:);
        
        [r_1d,p_1d] = corrcoef(AP_1,GI_1d);
        PCCs_1d_GI_AP(i,j) = r_1d(2);
        p_value_1d(i,j) = p_1d(2);
        clear GI_1d p_1d r_1d AP_1
    end 
end

filename2 = 'PCCs_of_CMIP6_ensemble_His_AP_and_1d_GI_025_scale_1985_2014.mat';
save(['J:\6-硕士毕业论文\1-Data\PCCs-bewteen-AP-and-GI\',filename2],'PCCs_1d_GI_AP','p_value_1d','xx_025','yy_025')

