%% 这个文件根据提取出来得GLEAM总蒸发数据，单位为(mm/day)
%% 1985-2014
%% 已经完成经纬度网格对齐（CMFD）
%% 完成填充值转换

% 蒸散发存在负值，所以重新赋值为0

clear;clc;

cd('J:\6-硕士毕业论文\1-Data\GLEAM-V3.8a-025-scale\Eva\')
filename = ['Eva_CN_025_scale_in_',num2str(2000),'.mat'];
load(filename)
clear Eva_025_scale_year

Gini_1d_Eva_GLEAM = nan(length(Lon_025),length(Lat_025),2014-1985+1);
for year = 1985: 2014
    filename = ['Eva_CN_025_scale_in_',num2str(year),'.mat'];
    load(filename)
    
    % 从3维转为2维
    Eva_025_scale_year_line = reshape(Eva_025_scale_year,[],size(Eva_025_scale_year,3));
    
    Eva_025_scale_year_line(Eva_025_scale_year_line < 0) = 0;
    % 计算基尼系数
    % 按照行计算
    G_1D = ginicoeff(Eva_025_scale_year_line,2,true);
    
    % 基尼系数计算
    Gini_1d_Eva_GLEAM(:,:,year-1984) = reshape(G_1D,[size(Eva_025_scale_year,1),size(Eva_025_scale_year,2)]);
    disp([num2str(year),' is done!'])
    clear Eva_025_scale_year Eva_025_scale_year_line G_1D filename    
end
filename2 = 'GLEAM_Eva_1d_Gini_remove_negative_1985_2014.mat';
save(['J:\6-硕士毕业论文\1-Data\GLEAM-V3.8a-025-scale\',filename2],'Gini_1d_Eva_GLEAM','Lon_025','Lat_025')
