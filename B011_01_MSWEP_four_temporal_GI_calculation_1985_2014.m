%% 这个文件根据MSWEP数据，升尺度的结果，计算基尼系数
%% 已经转换为mm/h,同时用0.1mm/h进行预处理
%% 3-hour

clear;clc;
path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')
load('J:\6-硕士毕业论文\1-Data\MSWEP-V280-1985-2014\range.mat')

% 这里还是得注意MSWEP的纬度组织格式与CMFD的相反
% 不过是画自己的空间分布图，所以应该不用太过担心
cd('J:\6-硕士毕业论文\1-Data\MSWEP-V280-1985-2014\001-Pre-data-processing01\3h\')

% 降水是纬度写在前，要遵循一致
Gini_MSWEP_3h = nan(length(Lat),length(Lon),2014-1985+1);
for year = 1985 : 2014
    filename = ['Pre_China_in_',num2str(year),'.mat'];
    load(filename)
    
    % 为了加快计算速度，先将三维转二维，然后利用ginicoef函数计算
    MSWEP_pre_year_2D = reshape(Pre_rate_China_year_3h,[],size(Pre_rate_China_year_3h,3));
    

    % 基尼系数计算
    % 按照行计算
    G_1D = ginicoeff(MSWEP_pre_year_2D,2,true);
    clear MSWEP_pre_year_2D
    
    Gini_MSWEP_3h(:,:,year-1984) = reshape(G_1D,[length(Lat),length(Lon)]);
    
    clear Pre_rate_China_year_3h G_1D filename
    disp([num2str(year),' is done!'])
end

filename2 = 'MSWEP_3h_Gini_1985_2014_01mmh.mat';
save(['J:\6-硕士毕业论文\1-Data\MSWEP-V280-1985-2014\002-GI-1985-2014\',filename2],'Gini_MSWEP_3h','Lon','Lat')


%% 6-hour

clear;clc;
path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')
load('J:\6-硕士毕业论文\1-Data\MSWEP-V280-1985-2014\range.mat')

% 这里还是得注意MSWEP的纬度组织格式与CMFD的相反
% 不过是画自己的空间分布图，所以应该不用太过担心
cd('J:\6-硕士毕业论文\1-Data\MSWEP-V280-1985-2014\001-Pre-data-processing01\6h\')
Gini_MSWEP_6h = nan(length(Lat),length(Lon),2014-1985+1);
for year = 1985 : 2014
    filename = ['Pre_China_6h_in_',num2str(year),'.mat'];
    load(filename)
    
    % 为了加快计算速度，先将三维转二维，然后利用ginicoef函数计算
    MSWEP_pre_year_2D = reshape(Pre_rate_China_year_6h,[],size(Pre_rate_China_year_6h,3));
    

    % 基尼系数计算
    % 按照行计算
    G_1D = ginicoeff(MSWEP_pre_year_2D,2,true);
    clear MSWEP_pre_year_2D
    
    Gini_MSWEP_6h(:,:,year-1984) = reshape(G_1D,[length(Lat),length(Lon)]);
    
    clear Pre_rate_China_year_6h G_1D filename
    disp([num2str(year),' is done!'])
end

filename2 = 'MSWEP_6h_Gini_1985_2014_01mmh.mat';
save(['J:\6-硕士毕业论文\1-Data\MSWEP-V280-1985-2014\002-GI-1985-2014\',filename2],'Gini_MSWEP_6h','Lon','Lat')

%% 12-hour

clear;clc;
path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')
load('J:\6-硕士毕业论文\1-Data\MSWEP-V280-1985-2014\range.mat')

% 这里还是得注意MSWEP的纬度组织格式与CMFD的相反
% 不过是画自己的空间分布图，所以应该不用太过担心
cd('J:\6-硕士毕业论文\1-Data\MSWEP-V280-1985-2014\001-Pre-data-processing01\12h\')
Gini_MSWEP_12h = nan(length(Lat),length(Lon),2014-1985+1);
for year = 1985 : 2014
    filename = ['Pre_China_12h_in_',num2str(year),'.mat'];
    load(filename)
    
    % 为了加快计算速度，先将三维转二维，然后利用ginicoef函数计算
    MSWEP_pre_year_2D = reshape(Pre_rate_China_year_12h,[],size(Pre_rate_China_year_12h,3));
    

    % 基尼系数计算
    % 按照行计算
    G_1D = ginicoeff(MSWEP_pre_year_2D,2,true);
    clear MSWEP_pre_year_2D
    
    Gini_MSWEP_12h(:,:,year-1984) = reshape(G_1D,[length(Lat),length(Lon)]);
    
    clear Pre_rate_China_year_12h G_1D filename
    disp([num2str(year),' is done!'])
end

filename2 = 'MSWEP_12h_Gini_1985_2014_01mmh.mat';
save(['J:\6-硕士毕业论文\1-Data\MSWEP-V280-1985-2014\002-GI-1985-2014\',filename2],'Gini_MSWEP_12h','Lon','Lat')

%% 1-day

clear;clc;
path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')
load('J:\6-硕士毕业论文\1-Data\MSWEP-V280-1985-2014\range.mat')

% 这里还是得注意MSWEP的纬度组织格式与CMFD的相反
% 不过是画自己的空间分布图，所以应该不用太过担心
cd('J:\6-硕士毕业论文\1-Data\MSWEP-V280-1985-2014\001-Pre-data-processing01\1d\')
Gini_MSWEP_1d = nan(length(Lat),length(Lon),2014-1985+1);
for year = 1985 : 2014
    filename = ['Pre_China_1d_in_',num2str(year),'.mat'];
    load(filename)
    
    % 为了加快计算速度，先将三维转二维，然后利用ginicoef函数计算
    MSWEP_pre_year_2D = reshape(Pre_rate_China_year_1d,[],size(Pre_rate_China_year_1d,3));
    

    % 基尼系数计算
    % 按照行计算
    G_1D = ginicoeff(MSWEP_pre_year_2D,2,true);
    clear MSWEP_pre_year_2D
    
    Gini_MSWEP_1d(:,:,year-1984) = reshape(G_1D,[length(Lat),length(Lon)]);
    
    clear Pre_rate_China_year_1d G_1D filename
    disp([num2str(year),' is done!'])
end

filename2 = 'MSWEP_1d_Gini_1985_2014_01mmh.mat';
save(['J:\6-硕士毕业论文\1-Data\MSWEP-V280-1985-2014\002-GI-1985-2014\',filename2],'Gini_MSWEP_1d','Lon','Lat')

