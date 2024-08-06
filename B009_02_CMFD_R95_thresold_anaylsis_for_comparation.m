%% 这个文件将针对历史时期的CMFD降水数据进行分降水类型研究
%% 后续再将未来时期的降水类型进行划分

%% 采用ETCCDI指数中的R95p——日降水量 > 95%分位数的年累积降水量

%% 3-hour
clear;clc;
path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')
filename_1 = ['pre1_3h_no_preprocessing_',num2str(2000),'.mat'];
load(['J:\6-硕士毕业论文\1-Data\CMFD\1-origin-data-3h\Pre\',filename_1])
clear pre_3h_noprocessing

R95p_thresold_year = nan(length(Lon),length(Lat),2014-1985+1);

for year = 1985:2014
    filename_1 = ['pre1_3h_no_preprocessing_',num2str(year),'.mat'];
    load(['J:\6-硕士毕业论文\1-Data\CMFD\1-origin-data-3h\Pre\',filename_1])
    
    % 首先进行预处理
    pre_3h_processing01 = pre_3h_noprocessing;
    clear pre_3h_noprocessing
    pre_3h_processing01(pre_3h_processing01 < 0.1) = 0;
    

    % 计算出现的极值和次极值
    [~,R95p_thresold_year(:,:,year-1984)] = R95p_cal(pre_3h_processing01.*3); % 这里已经转换成降水量单位了,mm/3h
    clear pre_3h_processing01
    disp([num2str(year),' is done!'])
end

filename2 = 'R95p_thresold_3h_pre_rate_prerpocessing01_1985_2014.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\7-2-CMFD-R95p\',filename2], 'R95p_thresold_year','Lon','Lat')

%% 6-hour
clear;clc;
path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')
load('J:\6-硕士毕业论文\1-Data\CMFD\0-from-paper2\LLT.mat')

R95p_thresold_year = nan(length(Lon_3h_scale),length(Lat_3h_scale),2014-1985+1);

for year = 1985:2014
    filename_1 = ['pre2(6h)_',num2str(year),'.mat'];
    load(['J:\6-硕士毕业论文\1-Data\CMFD\0-from-paper2\6h\pre\',filename_1])
      
    % 计算出现的极值和次极值
    [~,R95p_thresold_year(:,:,year-1984)] = R95p_cal(pre_6h_preprocessing01_year.*6); % 这里已经转换成降水量单位了,mm/6h
    clear pre_6h_preprocessing01_year
    disp([num2str(year),' is done!'])
end

Lon = Lon_3h_scale;
Lat = Lat_3h_scale;

filename2 = 'R95p_thresold_6h_pre_rate_prerpocessing01_1985_2014.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\7-2-CMFD-R95p\',filename2], 'R95p_thresold_year','Lon_3h_scale','Lat_3h_scale')

%% 12-hour
clear;clc;
path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')
load('J:\6-硕士毕业论文\1-Data\CMFD\0-from-paper2\LLT.mat')

R95p_thresold_year = nan(length(Lon_3h_scale),length(Lat_3h_scale),2014-1985+1);

for year = 1985:2014
    filename_1 = ['pre3(12h)_',num2str(year),'.mat'];
    load(['J:\6-硕士毕业论文\1-Data\CMFD\0-from-paper2\12h\pre\',filename_1])
    
    % 计算出现的极值和次极值
    [~,R95p_thresold_year(:,:,year-1984)] = R95p_cal(pre_12h_preprocessing01_year.*12); % 这里已经转换成降水量单位了,mm/6h
    clear pre_12h_preprocessing01_year
    disp([num2str(year),' is done!'])
end

Lon = Lon_3h_scale;
Lat = Lat_3h_scale;

filename2 = 'R95p_thresold_12h_pre_rate_prerpocessing01_1985_2014.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\7-2-CMFD-R95p\',filename2], 'R95p_thresold_year','Lon','Lat')



%% 1-day

clear;clc;

path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')
load('J:\6-硕士毕业论文\1-Data\CMFD\0-from-paper2\LLT.mat')

R95p_thresold_year = nan(length(Lon_3h_scale),length(Lat_3h_scale),2014-1985+1);

for year = 1985:2014
    filename_1 = ['pre4(1d)_',num2str(year),'.mat'];
    load(['J:\6-硕士毕业论文\1-Data\CMFD\0-from-paper2\1d\pre\',filename_1])
    
    % 计算出现的极值和次极值
    [~,R95p_thresold_year(:,:,year-1984)] = R95p_cal(pre_1d_preprocessing01_year.*24); % 这里已经转换成降水量单位了,mm/6h
    clear pre_1d_preprocessing01_year
    disp([num2str(year),' is done!'])
end

Lon = Lon_3h_scale;
Lat = Lat_3h_scale;

filename2 = 'R95p_thresold_1d_pre_rate_prerpocessing01_1985_2014.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\7-2-CMFD-R95p\',filename2], 'R95p_thresold_year','Lon','Lat')



