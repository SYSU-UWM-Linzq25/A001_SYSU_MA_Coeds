%% 这个文件将对CMFD的温度数据进行处理
%% 时间范围为1979-2018
%% 两种时间尺度: 3-hour和1-day
%% 年均温

%% 3-hour
clear;clc;

% 与温度的经纬度是相同的
% save_path = 'N:\Data\CMFD\Prec_3h\未预处理\3h\';
% cd(save_path)
% load('LLT.mat')

path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')
cd('J:\2-Data\8-气温数据\CMFD-3h\')
Lon = ncread('temp_ITPCAS-CMFD_V0106_B-01_03hr_010deg_197902.nc','lon');
Lat = ncread('temp_ITPCAS-CMFD_V0106_B-01_03hr_010deg_197902.nc','lat');

for year = 1979 : 2018
    if leapyear(year) ~= 1
        Temp_3h_noprocessing = nan(length(Lon),length(Lat),365*8);
    else
        Temp_3h_noprocessing = nan(length(Lon),length(Lat),366*8);
    end
    for month = 1 : 12
        if month < 10
            time1 = begin_time(year,month,3);
            time2 = end_time(year,month,3);
            month2 = ['0',num2str(month)];
            filename =  ['temp_ITPCAS-CMFD_V0106_B-01_03hr_010deg_',num2str(year),month2,'.nc'];
            temp = ncread(filename,'temp');
            Temp_3h_noprocessing(:,:,time1:time2) = temp;
        else
            filename = ['temp_ITPCAS-CMFD_V0106_B-01_03hr_010deg_',num2str(year),num2str(month),'.nc'];
            temp = ncread(filename,'temp');
            time1 = begin_time(year,month,3);
            time2 = end_time(year,month,3);
            Temp_3h_noprocessing(:,:,time1:time2) = temp;
        end
        clear temp time1 time2 filename month2
    end
    filename2 = ['Temp_3h_no_preprocessing_',num2str(year),'.mat'];
    save(['J:\6-硕士毕业论文\1-Data\CMFD\1-origin-data-3h\Temp\',filename2],'Temp_3h_noprocessing','Lon','Lat');
    disp([num2str(year),' is done!'])
    clear Temp_3h_noprocessing filename2
end

%% 从3-hour原始数据出发，转换单位为摄氏度，并计算年均温

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
filename2 = 'MAT_3h_1979_2018.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\4-2-MAT\',filename2],'MAT_3h','Lon','Lat');

%% 1-day
clear;clc;
cd('J:\2-Data\8-气温数据\CMFD-1d\');
filename = 'temp_ITPCAS-CMFD_V0106_B-01_01dy_010deg_200001-200012.nc';
nc_info_1 = ncinfo(filename);
Lat = ncread(filename,'lat');
Lon = ncread(filename,'lon');

for year = 1979 : 2018
    filename =  ['temp_ITPCAS-CMFD_V0106_B-01_01dy_010deg_',num2str(year),'01-',num2str(year),'12.nc'];
    temp_1d_noprocessing = ncread(filename,'temp');
    
    filename2 = ['Temp_1d_no_preprocessing_',num2str(year),'.mat'];
    save(['J:\6-硕士毕业论文\1-Data\CMFD\2-origin-data-1d\Temp\',filename2],'temp_1d_noprocessing','Lon','Lat');
    disp([num2str(year),' is done!'])
    clear temp_1d_noprocessing filename2 filename
end

%% 从1-day原始数据出发，转换单位为摄氏度，并计算年均温

clear;clc;
cd('J:\6-硕士毕业论文\1-Data\CMFD\2-origin-data-1d\Temp\')
load('Temp_1d_no_preprocessing_2000.mat')
clear temp_1d_noprocessing
MAT_1d = nan(length(Lon),length(Lat),2018-1979+1);

for year = 1979 : 2018
    filename = ['Temp_1d_no_preprocessing_',num2str(year)];
    load(filename)
    Temp_1d = temp_1d_noprocessing - 273.15; % 转换为摄氏度
    
    % 计算年均温
    MAT_1d(:,:,year-1978) = nanmean(Temp_1d,3);
    disp([num2str(year),' is done!'])
    clear Temp_1d temp_1d_noprocessing
end

filename2 = 'MAT_1d_1979_2018.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\4-2-MAT\',filename2],'MAT_1d','Lon','Lat');
