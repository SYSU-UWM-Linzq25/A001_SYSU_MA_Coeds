%% 这个文件尝试提取GLEAM的表层土壤含水量数据
%% 根据数据文件，表层土壤湿度变量为SMsurf
%% 数据区分闰年和平年
%% 数据的纬度是递减的，跟CMFD的相反，这里要注意
%% 单位为m³/m³
%% 填充值为-999

clear;clc;

% % 读取CMFD-1d-025-scale的经纬度网格
% load('D:\毕业论文\Data\LLT_025_scale.mat')

% 读取GLEAM经纬度
save_path = ['D:\Data\GlEAM V3.8a Daily\',num2str(2000)];
filename = ['SMsurf_',num2str(2000),'_GLEAM_v3.8a.nc'];
cd(save_path)
nc_info = ncinfo(filename);
Lon_all = ncread(filename,'lon');
Lat_all = ncread(filename,'lat');

% 数据的纬度是递减的，跟CMFD的相反，这里要注意
Lon1 = 69.625;
Lon2 = 140.3750;
Lat1 = 14.6250;
Lat2 = 55.3750;
a = find(Lon_all(:,:) >= Lon1 & Lon_all(:,:)<= Lon2);%经度的指针
b = find(Lat_all(:,:) >= Lat1 & Lat_all(:,:)<= Lat2);%纬度的指针

Lon_GLEAM = Lon_all(a(1):a(end));
Lat_GLEAM = Lat_all(b(1):b(end));
filename2 = 'GlEAM_data_origin_scale_in_CN.mat';
save(['D:\毕业论文\Data\GLEAM V3.8a SMsurf\',filename2],'Lon_GLEAM','Lat_GLEAM');

for year = 1985 :2014
    save_path = ['D:\Data\GlEAM V3.8a Daily\',num2str(year)];
    filename = ['SMsurf_',num2str(year),'_GLEAM_v3.8a.nc'];
    cd(save_path)

    time_all = ncread(filename,'time');
    SM_surf_year = ncread(filename,'SMsurf',[a(1) b(1) 1],[length(a) length(b) length(time_all)]);
    clear save_path filename time_all

    % 填充值处理
    SM_surf_year(SM_surf_year == -999) = nan;

    filename2 = ['SMsurf_CN_in_',num2str(year),'.mat'];
    save(['D:\毕业论文\Data\GLEAM V3.8a SMsurf\',filename2],'SM_surf_year');
    disp([num2str(year),' is done!'])
end

%% 同时再提取实际蒸发
%% 单位为mm/day
%% 填充值为-999

clearvars -except a b

save_path = ['D:\Data\GlEAM V3.8a Daily\',num2str(2000)];
filename = ['E_',num2str(2000),'_GLEAM_v3.8a.nc'];
cd(save_path)
nc_info = ncinfo(filename);


for year = 1985 :2014
    save_path = ['D:\Data\GlEAM V3.8a Daily\',num2str(year)];
    filename = ['E_',num2str(year),'_GLEAM_v3.8a.nc'];
    cd(save_path)

    time_all = ncread(filename,'time');
    Eva_surf_year = ncread(filename,'E',[a(1) b(1) 1],[length(a) length(b) length(time_all)]);
    clear save_path filename time_all

    % 填充值处理
    Eva_surf_year(Eva_surf_year == -999) = nan;

    filename2 = ['Eva_CN_in_',num2str(year),'.mat'];
    save(['D:\毕业论文\Data\GLEAM V3.8a Eva\',filename2],'Eva_surf_year');
    disp([num2str(year),' is done!'])
end



