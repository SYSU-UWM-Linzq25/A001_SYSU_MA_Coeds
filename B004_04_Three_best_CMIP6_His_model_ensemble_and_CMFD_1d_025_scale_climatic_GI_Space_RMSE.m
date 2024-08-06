%% 这个文件根据升尺度后的CMFD和CMIP6历史时期数据计算得到的基尼系数和集合平均的基尼系数进行比较
%% 指标为RMSE
%% 这里计算的是在空间上的RMSE情况，使用的是基尼系数气候态
clear;clc;

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
Gini_CMFD_1d_025_scale_01mmh_rev_mean = nanmean(Gini_CMFD_1d_025_scale_01mmh_rev,3);
Gini_CMFD_1d_025_scale_01mmh_rev_mean_line = reshape(Gini_CMFD_1d_025_scale_01mmh_rev_mean,[1,size(Gini_CMFD_1d_025_scale_01mmh_rev_mean,1)*size(Gini_CMFD_1d_025_scale_01mmh_rev_mean,2)]);

clear Gini_CMFD_1d_025_scale_01mmh_rev
% 三个模型各自的基尼系数
model_name = {'MPI-ESM1-2-HR','NorESM2-MM','MIROC6'};
save_path_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\5-1-His-pr-025-scale-Gini\';
cd(save_path_1)

for i = 1 : length(model_name) % 选择模式读取数据
    filename = [model_name{i},'_1d_Gini_025_scale_1975_2014.mat'];
    load(filename)
    clear filename
    
    % 只保留1985-2014
    Model_His_Gini = Model_His_Gini(:,:,11:end);
    eval(['Model_His_Gini_',num2str(i),'_mean = nanmean(Model_His_Gini,3);'])
    eval(['Model_His_Gini_',num2str(i),'_mean_line = reshape(Model_His_Gini_',num2str(i),'_mean,[1,size(Gini_CMFD_1d_025_scale_01mmh_rev_mean,1)*size(Gini_CMFD_1d_025_scale_01mmh_rev_mean,2)]);'])
    clear Model_His_Gini
end

% 集合平均的基尼系数
load('J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\5-1-His-pr-025-scale-Gini\asemble\Three_Model_ensemble_average_025_scale_Gini_CN_1985_2014.mat')
Model_GI_ensemble_average_year_mean = nanmean(Model_GI_ensemble_average_year,3);
Model_GI_ensemble_average_year_mean_line = reshape(Model_GI_ensemble_average_year_mean,[1,size(Gini_CMFD_1d_025_scale_01mmh_rev_mean,1)*size(Gini_CMFD_1d_025_scale_01mmh_rev_mean,2)])
clear Model_GI_ensemble_average_year
% 计算空间RMSE
% 单独模型的

for i = 1 : length(model_name) % 选择模式读取数据
    
    G_CMFD_1 = Gini_CMFD_1d_025_scale_01mmh_rev_mean_line;
    eval(['G_Model_1 = Model_His_Gini_',num2str(i),'_mean_line;'])
    
    k1 = find(isnan(G_Model_1));
    k2 = find(isnan(G_CMFD_1));
    if ~isempty(k1) && ~isempty(k2)
        k3 = unique([k1,k2]);
        G_Model_1(k3) = [];
        G_CMFD_1(k3) = [];
    elseif isempty(k1) && ~isempty(k2)
        G_Model_1(k2) = [];
        G_CMFD_1(k2) = [];
    elseif ~isempty(k1) && isempty(k2)
        G_Model_1(k1) = [];
        G_CMFD_1(k1) = [];
    end
    eval(['Spatial_RMSE_model_',num2str(i),' = sqrt(mean((G_CMFD_1-G_Model_1).^2));'])
    clear G_CMFD_1 G_Model_1 k1 k2 k3
end

        
G_CMFD_1 = Gini_CMFD_1d_025_scale_01mmh_rev_mean_line;
G_Model_1 = Model_GI_ensemble_average_year_mean_line;

k1 = find(isnan(G_Model_1));
k2 = find(isnan(G_CMFD_1));
if ~isempty(k1) && ~isempty(k2)
    k3 = unique([k1,k2]);
    G_Model_1(k3) = [];
    G_CMFD_1(k3) = [];
elseif isempty(k1) && ~isempty(k2)
    G_Model_1(k2) = [];
    G_CMFD_1(k2) = [];
elseif ~isempty(k1) && isempty(k2)
    G_Model_1(k1) = [];
    G_CMFD_1(k1) = [];
end
Spatial_RMSE_model_ensemble = sqrt(mean((G_CMFD_1-G_Model_1).^2));

filename2 = 'Spatial_RMSE_of_CMFD_and_CMIP6_3_best_model_include_emsemble_climatic_GI_025_scale.mat';
save(['J:\6-硕士毕业论文\1-Data\RMSE_model_CMFD_CN051\',filename2],'Spatial_RMSE_model_1','Spatial_RMSE_model_2','Spatial_RMSE_model_3','Spatial_RMSE_model_ensemble')







