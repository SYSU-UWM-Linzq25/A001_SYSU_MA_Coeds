%% 这个文件将计算CMFD-3h数据下，的年均温和年降水量情况
%% 降水量的阈值为0.1mm/h
%% 空间尺度为原始的CMFD尺度-0.1°

%% 年均温的计算，单位为℃
clear;clc;
cd('J:\6-硕士毕业论文\1-Data\CMFD\1-origin-data-3h\Temp\')
load('Temp_3h_no_preprocessing_2000.mat')
clear Temp_3h_noprocessing
MAT_3h = nan(length(Lon),length(Lat),2018-1979+1);

for year = 1979 : 2018
    filename = ['Temp_3h_no_preprocessing_',num2str(year)];
    load(filename)
    Temp_3h = Temp_3h_noprocessing - 273.15; % 转换为摄氏度
    
    % 计算年均温
    MAT_3h(:,:,year-1978) = nanmean(Temp_3h,3);
    disp([num2str(year),' is done!'])
    clear Temp_3h Temp_3h_noprocessing
end
filename2 = 'MAT_3h_01mmh_1979_2018.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\5-1-CMFD-01-scale-AP-and-MAT-01mmh\',filename2],'MAT_3h','Lon','Lat');

%% 画图验证一下，特别是用colorbar验证单位
clear;clc;

load('J:\6-硕士毕业论文\1-Data\CMFD\5-1-CMFD-01-scale-AP-and-MAT-01mmh\MAT_3h_01mmh_1979_2018.mat')
[xx,yy] = meshgrid(Lon,Lat);
MAT_3h_mean = nanmean(MAT_3h,3)';
figure
pcolor(xx,yy,MAT_3h_mean)
colorbar

%% 年降水量的计算
%% 年降水量的单位为mm

% 3h
clear;clc;

filename2 = ['pre1_3h_no_preprocessing_',num2str(2000),'.mat'];
load(['J:\6-硕士毕业论文\1-Data\CMFD\1-origin-data-3h\',filename2]);
clear pre_3h_noprocessing

AP_3h_01mmh = nan(length(Lon),length(Lat),2018-1979+1);
for year = 1979 : 2018
    filename2 = ['pre1_3h_no_preprocessing_',num2str(year),'.mat'];
    load(['J:\6-硕士毕业论文\1-Data\CMFD\1-origin-data-3h\',filename2]);
    
    % 第二种
    pre_3h_01mmh = pre_3h_noprocessing;
    pre_3h_01mmh(pre_3h_01mmh < 0.1) = 0;
    AP_3h_01mmh(:,:,year-1978) = nansum(pre_3h_01mmh,3).*3;
    clear pre_3h_01mmh
    
    disp([num2str(year),' is done!'])   
end
clear filename2
filename2 = 'AP_3h_01mmh_1979_2018.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\4-Annual-Pr\',filename2],'AP_3h_01mmh','Lon','Lat');

%% 画图验证一下，特别是用colorbar验证单位
clear;clc;

load('J:\6-硕士毕业论文\1-Data\CMFD\5-1-CMFD-01-scale-AP-and-MAT-01mmh\AP_3h_01mmh_1979_2018.mat')
[xx,yy] = meshgrid(Lon,Lat);
AP_3h_mean = nanmean(Annual_Pr_3h_01mmh,3)';
figure
pcolor(xx,yy,AP_3h_mean)
colorbar



