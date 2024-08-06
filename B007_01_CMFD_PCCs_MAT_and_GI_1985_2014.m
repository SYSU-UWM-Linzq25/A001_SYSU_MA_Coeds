%% 计算1985-2014年期间，年均温与基尼系数的相关系数
%% CMFD数据计算得到的降水集中度结果
%% 原始空间分辨率

clear;clc;

% 读取原始空间分辨率的基尼系数
% 3-hour
% 3h
filename2 = 'CMFD_3h_Gini_1979_2018_01mmh.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\3-1-Gini&LinearTrend\',filename2])
% 统一选取年份范围为1985-2014
Gini_CMFD_3h_1985_2014 = Gini_CMFD_3h(:,:,7:end-4);
clear Gini_CMFD_3h

% 6-hour
clear filename2
filename2 = 'Full Gini index 6h.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\0-from-paper2\6h\full Gini\',filename2])
% 统一选取年份范围为1985-2014
Gini_CMFD_6h_1985_2014 = Full_Gini_6h_all(:,:,7:end-4);
clear Full_Gini_6h_all

% 12h
path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')
clear filename2
filename2 = 'Full Gini index 12h.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\0-from-paper2\12h\full Gini\',filename2])
% 统一选取年份范围为1985-2014
Gini_CMFD_12h_1985_2014 = Full_Gini_12h_all(:,:,7:end-4);
clear Full_Gini_12h_all

% 1d
clear filename2
filename2 = 'Full Gini index 1d.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\0-from-paper2\1d\full Gini\',filename2])
% 统一选取年份范围为1985-2014
Gini_CMFD_1d_1985_2014 = Full_Gini_1d_all(:,:,7:end-4);
clear Full_Gini_1d_all

% 读取年均温数据
clear filename2
filename2 = 'MAT_3h_01mmh_1979_2018.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\5-1-CMFD-01-scale-AP-and-MAT-01mmh\',filename2]);
MAT_3h_1985_2014 = MAT_3h(:,:,7:end-4);
clear MAT_3h

PCCs_3h_GI_MAT = nan(size(MAT_3h_1985_2014,1),size(MAT_3h_1985_2014,2));
PCCs_6h_GI_MAT = nan(size(MAT_3h_1985_2014,1),size(MAT_3h_1985_2014,2));
PCCs_12h_GI_MAT = nan(size(MAT_3h_1985_2014,1),size(MAT_3h_1985_2014,2));
PCCs_1d_GI_MAT = nan(size(MAT_3h_1985_2014,1),size(MAT_3h_1985_2014,2));
p_value_3h = nan(size(MAT_3h_1985_2014,1),size(MAT_3h_1985_2014,2));
p_value_6h = nan(size(MAT_3h_1985_2014,1),size(MAT_3h_1985_2014,2));
p_value_12h = nan(size(MAT_3h_1985_2014,1),size(MAT_3h_1985_2014,2));
p_value_1d = nan(size(MAT_3h_1985_2014,1),size(MAT_3h_1985_2014,2));

% 计算相关系数和p值
for i = 1 : size(MAT_3h_1985_2014,1)
    for j = 1 : size(MAT_3h_1985_2014,2)
       
        GI_3h = Gini_CMFD_3h_1985_2014(i,j,:);
        GI_6h = Gini_CMFD_6h_1985_2014(i,j,:);
        GI_12h = Gini_CMFD_12h_1985_2014(i,j,:);
        GI_1d = Gini_CMFD_1d_1985_2014(i,j,:);
        MAT_1 = MAT_3h_1985_2014(i,j,:);
        
        [r_3h,p_3h] = corrcoef(MAT_1,GI_3h);
        [r_6h,p_6h] = corrcoef(MAT_1,GI_6h);
        [r_12h,p_12h] = corrcoef(MAT_1,GI_12h);
        [r_1d,p_1d] = corrcoef(MAT_1,GI_1d);
        
        PCCs_3h_GI_MAT(i,j) = r_3h(2);
        PCCs_6h_GI_MAT(i,j) = r_6h(2);
        PCCs_12h_GI_MAT(i,j) = r_12h(2);
        PCCs_1d_GI_MAT(i,j) = r_1d(2);
        p_value_3h(i,j) = p_3h(2);
        p_value_6h(i,j) = p_6h(2);
        p_value_12h(i,j) = p_12h(2);
        p_value_1d(i,j) = p_1d(2);
        clear GI_3h GI_6h GI_12h GI_1d p_3h p_6h p_12h p_1d r_3h r_6h r_12h r_1d MAT_1
    end 
end

filename2 = 'PCCs_of_CMFD_MAT_and_GI_01_scale_1985_2014.mat';
save(['J:\6-硕士毕业论文\1-Data\PCCs-bewteen-MAT-and-GI\',filename2],'PCCs_3h_GI_MAT','PCCs_6h_GI_MAT',...
    'PCCs_12h_GI_MAT','PCCs_1d_GI_MAT',...
    'p_value_3h','p_value_6h','p_value_12h','p_value_1d','Lon','Lat')


