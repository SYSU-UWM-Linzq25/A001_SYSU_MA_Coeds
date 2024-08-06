%% 这个文件根据新下载的MSWEP数据，时间分辨率为3h，空间分辨率变为0.1°
%% 研究时段延长为1979-2018年
%% 对数据进行处理


%% 首先验证公众号下载与官网下载有无重大区别
%% 同时确定是站点矫正版本还是非矫正版本 
clear;clc;

% 根据CMFD经纬度网格进行提取
cd('F:\File_of_MATLAB\关于3h尺度的CMFD降水数据研究2022.3.2\Data\')
filename = 'LLT.mat';
load(filename);

filename2 = '1979091.00.nc';

% 公众号数据
cd('J:\2-Data\1-Precpitation Data\1-Products\New_MSWEP\1979-2020MSWEP降水数据\3hourly\1979-1986\1979-1986\')
ncinfo_1 = ncinfo(filename2);

Lon_all = ncread(filename2,'lon');
Lat_all = ncread(filename2,'lat');
time_all = ncread(filename2,'time');

% 这里的经纬度两位以后的小数还有，得先强制保留两位以后才能提取
Lon_all_2 = roundn(Lon_all,-2);
Lat_all_2 = roundn(Lat_all,-2);

% 中国的经纬度范围
Lon1 = min(Lon_3h_scale);
Lon2 = max(Lon_3h_scale);
Lat1 = min(Lat_3h_scale);
Lat2 = max(Lat_3h_scale);
a = find(Lon_all_2(:,:) >= Lon1 & Lon_all_2(:,:)<= Lon2);%经度的指针
b = find(Lat_all_2(:,:) >= Lat1 & Lat_all_2(:,:)<= Lat2);%纬度的指针
lon_num=length(a);
lat_num=length(b);
% 读取对应经纬度并保存
Lon = Lon_all(a(1):a(end));
Lat = Lat_all(b(1):b(end));

Pr_3h = ncread(filename2,'precipitation',[a(1) b(1) 1],[length(Lon) length(Lat) length(time_all)]);

clearvars -except Pr_3h Lon Lat time_all ncinfo_1 a b filename2
% 官网下载-nogauaged
cd('J:\2-Data\1-Precpitation Data\1-Products\New_MSWEP\From-MSWEP官网\Past-unGauged\3-hour\')
ncinfo_2 = ncinfo(filename2);

Pr_3h_2 = ncread(filename2,'precipitation',[a(1) b(1) 1],[length(Lon) length(Lat) length(time_all)]);

diff_1 = Pr_3h - Pr_3h_2;
any(any(diff_1)) 

% 结果不一致

% 官网下载-gauaged
cd('J:\2-Data\1-Precpitation Data\1-Products\New_MSWEP\From-MSWEP官网\Past-Gauged\3-hour\')
ncinfo_3 = ncinfo(filename2);

Pr_3h_3 = ncread(filename2,'precipitation',[a(1) b(1) 1],[length(Lon) length(Lat) length(time_all)]);
diff_2 = Pr_3h - Pr_3h_3;
any(any(diff_2)) 
% 结果表明公众号的数据便是有站点矫正的数据

%% 遍历公众号数据，找寻其中缺少的数据
%% 根据缺少的可以针对性在官网处下载补充
clear;clc;

save_path_1 = 'J:\2-Data\1-Precpitation Data\1-Products\New_MSWEP\1979-2020MSWEP降水数据\3hourly\';
namelist_all = dir(save_path_1);
name_list = {namelist_all(:).name};

hour_period = {'00','03','06','09','12','15','18','21'};

index1 = 1;
for year = 1979 : 2020
    for day = 1 : leapyear(year) + 365
        for m = 1 : length(hour_period)
            if day < 10
                filename = [num2str(year),'00',num2str(day),'.',hour_period{m},'.nc'];
            elseif day < 100
                filename = [num2str(year),'0',num2str(day),'.',hour_period{m},'.nc'];
            elseif day >= 100
                filename = [num2str(year),num2str(day),'.',hour_period{m},'.nc'];
            end
            file_ind_1 = contains(name_list,filename); % 是否包含文件名
            k1 = find(file_ind_1 == 1);
            if isempty(k1)
                Lack_filename{index1} = filename;
                index1 = index1 + 1;
            end
            clear filename k1 file_ind_1
        end
        disp([num2str(day),' of ',num2str(year),' is done!'])
    end
end

filename2 = 'Data_lack_index.mat';
save(['J:\2-Data\1-Precpitation Data\1-Products\New_MSWEP\1979-2020MSWEP降水数据\',filename2],'Lack_filename')

%% 主体是公众号提供的数据
%% 缺少的数据使用的是官网补充的没有站点校正的版本



