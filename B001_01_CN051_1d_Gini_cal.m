%% 首先按年提取CN051降水数据，并计算基尼系数
%% 这里设置了两种阈值，一种是日尺度小于0.1 mm/day
%% 一种是对应英文文章中的3h尺度降水阈值0.1 mm/h 转化为 2.4 mm/day
%% 注意因为阈值的采用，西北沙漠地区出现人工全年未降雨，此时应该赋值为nan
%% 使用full_Gini会人工赋值为0，是不行的
%% 0.1 mm/h

clear;clc;
path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')
cd('J:\2-Data\1-Precpitation Data\2-Station\降水站点数据网格插值-CN051\')

ncinfo_1 = ncinfo('CN05.1_Pre_1961_2020_daily_025x025.nc');
ncinfo_2 = ncinfo('CN05.1_Tm_1961_2020_daily_025x025.nc');

load('J:\6-硕士毕业论文\1-Data\CN051-TM-Pre-1979-2018\1-origin-data\CN051_Pre_1979_2018.mat')


% 计算每一年的天数
clear i
day_year_all = nan(length(1979:2018),1);
for i = 1 : length(day_year_all)
    day_year_all(i) = leapyear(i + 1978) + 365; % 考虑润平年
    % day_year_all(i) = 365; % 不考虑润平年
end

% 计算相应年份的提取间隔
year_data_index = nan(length(1979:2018),2);
for n = 1979:2018
    year_data_index(n-1978,1) = 1 + sum(day_year_all(1 : n - 1979));
    year_data_index(n-1978,2) = sum(day_year_all(1 : n - 1979 + 1));
end

Gini_CN051 = nan(size(Pre_CN051_1979_2018,1),size(Pre_CN051_1979_2018,2),2018-1979+1);
for year = 1979 : 2018
    CN051_Pr_year = Pre_CN051_1979_2018(:,:,year_data_index(year-1978,1):year_data_index(year-1978,2));
    
    % 降水阈值处理
    CN051_Pr_year(CN051_Pr_year < 2.4) = 0;
    
    % 转2D
    CN051_Pr_year_2D = reshape(CN051_Pr_year,[],size(CN051_Pr_year,3));
    
    % 基尼系数计算
    % 按照行计算
    G_1D = ginicoeff(CN051_Pr_year_2D,2,true);
    
    % 基尼系数计算
    Gini_CN051(:,:,year-1978) = reshape(G_1D,[size(CN051_Pr_year,1),size(CN051_Pr_year,2)]);
    disp([num2str(year),' is done!'])
    clear CN051_Pr_year CN051_Pr_year_2D G_1D filename
end

filename2 = 'CN051_Daily_Gini_1979_2018_01mmh.mat';
save(['J:\6-硕士毕业论文\1-Data\CN051-TM-Pre-1979-2018\3-CN051-Pr-Gini&LinearTrend\',filename2],'Gini_CN051','Lon','Lat')

% 测试
% CN051_Pr_year_1 = nansum(CN051_Pr_year,3);
% [xx,yy] = meshgrid(Lon,Lat);
% figure
% pcolor(xx,yy,Gini_CN051(:,:,1)')
% 
% colorbar


%% 0.1 mm/day
clear;clc;
path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')
cd('J:\2-Data\1-Precpitation Data\2-Station\降水站点数据网格插值-CN051\')

ncinfo_1 = ncinfo('CN05.1_Pre_1961_2020_daily_025x025.nc');
ncinfo_2 = ncinfo('CN05.1_Tm_1961_2020_daily_025x025.nc');

load('J:\6-硕士毕业论文\1-Data\CN051-TM-Pre-1979-2018\1-origin-data\CN051_Pre_1979_2018.mat')

% 计算每一年的天数
clear i
day_year_all = nan(length(1979:2018),1);
for i = 1 : length(day_year_all)
    day_year_all(i) = leapyear(i + 1978) + 365; % 考虑润平年
    % day_year_all(i) = 365; % 不考虑润平年
end

% 计算相应年份的提取间隔
year_data_index = nan(length(1979:2018),2);
for n = 1979:2018
    year_data_index(n-1978,1) = 1 + sum(day_year_all(1 : n - 1979));
    year_data_index(n-1978,2) = sum(day_year_all(1 : n - 1979 + 1));
end

Gini_CN051 = nan(size(Pre_CN051_1979_2018,1),size(Pre_CN051_1979_2018,2),2018-1979+1);
for year = 1979 : 2018
    CN051_Pr_year = Pre_CN051_1979_2018(:,:,year_data_index(year-1978,1):year_data_index(year-1978,2));
    
    % 降水阈值处理
    CN051_Pr_year(CN051_Pr_year < 0.1) = 0;
    
    % 转2D
    CN051_Pr_year_2D = reshape(CN051_Pr_year,[],size(CN051_Pr_year,3));
    
    % 基尼系数计算
    % 按照行计算
    G_1D = ginicoeff(CN051_Pr_year_2D,2,true);
    
    % 基尼系数计算
    Gini_CN051(:,:,year-1978) = reshape(G_1D,[size(CN051_Pr_year,1),size(CN051_Pr_year,2)]);
    disp([num2str(year),' is done!'])
    clear CN051_Pr_year CN051_Pr_year_2D G_1D filename
end

filename2 = 'CN051_Daily_Gini_1979_2018_01mmday.mat';
save(['J:\6-硕士毕业论文\1-Data\CN051-TM-Pre-1979-2018\3-CN051-Pr-Gini&LinearTrend\',filename2],'Gini_CN051','Lon','Lat')
