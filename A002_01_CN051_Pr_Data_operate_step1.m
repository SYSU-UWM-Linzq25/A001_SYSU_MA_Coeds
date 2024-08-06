%% 这个文件处理CN051-daily-数据
%% 考虑润平年

clear;clc;

cd('J:\2-Data\1-Precpitation Data\2-Station\降水站点数据网格插值-CN051\')
    
ncinfo_1 = ncinfo('CN05.1_Pre_1961_2020_daily_025x025.nc');
ncinfo_2 = ncinfo('CN05.1_Tm_1961_2020_daily_025x025.nc');

Lon = ncread('CN05.1_Pre_1961_2020_daily_025x025.nc','lon');
Lat = ncread('CN05.1_Pre_1961_2020_daily_025x025.nc','lat');
time = ncread('CN05.1_Pre_1961_2020_daily_025x025.nc','time');

day_year = nan(2020-1961+1,1);
for year = 1961 : 2020
   day_year(year-1960,1) = leapyear(year) + 365; 
end

year_index = nan(2020-1961+1,2);
for year = 1961 : 2020
   year_index(year-1960,1) = 1 + sum(day_year(1 : year-1961)); 
   year_index(year-1960,2) = sum(day_year(1 : year-1960)); 
end

% 读取数据中1979-2018的部分
Pre_CN051_1979_2018 = ncread('CN05.1_Pre_1961_2020_daily_025x025.nc','pre',[1 1 year_index(1979-1960,1)],[length(Lon) length(Lat) year_index(2018-1960,2) - year_index(1979-1960,1) + 1]);
filename = 'CN051_Pre_1979_2018.mat';
save(['J:\6-硕士毕业论文\1-Data\CN051-TM-Pre-1979-2018\',filename],'Pre_CN051_1979_2018','Lon','Lat')
clear Pre_CN051_1979_2018

Tm_CN051_1979_2018 = ncread('CN05.1_Tm_1961_2020_daily_025x025.nc','tm',[1 1 year_index(1979-1960,1)],[length(Lon) length(Lat) year_index(2018-1960,2) - year_index(1979-1960,1) + 1]);
filename = 'CN051_Tm_1979_2018.mat';
save(['J:\6-硕士毕业论文\1-Data\CN051-TM-Pre-1979-2018\',filename],'Tm_CN051_1979_2018','Lon','Lat')
clear Tm_CN051_1979_2018
