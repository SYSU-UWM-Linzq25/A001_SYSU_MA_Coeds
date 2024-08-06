%% 这个文件根据选择出来历史时期的基尼系数气候态
%% 结合CMFD的基尼系数气候态
%% 计算校正矩阵，从而用于未来时期基尼系数的校正
%% 历史时期为1985-2014
%% 计算集合平均

clear;clc;
path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')
% 历史时期的集合平均
filename2 = 'Three_Model_ensemble_average_025_scale_Gini_CN_1985_2014.mat';
load(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\5-1-His-pr-025-scale-Gini\asemble\',filename2])

% 计算多年平均
Model_GI_ensemble_average_Multiyear_mean = nanmean(Model_GI_ensemble_average_year,3);
clear Model_GI_ensemble_average_year

% 历史时期的CMFD
% 读取CMFD整合到0.25°上的经纬度坐标
filename2 = 'CMFD_1d_Gini_025_scale_01mmh_1979_2018_from_Paper2.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\0-from-paper2\',filename2])
[xx_025,yy_025] = meshgrid(Lon_025,Lat_025);
xx_025 = xx_025';
yy_025 = yy_025';

% 研究时段为1985-2014
Gini_CMFD_1d_025_scale_01mmh_1985_2014 = Gini_CMFD_1d_025_scale_01mmh(:,:,7:end-4);
clear Gini_CMFD_1d_025_scale_01mmh

% 两种数据源的结果组织格式不太一样，计算RMSE需要先转置
Gini_CMFD_1d_025_scale_01mmh_rev = nan(length(Lon_025),length(Lat_025),size(Gini_CMFD_1d_025_scale_01mmh_1985_2014,3));

for year = 1 : size(Gini_CMFD_1d_025_scale_01mmh_1985_2014,3)
    b = Gini_CMFD_1d_025_scale_01mmh_1985_2014(:,:,year); 
    Gini_CMFD_1d_025_scale_01mmh_rev(:,:,year) = b';
    clear  b
end
clear Gini_CMFD_1d_025_scale_01mmh_1985_2014
% 计算多年平均
Gini_CMFD_1d_025_scale_01mmh_Multiyear_mean = nanmean(Gini_CMFD_1d_025_scale_01mmh_rev,3);
clear Gini_CMFD_1d_025_scale_01mmh_rev



% 校正矩阵，用CMFD-CMIP6历史，后面在未来阶段直接加上校正矩阵
Correction_matrix_for_CMIP6_GI = Gini_CMFD_1d_025_scale_01mmh_Multiyear_mean - Model_GI_ensemble_average_Multiyear_mean;
filename2 = 'Correction_matrix_from_His_for_future.mat';
save(['J:\6-硕士毕业论文\1-Data\Correcttion_matrix_for_CMIP6_future\',filename2],'Correction_matrix_for_CMIP6_GI','xx_025','yy_025')

