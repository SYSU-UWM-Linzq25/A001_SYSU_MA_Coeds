%% 这个文件根据升尺度后的CMFD和CN051的基尼系数
%% 开展对比，计算RMSE
%% 指标为RMSE

% 读取CMFD升尺度结果-025
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

% 读取CN051的结果
% 两种处理阈值
% 0.1 mm/h
filename2 = 'CN051_Daily_Gini_1979_2018_01mmh.mat';
load(['J:\6-硕士毕业论文\1-Data\CN051-TM-Pre-1979-2018\3-CN051-Pr-Gini&LinearTrend\',filename2]);
Gini_CN051_01mmh = Gini_CN051;
clear Gini_CN051 Lon Lat
Gini_CN051_01mmh = Gini_CN051_01mmh(:,:,7:end-4);

% [I,J] = ind2sub([size(Gini_CN051_01mmh,1),size(Gini_CN051_01mmh,2)],k);
% 因为存在nan，所以在计算RMSE时需要互相去掉nan先
% 0.1 mm/h
RMSE_01mmh_025_scale = nan(size(Gini_CN051_01mmh,1),size(Gini_CN051_01mmh,2));
for i = 1 : size(Gini_CN051_01mmh,1)
    for j = 1 : size(Gini_CN051_01mmh,2)
        G_CN051_1 = Gini_CN051_01mmh(i,j,:);
        G_CMFD_1 = Gini_CMFD_1d_025_scale_01mmh_rev(i,j,:);
        
        k1 = find(isnan(G_CN051_1));
        k2 = find(isnan(G_CMFD_1));
        if ~isempty(k1) && ~isempty(k2)
            k3 = unique([k1;k2]);   
            G_CN051_1(k3) = [];
            G_CMFD_1(k3) = [];
        elseif isempty(k1) && ~isempty(k2)
            G_CN051_1(k2) = [];
            G_CMFD_1(k2) = [];    
        elseif ~isempty(k1) && isempty(k2)
            G_CN051_1(k1) = [];
            G_CMFD_1(k1) = [];           
        end
        
        % 计算RMSE
        RMSE_01mmh_025_scale(i,j) = sqrt(mean((G_CMFD_1-G_CN051_1).^2));
        
        
        clear G_CN051_1 G_CMFD_1 k1 k2 k3
    end
end

filename2 = 'RMSE_CMFD_and_CN051_GI_025_scale.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\',filename2],'RMSE_01mmh_025_scale','xx_025','yy_025')

