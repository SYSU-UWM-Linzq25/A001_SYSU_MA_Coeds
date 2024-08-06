%% 这个文件根据MSWEP数据，计算年降水量
%% 为后面计算相关系数做准备
%% 直接用3h的数据整，但是要经过阈值处理的
%% 3-hour

clear;clc;
path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')
load('J:\6-硕士毕业论文\1-Data\MSWEP-V280-1985-2014\range.mat')

AP_CN_MSWEP_1985_2014 = nan(length(Lat),length(Lon),2014-1985+1);
cd('F:\File_of_MATLAB\research_of_MSWEP\data\Pre_China_orign\')
for year = 1985 : 2014 
    clear filename filename2 filename3  
    filename = ['Pre_China_in_',num2str(year)];
    load(filename)
    % 转换成降水率
    Pre_rate_China_year = Pre_China_year ./3;
    clear Pre_China_year
    k = find(Pre_rate_China_year(:,:,:) < 0.1 ); % 数据预处理，将小于0.1的均去掉
    Pre_rate_China_year(k) = 0;
    
    % 计算年降水量，单位mm
    AP_CN_year_MSWEP = nansum(Pre_rate_China_year,3) .* 3;
    
    % 去除求和为0的
    AP_CN_year_MSWEP(AP_CN_year_MSWEP == 0) = nan;
    
    AP_CN_MSWEP_1985_2014(:,:,year-1984) = AP_CN_year_MSWEP;
    
    clear AP_CN_year_MSWEP Pre_rate_China_year
    disp([num2str(year),' is done!'])
end

filename2 = 'AP_CN_MSWEP_1985_2014.mat';
save(['J:\6-硕士毕业论文\1-Data\MSWEP-V280-1985-2014\005-AP-025-scale\',filename2],'AP_CN_MSWEP_1985_2014');
