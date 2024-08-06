%% 根据从原始数据提取出来的CMFD，计算基尼系数
%% 降水的阈值不同于英文文章
%% 日尺度统一为0.1mm/day，3h小时尺度则为0.1/8 3h

%% 同时处理的方式发生变化，先将原始数据（降水率,mm/h）转为mm/时间间隔（mm/3h、mm/day）
%% 然后在计算基尼系数

%% 两种阈值：0.1mm/h；0.1mm/day

%% 日尺度基尼系数
clear;clc;
path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')
cd('J:\6-硕士毕业论文\1-Data\CMFD\2-origin-data-1d\')

load('pre4_1d_no_preprocessing_2000.mat')
clear pre_1d_noprocessing

Gini_CMFD_1d = nan(length(Lon),length(Lat),2018-1979+1);
for year = 1979 : 2018
    filename = ['pre4_1d_no_preprocessing_',num2str(year)];
    load(filename)

    % 单位转换(转为mm/day)
    pre_1d_noprocessing = pre_1d_noprocessing.*24;
    
    % 降水阈值处理
    pre_1d_noprocessing(pre_1d_noprocessing < 0.1) = 0;
    
    % 为了加快计算速度，先将三维转二维，然后利用ginicoef函数计算
    CMFD_pre_year_2D = reshape(pre_1d_noprocessing,[],size(pre_1d_noprocessing,3));
    
    % 基尼系数计算
    % 按照行计算
    G_1D = ginicoeff(CMFD_pre_year_2D,2,true);
    
    Gini_CMFD_1d(:,:,year-1978) = reshape(G_1D,[size(pre_1d_noprocessing,1),size(pre_1d_noprocessing,2)]);
    
    clear pre_1d_noprocessing CMFD_pre_year_2D G_1D filename
    disp([num2str(year),' is done!'])
end

filename2 = 'CMFD_1d_Gini_1979_2018_01mmday.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\3-Gini&LinearTrend\',filename2],'Gini_CMFD_1d','Lon','Lat')

% %% 验证计算结果是否与full_Gini函数相同
% clearvars -except Gini_CMFD_1d
% year = 2000;
% filename = ['pre4_1d_no_preprocessing_',num2str(year)];
% load(filename)
% 
% Gini_CMFD_1d_year = Gini_CMFD_1d(:,:,2000-1978);
% 
% % 单位转换(转为mm/day)
% pre_1d_noprocessing = pre_1d_noprocessing.*24;
% 
% % 降水阈值处理
% pre_1d_noprocessing(pre_1d_noprocessing < 0.1) = 0;
% 
% pre_1d_noprocessing_sort = sort(pre_1d_noprocessing,3);
% 
% Gini_test_year = full_Gini(pre_1d_noprocessing_sort);

%% 3h尺度的基尼系数计算，阈值
%% 需要很大内存
clear;clc;
path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')
cd('J:\6-硕士毕业论文\1-Data\CMFD\1-origin-data-3h\')

load('pre1_3h_no_preprocessing_2000.mat')
clear pre_3h_noprocessing

Gini_CMFD_3h = nan(length(Lon),length(Lat),2018-1979+1);
for year = 1979 : 2018
    filename = ['pre1_3h_no_preprocessing_',num2str(year)];
    load(filename)
    
    % 单位转换(转为mm/3h)
    pre_3h_noprocessing = pre_3h_noprocessing.*3;
    
    % 降水阈值处理
    pre_3h_noprocessing(pre_3h_noprocessing < 0.1/8) = 0;
    
    % 为了加快计算速度，先将三维转二维，然后利用ginicoef函数计算
    CMFD_pre_year_2D = reshape(pre_3h_noprocessing,[],size(pre_3h_noprocessing,3));
    
    a = size(pre_3h_noprocessing,1);
    b = size(pre_3h_noprocessing,2);
    clear pre_3h_noprocessing
    
    % 合起来太大，砍成四段
    CMFD_pre_year_2D_1 = CMFD_pre_year_2D(1:70000,:);
    G_1D_1 = ginicoeff(CMFD_pre_year_2D_1,2,true);
    clear CMFD_pre_year_2D_1
    
    CMFD_pre_year_2D_2 = CMFD_pre_year_2D(70001:140000,:);
    G_1D_2 = ginicoeff(CMFD_pre_year_2D_2,2,true);
    clear CMFD_pre_year_2D_2
    
    CMFD_pre_year_2D_3 = CMFD_pre_year_2D(140001:210000,:);
    G_1D_3 = ginicoeff(CMFD_pre_year_2D_3,2,true);
    clear CMFD_pre_year_2D_3
    
    CMFD_pre_year_2D_4 = CMFD_pre_year_2D(210001:280000,:);
    G_1D_4 = ginicoeff(CMFD_pre_year_2D_4,2,true);
    clear CMFD_pre_year_2D_4
    clear CMFD_pre_year_2D
    % 基尼系数计算
    % 按照行计算
    G_1D = [G_1D_1;G_1D_2;G_1D_3;G_1D_4];
    
    Gini_CMFD_3h(:,:,year-1978) = reshape(G_1D,[a,b]);
    
    clear pre_3h_noprocessing G_1D filename
    disp([num2str(year),' is done!'])
end

filename2 = 'CMFD_3h_Gini_1979_2018_01mmday.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\3-Gini&LinearTrend\',filename2],'Gini_CMFD_3h','Lon','Lat')

% %% 验证计算结果是否与full_Gini函数相同
% clearvars -except Gini_CMFD_3h
% load('pre1_3h_no_preprocessing_2000.mat')
% 
% Gini_CMFD_3h_year = Gini_CMFD_3h(:,:,2000-1978);
% 
% % 单位转换(转为mm/day)
% pre_3h_noprocessing = pre_3h_noprocessing.*3;
% 
% % 降水阈值处理
% pre_3h_noprocessing(pre_3h_noprocessing < 0.1/8) = 0;
% 
% pre_3h_noprocessing_sort = sort(pre_3h_noprocessing,3);
% 
% Gini_test_year = full_Gini(pre_3h_noprocessing_sort);

clear;clc
a = rand(1,10);
b = 10*a;
G1 = ginicoeff(a,2,true);
G2 = ginicoeff(b,2,true);


%% 跟英文文章一样的阈值，0.1mmh
%% 日尺度基尼系数
clear;clc;
path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')
cd('J:\6-硕士毕业论文\1-Data\CMFD\2-origin-data-1d\Pre\')

load('pre4_1d_no_preprocessing_2000.mat')
clear pre_1d_noprocessing

Gini_CMFD_1d = nan(length(Lon),length(Lat),2018-1979+1);
for year = 1979 : 2018
    filename = ['pre4_1d_no_preprocessing_',num2str(year)];
    load(filename)

    % 单位转换(转为mm/day)
    pre_1d_noprocessing = pre_1d_noprocessing.*24;
    
    % 降水阈值处理
    pre_1d_noprocessing(pre_1d_noprocessing < 2.4) = 0;
    
    % 为了加快计算速度，先将三维转二维，然后利用ginicoef函数计算
    CMFD_pre_year_2D = reshape(pre_1d_noprocessing,[],size(pre_1d_noprocessing,3));
    
    % 基尼系数计算
    % 按照行计算
    G_1D = ginicoeff(CMFD_pre_year_2D,2,true);
    
    Gini_CMFD_1d(:,:,year-1978) = reshape(G_1D,[size(pre_1d_noprocessing,1),size(pre_1d_noprocessing,2)]);
    
    clear pre_1d_noprocessing CMFD_pre_year_2D G_1D filename
    disp([num2str(year),' is done!'])
end

filename2 = 'CMFD_1d_Gini_1979_2018_01mmh.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\3-1-Gini&LinearTrend\From-1d-Pre-Data\',filename2],'Gini_CMFD_1d','Lon','Lat')

%% 3h尺度的基尼系数计算，阈值
% 需要很大内存
clear;clc;
path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')
cd('J:\6-硕士毕业论文\1-Data\CMFD\1-origin-data-3h\Pre')

load('pre1_3h_no_preprocessing_2000.mat')
clear pre_3h_noprocessing

Gini_CMFD_3h = nan(length(Lon),length(Lat),2018-1979+1);
for year = 1979 : 2018
    filename = ['pre1_3h_no_preprocessing_',num2str(year)];
    load(filename)
    
    % 单位转换(转为mm/3h)
    pre_3h_noprocessing = pre_3h_noprocessing.*3;
    
    % 降水阈值处理
    pre_3h_noprocessing(pre_3h_noprocessing < 0.3) = 0;
    
    % 为了加快计算速度，先将三维转二维，然后利用ginicoef函数计算
    CMFD_pre_year_2D = reshape(pre_3h_noprocessing,[],size(pre_3h_noprocessing,3));
    
    a = size(pre_3h_noprocessing,1);
    b = size(pre_3h_noprocessing,2);
    clear pre_3h_noprocessing
    
    % 合起来太大，砍成四段
    CMFD_pre_year_2D_1 = CMFD_pre_year_2D(1:70000,:);
    G_1D_1 = ginicoeff(CMFD_pre_year_2D_1,2,true);
    clear CMFD_pre_year_2D_1
    
    CMFD_pre_year_2D_2 = CMFD_pre_year_2D(70001:140000,:);
    G_1D_2 = ginicoeff(CMFD_pre_year_2D_2,2,true);
    clear CMFD_pre_year_2D_2
    
    CMFD_pre_year_2D_3 = CMFD_pre_year_2D(140001:210000,:);
    G_1D_3 = ginicoeff(CMFD_pre_year_2D_3,2,true);
    clear CMFD_pre_year_2D_3
    
    CMFD_pre_year_2D_4 = CMFD_pre_year_2D(210001:280000,:);
    G_1D_4 = ginicoeff(CMFD_pre_year_2D_4,2,true);
    clear CMFD_pre_year_2D_4
    clear CMFD_pre_year_2D
    % 基尼系数计算
    % 按照行计算
    G_1D = [G_1D_1;G_1D_2;G_1D_3;G_1D_4];
    
    Gini_CMFD_3h(:,:,year-1978) = reshape(G_1D,[a,b]);
    
    clear pre_3h_noprocessing G_1D filename
    disp([num2str(year),' is done!'])
end

filename2 = 'CMFD_3h_Gini_1979_2018_01mmh.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\3-Gini&LinearTrend\',filename2],'Gini_CMFD_3h','Lon','Lat')
