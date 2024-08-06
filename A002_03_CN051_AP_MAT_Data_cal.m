%% 这个文件根据A002_01_CN051_Pr_Data_operate_step1
%% 提取出来的按年整理的CN051温度
%% 然后再计算年均温
%% 还有年降水量

clear;clc;
load('J:\6-硕士毕业论文\1-Data\CN051-TM-Pre-1979-2018\2-data-By-year\CN051_Daily_Tm_Pr_in_2000.mat')
clear CN051_Pr_year CN051_Tm_year

CN051_MAT_year = nan(length(Lon),length(Lat),2018-1979+1);
for year = 1979 : 2018
    filename2 = ['CN051_Daily_Tm_Pr_in_',num2str(year),'.mat'];
    load(['J:\6-硕士毕业论文\1-Data\CN051-TM-Pre-1979-2018\2-data-By-year\',filename2])
    
    
    CN051_MAT_year(:,:,year-1978) = nanmean(CN051_Tm_year,3);
    
    disp([num2str(year),' is done!'])
    clear CN051_Pr_year CN051_Tm_year
end

filename2 = 'CN051_Daily_MAT_1979_2018.mat';
save(['J:\6-硕士毕业论文\1-Data\CN051-TM-Pre-1979-2018\4-AP-and-MAT\',filename2],'CN051_MAT_year','Lon','Lat')


clear;clc;
load('J:\6-硕士毕业论文\1-Data\CN051-TM-Pre-1979-2018\2-data-By-year\CN051_Daily_Tm_Pr_in_2000.mat')
clear CN051_Pr_year CN051_Tm_year

CN051_AP_year = nan(length(Lon),length(Lat),2018-1979+1);
for year = 1979 : 2018
    filename2 = ['CN051_Daily_Tm_Pr_in_',num2str(year),'.mat'];
    load(['J:\6-硕士毕业论文\1-Data\CN051-TM-Pre-1979-2018\2-data-By-year\',filename2])
    
    
    CN051_AP_year(:,:,year-1978) = nansum(CN051_Pr_year,3);
    
    disp([num2str(year),' is done!'])
    clear CN051_Pr_year CN051_Tm_year
end

filename2 = 'CN051_Daily_AP_1979_2018.mat';
save(['J:\6-硕士毕业论文\1-Data\CN051-TM-Pre-1979-2018\4-AP-and-MAT\',filename2],'CN051_AP_year','Lon','Lat')
