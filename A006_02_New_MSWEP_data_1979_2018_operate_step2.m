%% 这个文件根据新的MSWEP数据进行提取

clear;clc;

save_path_1 = 'J:\2-Data\1-Precpitation Data\1-Products\New_MSWEP\1979-2020MSWEP降水数据\3hourly\';
save_path_2 = 'J:\2-Data\1-Precpitation Data\1-Products\New_MSWEP\1979-2020MSWEP降水数据\3hourl-lack-supply';
namelist_all = dir(save_path_1);
name_list = {namelist_all(:).name};
clear namelist_all
namelist_all = dir(save_path_2);
name_list_2 = {namelist_all(:).name};

% 根据CMFD经纬度网格进行提取
cd('F:\File_of_MATLAB\关于3h尺度的CMFD降水数据研究2022.3.2\Data\')
filename = 'LLT.mat';
load(filename);

filename2 = '1979091.00.nc';

cd(save_path_1)
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
% 读取中国地区对应经纬度并保存
Lon = Lon_all(a(1):a(end));
Lat = Lat_all(b(1):b(end));

hour_period = {'03','06','09','12','15','18','21','00'};
clearvars -except time_all Lon Lat hour_period hour_period name_list name_list_2 save_path_2 save_path_1 a b
for year = 2007
    Pre_China_year = nan(length(Lon),length(Lat),(leapyear(year) + 365)*8);
    for day = 1 : leapyear(year) + 365
        for m = 1 : length(hour_period)
            if day < 10
                filename = [num2str(year),'00',num2str(day),'.',hour_period{m},'.nc'];
            elseif day < 100
                filename = [num2str(year),'0',num2str(day),'.',hour_period{m},'.nc'];
            elseif day >= 100
                filename = [num2str(year),num2str(day),'.',hour_period{m},'.nc'];
            end            
            file_ind_1 = contains(name_list,filename); % 在公众号提供的数据中
            file_ind_2 = contains(name_list_2,filename); % 在补充文件中
            k1 = find(file_ind_1 == 1);
            k2 = find(file_ind_2 == 1);
            
            if isempty(k1)
                cd(save_path_2)
                Pre_China_year(:,:,(day-1)*8 + m) = ncread(filename,'precipitation',[a(1) b(1) 1],[length(Lon) length(Lat) length(time_all)]);
            else
                cd(save_path_1)
                Pre_China_year(:,:,(day-1)*8 + m) = ncread(filename,'precipitation',[a(1) b(1) 1],[length(Lon) length(Lat) length(time_all)]);
            end
            k = find(Pre_China_year == -9999); % 找缺省值
            Pre_China_year(k) = nan; % 将缺省值用nan表示
            clear file_ind_1 file_ind_2 k1 k2 k filename 
        end
        disp([num2str(day),' of ',num2str(year),' is done!'])
    end
    filename2 = ['MSWEP_Pre_China_in_',num2str(year),'.mat'];
    save(['J:\6-硕士毕业论文\1-Data\MSWEP_Data_1979_2020\1-origin-data-CN\',filename2],'Pre_China_year','Lon','Lat');
    clear filename2 Pre_China_year
end

% % 检验提取的位置是否正确
% % 包括提取的值是否与经纬度位置对应(对应）
% Pr_MSWEP_world = ncread('1979005.09.nc','precipitation');
% Lon_all = ncread('1979005.09.nc','lon');
% Lat_all = ncread('1979005.09.nc','lat');
% 
% Pre_China_year(150,200,35)
% k1 = find(Lon_all == Lon(150));
% k2 = find(Lat_all == Lat(200));
% 
% Pr_MSWEP_world(k1,k2)
% % 以及提取的时间是否对应(对应)
% Pre_China_year(150,200,35)
% Pr_MSWEP = ncread('1979005.09.nc','precipitation',[a(1) b(1) 1],[length(Lon) length(Lat) length(time_all)]);
% Pr_MSWEP(150,200)

%% 从3h尺度升尺度到6-hour、12-hour和1-day
%% 但是先进行了0.1mm/h的阈值处理
%% 6-hour

clear;clc;
path(path,'J:\4-论文备份\论文代码2021.4.14\tool');
cd('J:\6-硕士毕业论文\1-Data\MSWEP_Data_1979_2020\1-origin-data-CN\')

for year = 1979 : 2018
    filename = ['MSWEP_Pre_China_in_',num2str(year),'.mat'];
    load(['J:\6-硕士毕业论文\1-Data\MSWEP_Data_1979_2020\1-origin-data-CN\',filename]);
    
    % 降水阈值处理，0.1mm/h
    Pre_China_year(Pre_China_year < 0.3) = 0;    
    
    Pre_6h_preprocessing01_year = turn_3h_6h(Pre_China_year); % 这里记得清除，不然容易数据的范围出错
    filename2 = ['pre2(6h)_',num2str(year),'.mat'];
    save(['J:\6-硕士毕业论文\1-Data\MSWEP_Data_1979_2020\1-1-different-time-scale\6-hour\',filename2],'Pre_6h_preprocessing01_year');
    disp([num2str(year),' is done!'])    
    clear Pre_6h_preprocessing01_year Pre_China_year filename2
end


%% 12-hour

clear;clc;
path(path,'J:\4-论文备份\论文代码2021.4.14\tool');
cd('J:\6-硕士毕业论文\1-Data\MSWEP_Data_1979_2020\1-origin-data-CN\')

for year = 1979 : 2018
    filename = ['MSWEP_Pre_China_in_',num2str(year),'.mat'];
    load(['J:\6-硕士毕业论文\1-Data\MSWEP_Data_1979_2020\1-origin-data-CN\',filename]);
    
    % 降水阈值处理，0.1mm/h
    Pre_China_year(Pre_China_year < 0.3) = 0;    
    
    pre_12h_preprocessing01_year = turn_3h_12h(Pre_China_year); % 这里记得清除，不然容易数据的范围出错
    filename2 = ['pre3(12h)_',num2str(year),'.mat'];
    save(['J:\6-硕士毕业论文\1-Data\MSWEP_Data_1979_2020\1-1-different-time-scale\12-hour\',filename2],'pre_12h_preprocessing01_year');
    disp([num2str(year),' is done!'])    
    clear pre_12h_preprocessing01_year Pre_China_year filename2
end

% 1-day

clear;clc;
path(path,'J:\4-论文备份\论文代码2021.4.14\tool');
cd('J:\6-硕士毕业论文\1-Data\MSWEP_Data_1979_2020\1-origin-data-CN\')

for year = 1979 : 2018
    filename = ['MSWEP_Pre_China_in_',num2str(year),'.mat'];
    load(['J:\6-硕士毕业论文\1-Data\MSWEP_Data_1979_2020\1-origin-data-CN\',filename]);
    
    % 降水阈值处理，0.1mm/h
    Pre_China_year(Pre_China_year < 0.3) = 0;    
    
    pre_1d_preprocessing01_year = turn_3h_1d(Pre_China_year); % 这里记得清除，不然容易数据的范围出错
    filename2 = ['pre4(1d)_',num2str(year),'.mat'];
    save(['J:\6-硕士毕业论文\1-Data\MSWEP_Data_1979_2020\1-1-different-time-scale\1-day\',filename2],'pre_1d_preprocessing01_year');
    disp([num2str(year),' is done!'])    
    clear pre_1d_preprocessing01_year Pre_China_year filename2
end
