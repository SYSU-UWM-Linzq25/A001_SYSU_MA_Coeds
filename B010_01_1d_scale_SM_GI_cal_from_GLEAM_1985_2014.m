%% 这个文件根据提取出来得GLEAM表层土壤水含量数据，单位为(m3/m3)
%% 1985-2014
%% 已经完成经纬度网格对齐（CMFD）
%% 完成填充值转换

clear;clc;

cd('J:\6-硕士毕业论文\1-Data\GLEAM-V3.8a-025-scale\SM\')
filename = ['SMsurf_CN_025_scale_in_',num2str(2000),'.mat'];
load(filename)
clear SM_surf_025_scale_year

Gini_1d_SMsurf_GLEAM = nan(length(Lon_025),length(Lat_025),2014-1985+1);
for year = 1985: 2014
    filename = ['SMsurf_CN_025_scale_in_',num2str(year),'.mat'];
    load(filename)
    
    % 从3维转为2维
    SM_surf_025_scale_year_line = reshape(SM_surf_025_scale_year,[],size(SM_surf_025_scale_year,3));
    
    % 计算基尼系数
    % 按照行计算
    G_1D = ginicoeff(SM_surf_025_scale_year_line,2,true);
    
    % 基尼系数计算
    Gini_1d_SMsurf_GLEAM(:,:,year-1984) = reshape(G_1D,[size(SM_surf_025_scale_year,1),size(SM_surf_025_scale_year,2)]);
    disp([num2str(year),' is done!'])
    clear SM_surf_025_scale_year SM_surf_025_scale_year_line G_1D filename    
end
filename2 = 'GLEAM_SMsurf_1d_Gini_1985_2014.mat';
save(['J:\6-硕士毕业论文\1-Data\GLEAM-V3.8a-025-scale\',filename2],'Gini_1d_SMsurf_GLEAM','Lon_025','Lat_025')
