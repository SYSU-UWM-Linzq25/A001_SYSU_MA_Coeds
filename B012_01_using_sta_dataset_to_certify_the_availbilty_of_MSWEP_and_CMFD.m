%% 这个文件使用站点的数据
%% 分别计算CMFD和MSWEP数据与站点数据的RMSE

clear;clc;
filename2 = 'Mutual_Station_preprocessing_data_include_JX_1985_2014.mat';
savepath2 = 'F:\File_of_MATLAB\论文1重置_2022.11.02\data\sta_preprocessing_pre_data_cell\';
load([savepath2,filename2]);
clear savepath2 filename2 station_code

% 首先获取站点的经纬度坐标
% 站点的降水数据是按照0.1mm/day和0.1mm/12h处理的，高于论文的降水阈值，所以需要再处理一下
% 同时数据的每年的长度是366，在不是闰年的时候，最后一个是nan，这样会导致计算基尼系数出错，所以平年要去掉最后一个

for i = 1 : size(Mutual_Sta_Pre_preprocessing_include_JX,1)
    
    Sta_Lat(i) = Mutual_Sta_Pre_preprocessing_include_JX{i,1}(2);
    Sta_Lon(i) = Mutual_Sta_Pre_preprocessing_include_JX{i,1}(3);
    
    Pre_daily_sta_1985_2014 = Mutual_Sta_Pre_preprocessing_include_JX{i,3};
    Pre_subdaily_sta_1985_2014 = Mutual_Sta_Pre_preprocessing_include_JX{i,2};
    
    % 根据年份循环，将日尺度的最后一个去掉，将半日尺度的最后两个去掉
    for year = 1985:2014
        if leapyear(year) == 1 % 闰年
            Pre_daily_sta_year = Pre_daily_sta_1985_2014(year-1984,:);
            Pre_subdaily_sta_year = Pre_daily_sta_1985_2014(year-1984,:);
        else
            Pre_daily_sta_year = Pre_daily_sta_1985_2014(year-1984,1:end-1); % 去除全年最后一个
            Pre_subdaily_sta_year = Pre_daily_sta_1985_2014(year-1984,1:end-2); % 去除全年最后两个
        end
        
        % 降水阈值处理，日尺度是2.4mm以下的不要，半日尺度是1.2mm的不要
        Pre_daily_sta_year(Pre_daily_sta_year < 2.4) = 0;
        Pre_subdaily_sta_year(Pre_subdaily_sta_year < 1.2) = 0;
        
        % 代入计算基尼系数
        Daily_Gini_sta_01mmh_1985_2014(i,year-1984) = ginicoeff(Pre_daily_sta_year,2,true);
        Subdaily_Gini_sta_01mmh_1985_2014(i,year-1984) = ginicoeff(Pre_subdaily_sta_year,2,true);
        
        clear Pre_daily_sta_year Pre_subdaily_sta_year
    end
    disp([num2str(i),' Station is done!'])
    clear Pre_daily_sta_1985_2014 Pre_subdaily_sta_1985_2014
end

