%% 进一步处理CN051数据，包括单位，填充值等
%% 降水单位为mm/day，不用转了
%% 温度单位为摄氏度，不用转了
%% 并按年分好

clear;clc;
cd('J:\2-Data\1-Precpitation Data\2-Station\降水站点数据网格插值-CN051\')
    
ncinfo_1 = ncinfo('CN05.1_Pre_1961_2020_daily_025x025.nc');
ncinfo_2 = ncinfo('CN05.1_Tm_1961_2020_daily_025x025.nc');

load('J:\6-硕士毕业论文\1-Data\CN051-TM-Pre-1979-2018\CN051_Pre_1979_2018.mat')
load('J:\6-硕士毕业论文\1-Data\CN051-TM-Pre-1979-2018\CN051_Tm_1979_2018.mat')

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

for year = 1979 : 2018
    CN051_Pr_year = Pre_CN051_1979_2018(:,:,year_data_index(year-1978,1):year_data_index(year-1978,2));
    CN051_Tm_year = Tm_CN051_1979_2018(:,:,year_data_index(year-1978,1):year_data_index(year-1978,2));
    
    filename2 = ['CN051_Daily_Tm_Pr_in_',num2str(year),'.mat'];
    save(['J:\6-硕士毕业论文\1-Data\CN051-TM-Pre-1979-2018\By-year\',filename2],'CN051_Pr_year','CN051_Tm_year','Lon','Lat')
    
    disp([num2str(year),' is done!'])
    clear CN051_Pr_year CN051_Tm_year
end

