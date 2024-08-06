%% 这个文件根据CMFD降水升尺度(升到CN051的经纬度范围)的结果
%% 计算升尺度后的AP
%% 注意这里的日尺度降水数据直接从Paper2来，升尺度而来，而并不是直接1d尺度的数据

%% 年降水量的单位为mm
clear;clc;

% 升尺度后的日降水数据
filename2 = ['CMFD_1d_pre_025_scale_in_',num2str(2000),'.mat'];
load(['J:\6-硕士毕业论文\1-Data\CMFD\0-from-paper2\1d-025-scale\',filename2])
clear CMFD_025_scale_pre_1d_preprocessing01_year


AP_1d_01mmh_1979_2018 = nan(length(Lon_CN051),length(Lat_CN051),2018-1979+1);
for year = 1979 : 2018
    filename2 = ['CMFD_1d_pre_025_scale_in_',num2str(year),'.mat'];
    load(['J:\6-硕士毕业论文\1-Data\CMFD\0-from-paper2\1d-025-scale\',filename2]);
    
    % 计算年降水量
    AP_year = nansum(CMFD_025_scale_pre_1d_preprocessing01_year,3)'; % 这里的单位是mm/h
    % 第二种
    AP_1d_01mmh_1979_2018(:,:,year-1978) = AP_year.*24; % 转换为mm
    clear CMFD_025_scale_pre_1d_preprocessing01_year AP_year
    
    disp([num2str(year),' is done!'])
end
clear filename2
filename2 = 'CMFD_AP_1d_01mmh_1979_2018.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\5-2-CMFD-025-scale-AP-and-MAT-01mmh\',filename2],'AP_1d_01mmh_1979_2018','Lon_CN051','Lat_CN051');


AP_1d_01mmh_1985_2014 = AP_1d_01mmh_1979_2018(:,:,7:end-4);
clear AP_1d_01mmh_1979_2018
filename2 = 'CMFD_AP_1d_01mmh_1985_2014.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\5-2-CMFD-025-scale-AP-and-MAT-01mmh\',filename2],'AP_1d_01mmh_1985_2014','Lon_CN051','Lat_CN051');

% %% 画图验证一下，特别是用colorbar验证单位
% [xx,yy] = meshgrid(Lon_CN051,Lat_CN051);
% figure
% pcolor(xx,yy,(AP_year*24)')
% colorbar