filename2 = 'Sta_12h_and_1d_Gini_01mmh_1985_2014.mat';
save(['J:\6-硕士毕业论文\1-Data\Sta_Data_from_V3.0\气象站点数据V3.0-计算的基尼系数\',filename2],'Daily_Gini_sta_01mmh_1985_2014','Subdaily_Gini_sta_01mmh_1985_2014','Sta_Lon','Sta_Lat')

%% 尝试根据站点数据集，在空间上插值到0.1度的CMFD网格
clear;clc;

filename2 = 'Sta_12h_and_1d_Gini_01mmh_1985_2014.mat';
load(['J:\6-硕士毕业论文\1-Data\Sta_Data_from_V3.0\',filename2])

% 0.1度的CMFD经纬度网格
filename2 = 'CMFD_3h_Gini_1979_2018_01mmh.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\3-1-Gini&LinearTrend\',filename2])
clear Gini_CMFD_3h

[xx_01_CMFD,yy_01_CMFD] = meshgrid(Lon,Lat);
xx_01_CMFD = double(xx_01_CMFD)';
yy_01_CMFD = double(yy_01_CMFD)';

Daily_Gini_interp_from_sta_to_01scale = nan(size(xx_01_CMFD,1),size(xx_01_CMFD,2),30);
SubDaily_Gini_interp_from_sta_to_01scale = nan(size(xx_01_CMFD,1),size(xx_01_CMFD,2),30);

for year = 1985 : 2014
    Daily_GI_year = Daily_Gini_sta_01mmh_1985_2014(:,year-1984);
    Subdaily_GI_year = Subdaily_Gini_sta_01mmh_1985_2014(:,year-1984);
    
    Gini_interp_daily = griddata(Sta_Lon,Sta_Lat,Daily_GI_year,xx_01_CMFD,yy_01_CMFD,'linear');
    Gini_interp_subdaily = griddata(Sta_Lon,Sta_Lat,Daily_GI_year,xx_01_CMFD,yy_01_CMFD,'linear');
    clear Daily_GI_year Subdaily_GI_year
    
    Daily_Gini_interp_from_sta_to_01scale(:,:,year-1984) = Gini_interp_daily;
    SubDaily_Gini_interp_from_sta_to_01scale(:,:,year-1984) = Gini_interp_subdaily;
    clear Gini_interp_daily Gini_interp_subdaily
    disp([num2str(year),' is done!'])
end

filename2 = 'Sta_12h_and_1d_Gini_01mmh_1985_2014_interp_to_CMFD_01.mat';
save(['J:\6-硕士毕业论文\1-Data\Sta_Data_from_V3.0\站点插值到CMFD网格\',filename2],'Daily_Gini_interp_from_sta_to_01scale','SubDaily_Gini_interp_from_sta_to_01scale','xx_01_CMFD','yy_01_CMFD')

%% 另外一种，将CMFD和MSWEP插值到站点的位置

clear;clc;

% 0.1度的CMFD经纬度网格
filename2 = 'CMFD_3h_Gini_1979_2018_01mmh.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\3-1-Gini&LinearTrend\',filename2])
clear Gini_CMFD_3h

[xx_01_CMFD,yy_01_CMFD] = meshgrid(Lon,Lat);
xx_01_CMFD = double(xx_01_CMFD)';
yy_01_CMFD = double(yy_01_CMFD)';

% 读取CMFD数据
% 12-hour
clear filename2
filename2 = 'Full Gini index 12h.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\0-from-paper2\12h\full Gini\',filename2])
% 统一选取年份范围为1985-2014
Gini_CMFD_12h_1985_2014 = Full_Gini_12h_all(:,:,7:end-4);
clear Full_Gini_12h_all
% 1-day
clear filename2
filename2 = 'Full Gini index 1d.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\0-from-paper2\1d\full Gini\',filename2])
% 统一选取年份范围为1985-2014
Gini_CMFD_1d_1985_2014 = Full_Gini_1d_all(:,:,7:end-4);
clear Full_Gini_1d_all

% 插值到站点经纬度
filename2 = 'Sta_12h_and_1d_Gini_01mmh_1985_2014.mat';
load(['J:\6-硕士毕业论文\1-Data\Sta_Data_from_V3.0\',filename2])
clear Daily_Gini_sta_01mmh_1985_2014 Subdaily_Gini_sta_01mmh_1985_2014

CMFD_data_interp_sta_subdaily = nan(length(Sta_Lon),2014-1985+1);
CMFD_data_interp_sta_daily = nan(length(Sta_Lon),2014-1985+1);
for i = 1 : size(Gini_CMFD_12h_1985_2014,3)
    clear data_interp_12h data_interp_1d
    data_interp_12h = griddata(xx_01_CMFD, yy_01_CMFD, Gini_CMFD_12h_1985_2014(:,:,i), Sta_Lon, Sta_Lat, 'linear');
    data_interp_1d = griddata(xx_01_CMFD, yy_01_CMFD, Gini_CMFD_12h_1985_2014(:,:,i), Sta_Lon, Sta_Lat, 'linear');
    CMFD_data_interp_sta_subdaily(:,i) = data_interp_12h';
    CMFD_data_interp_sta_daily(:,i) = data_interp_1d';
end

filename2 = 'CMFD_12h_and_1d_Gini_01mmh_1985_2014_interp_to_Sta.mat';
save(['J:\6-硕士毕业论文\1-Data\Sta_Data_from_V3.0\CMFD插值到站点位置\',filename2],'CMFD_data_interp_sta_subdaily','CMFD_data_interp_sta_daily','Sta_Lon','Sta_Lat')

%% MSWEP插值到气象站点位置

clear;clc;

% 0.1度的CMFD经纬度网格
load('F:\File_of_MATLAB\research_of_MSWEP\data\range.mat')
Lat_2 = flip(Lat); % lat是按照递减序列排列的，所以要现改成增序

[xx_01_MSWEP,yy_01_MSWEP] = meshgrid(Lon,Lat_2);
xx_01_MSWEP = double(xx_01_MSWEP)';
yy_01_MSWEP = double(yy_01_MSWEP)';

% 读取MSWEP数据
% 12-hour
load('F:\File_of_MATLAB\research_of_MSWEP\data\Full Gini index 12h preprocessing01.mat')

% 数据的时间尺度从1979-2015，所以只取出其中1985-2014部分
Full_Gini_12h_MWSEP_1985_2014 = Full_Gini_12h_MWSEP(:,:,7:end-1);
clear Full_Gini_12h_MWSEP
% 注意MWSEP在处理过程中，lat是按照递减序列排列的，所以要现改成增序
Full_Gini_12h_MWSEP_1985_2014_rev = nan(size(xx_01_MSWEP,1),size(xx_01_MSWEP,2),size(Full_Gini_12h_MWSEP_1985_2014,3));
for year = 1 : size(Full_Gini_12h_MWSEP_1985_2014,3)
    Full_Gini_12h_MWSEP_year = Full_Gini_12h_MWSEP_1985_2014(:,:,year); %逐年的
    Full_Gini_12h_MWSEP_year_2 = nan(size(Full_Gini_12h_MWSEP_year));
    for i = 1 : length(Lat)
        Full_Gini_12h_MWSEP_year_2(length(Lat)+1-i,:) = Full_Gini_12h_MWSEP_year(i,:);
    end
    Full_Gini_12h_MWSEP_1985_2014_rev(:,:,year) = Full_Gini_12h_MWSEP_year_2';
    clear Full_Gini_12h_MWSEP_year_2 Full_Gini_12h_MWSEP_year
end

% 1-day
% 读取MSWEP数据
load('F:\File_of_MATLAB\research_of_MSWEP\data\Full Gini index 1d preprocessing01.mat')

% 数据的时间尺度从1979-2015，所以只取出其中1985-2014部分
Full_Gini_1d_MWSEP_1985_2014 = Full_Gini_1d_MWSEP(:,:,7:end-1);
clear Full_Gini_1d_MWSEP
% 注意MWSEP在处理过程中，lat是按照递减序列排列的，所以要现改成增序
Full_Gini_1d_MWSEP_1985_2014_rev = nan(size(xx_01_MSWEP,1),size(xx_01_MSWEP,2),size(Full_Gini_1d_MWSEP_1985_2014,3));
for year = 1 : size(Full_Gini_1d_MWSEP_1985_2014,3)
    Full_Gini_1d_MWSEP_year = Full_Gini_1d_MWSEP_1985_2014(:,:,year); %逐年的
    Full_Gini_1d_MWSEP_year_2 = nan(size(Full_Gini_1d_MWSEP_year));
    for i = 1 : length(Lat)
        Full_Gini_1d_MWSEP_year_2(length(Lat)+1-i,:) = Full_Gini_1d_MWSEP_year(i,:);
    end
    Full_Gini_1d_MWSEP_1985_2014_rev(:,:,year) = Full_Gini_1d_MWSEP_year_2';
    clear Full_Gini_1d_MWSEP_year_2 Full_Gini_1d_MWSEP_year
end
clear Full_Gini_12h_MWSEP_1985_2014 Full_Gini_1d_MWSEP_1985_2014 Lat


% 插值到站点经纬度
filename2 = 'Sta_12h_and_1d_Gini_01mmh_1985_2014.mat';
load(['J:\6-硕士毕业论文\1-Data\Sta_Data_from_V3.0\气象站点数据V3.0-计算的基尼系数\',filename2])
clear Daily_Gini_sta_01mmh_1985_2014 Subdaily_Gini_sta_01mmh_1985_2014

MSWEP_data_interp_sta_subdaily = nan(length(Sta_Lon),2014-1985+1);
MSWEP_data_interp_sta_daily = nan(length(Sta_Lon),2014-1985+1);
for i = 1 : size(Full_Gini_12h_MWSEP_1985_2014_rev,3)
    clear data_interp_12h data_interp_1d
    data_interp_12h = griddata(xx_01_MSWEP, yy_01_MSWEP, Full_Gini_12h_MWSEP_1985_2014_rev(:,:,i), Sta_Lon, Sta_Lat, 'linear');
    data_interp_1d = griddata(xx_01_MSWEP, yy_01_MSWEP, Full_Gini_1d_MWSEP_1985_2014_rev(:,:,i), Sta_Lon, Sta_Lat, 'linear');
    MSWEP_data_interp_sta_subdaily(:,i) = data_interp_12h';
    MSWEP_data_interp_sta_daily(:,i) = data_interp_1d';
end

filename2 = 'MSWEP_12h_and_1d_Gini_01mmh_1985_2014_interp_to_Sta.mat';
save(['J:\6-硕士毕业论文\1-Data\Sta_Data_from_V3.0\MSWEP插值到站点位置\',filename2],'MSWEP_data_interp_sta_subdaily','MSWEP_data_interp_sta_daily','Sta_Lon','Sta_Lat')
