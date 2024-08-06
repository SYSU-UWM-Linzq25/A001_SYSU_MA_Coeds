%% 这个文件根据MSWEP数据
%% 计算年降水量和年均温与基尼系数的相关系数

clear;clc;
path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')

% 读取温度和年降水量
load('J:\6-硕士毕业论文\1-Data\MSWEP-V280-1985-2014\004-MAT-025-scale\MAT spatial resolution 0.25.mat')

% 提取出其中的1985-2014
Temp_025_1985_2014 = Temp_025(:,:,7:end-4);
clear Temp_025
load('J:\6-硕士毕业论文\1-Data\MSWEP-V280-1985-2014\005-AP-025-scale\AP_CN_MSWEP_1985_2014.mat')

% 读取基尼系数
% 3h MWSEP
load('F:\File_of_MATLAB\research_of_MSWEP\data\Full Gini index 3h preprocessing01.mat')

% 数据的时间尺度从1979-2015，所以只取出其中1985-2014部分
Full_Gini_3h_MWSEP_1985_2014 = Full_Gini_3h_MWSEP(:,:,7:end-1);
clear Full_Gini_3h_MWSEP

% 6-hour
load('F:\File_of_MATLAB\research_of_MSWEP\data\Full Gini index 6h preprocessing01.mat')

% 数据的时间尺度从1979-2015，所以只取出其中1985-2014部分
Full_Gini_6h_MWSEP_1985_2014 = Full_Gini_6h_MWSEP(:,:,7:end-1);
clear Full_Gini_6h_MWSEP

% 12-hour
load('F:\File_of_MATLAB\research_of_MSWEP\data\Full Gini index 12h preprocessing01.mat')

% 数据的时间尺度从1979-2015，所以只取出其中1985-2014部分
Full_Gini_12h_MWSEP_1985_2014 = Full_Gini_12h_MWSEP(:,:,7:end-1);
clear Full_Gini_12h_MWSEP

% 1-day
load('F:\File_of_MATLAB\research_of_MSWEP\data\Full Gini index 1d preprocessing01.mat')

% 数据的时间尺度从1979-2015，所以只取出其中1985-2014部分
Full_Gini_1d_MWSEP_1985_2014 = Full_Gini_1d_MWSEP(:,:,7:end-1);
clear Full_Gini_1d_MWSEP

PCCs_MAT_3h_GI_MSWEP = nan(size(Full_Gini_3h_MWSEP_1985_2014,1),size(Full_Gini_3h_MWSEP_1985_2014,2));
PCCs_MAT_6h_GI_MSWEP = nan(size(Full_Gini_3h_MWSEP_1985_2014,1),size(Full_Gini_3h_MWSEP_1985_2014,2));
PCCs_MAT_12h_GI_MSWEP = nan(size(Full_Gini_3h_MWSEP_1985_2014,1),size(Full_Gini_3h_MWSEP_1985_2014,2));
PCCs_MAT_1d_GI_MSWEP = nan(size(Full_Gini_3h_MWSEP_1985_2014,1),size(Full_Gini_3h_MWSEP_1985_2014,2));
P_MAT_3h_GI_MSWEP = nan(size(Full_Gini_3h_MWSEP_1985_2014,1),size(Full_Gini_3h_MWSEP_1985_2014,2));
P_MAT_6h_GI_MSWEP = nan(size(Full_Gini_3h_MWSEP_1985_2014,1),size(Full_Gini_3h_MWSEP_1985_2014,2));
P_MAT_12h_GI_MSWEP = nan(size(Full_Gini_3h_MWSEP_1985_2014,1),size(Full_Gini_3h_MWSEP_1985_2014,2));
P_MAT_1d_GI_MSWEP = nan(size(Full_Gini_3h_MWSEP_1985_2014,1),size(Full_Gini_3h_MWSEP_1985_2014,2));

PCCs_AP_3h_GI_MSWEP = nan(size(Full_Gini_3h_MWSEP_1985_2014,1),size(Full_Gini_3h_MWSEP_1985_2014,2));
PCCs_AP_6h_GI_MSWEP = nan(size(Full_Gini_3h_MWSEP_1985_2014,1),size(Full_Gini_3h_MWSEP_1985_2014,2));
PCCs_AP_12h_GI_MSWEP = nan(size(Full_Gini_3h_MWSEP_1985_2014,1),size(Full_Gini_3h_MWSEP_1985_2014,2));
PCCs_AP_1d_GI_MSWEP = nan(size(Full_Gini_3h_MWSEP_1985_2014,1),size(Full_Gini_3h_MWSEP_1985_2014,2));
P_AP_3h_GI_MSWEP = nan(size(Full_Gini_3h_MWSEP_1985_2014,1),size(Full_Gini_3h_MWSEP_1985_2014,2));
P_AP_6h_GI_MSWEP = nan(size(Full_Gini_3h_MWSEP_1985_2014,1),size(Full_Gini_3h_MWSEP_1985_2014,2));
P_AP_12h_GI_MSWEP = nan(size(Full_Gini_3h_MWSEP_1985_2014,1),size(Full_Gini_3h_MWSEP_1985_2014,2));
P_AP_1d_GI_MSWEP = nan(size(Full_Gini_3h_MWSEP_1985_2014,1),size(Full_Gini_3h_MWSEP_1985_2014,2));

for i = 1 : size(Full_Gini_3h_MWSEP_1985_2014,1)
    for j = 1 : size(Full_Gini_3h_MWSEP_1985_2014,1)
        Temp_025_Grid = Temp_025_1985_2014(i,j,:);
        AP_CN_MSWEP_Grid = AP_CN_MSWEP_1985_2014(i,j,:);
        
        GI_3h_Grid = Full_Gini_3h_MWSEP_1985_2014(i,j,:);
        GI_6h_Grid = Full_Gini_6h_MWSEP_1985_2014(i,j,:);
        GI_12h_Grid = Full_Gini_12h_MWSEP_1985_2014(i,j,:);
        GI_1d_Grid = Full_Gini_1d_MWSEP_1985_2014(i,j,:);
        
        [PCCs_1,P_1] = corrcoef(Temp_025_Grid,GI_3h_Grid);
        [PCCs_2,P_2] = corrcoef(Temp_025_Grid,GI_6h_Grid);
        [PCCs_3,P_3] = corrcoef(Temp_025_Grid,GI_12h_Grid);
        [PCCs_4,P_4] = corrcoef(Temp_025_Grid,GI_1d_Grid);
        
        [PCCs_5,P_5] = corrcoef(AP_CN_MSWEP_Grid,GI_3h_Grid);
        [PCCs_6,P_6] = corrcoef(AP_CN_MSWEP_Grid,GI_6h_Grid);
        [PCCs_7,P_7] = corrcoef(AP_CN_MSWEP_Grid,GI_12h_Grid);
        [PCCs_8,P_8] = corrcoef(AP_CN_MSWEP_Grid,GI_1d_Grid);
        
        PCCs_MAT_3h_GI_MSWEP(i,j) = PCCs_1(2);
        PCCs_MAT_6h_GI_MSWEP(i,j) = PCCs_2(2);
        PCCs_MAT_12h_GI_MSWEP(i,j) = PCCs_3(2);
        PCCs_MAT_1d_GI_MSWEP(i,j) = PCCs_4(2);
        
        P_MAT_3h_GI_MSWEP(i,j) = P_1(2);
        P_MAT_6h_GI_MSWEP(i,j) = P_2(2);
        P_MAT_12h_GI_MSWEP(i,j) = P_3(2);
        P_MAT_1d_GI_MSWEP(i,j) = P_4(2);
        
        PCCs_AP_3h_GI_MSWEP(i,j) = PCCs_5(2);
        PCCs_AP_6h_GI_MSWEP(i,j) = PCCs_6(2);
        PCCs_AP_12h_GI_MSWEP(i,j) = PCCs_7(2);
        PCCs_AP_1d_GI_MSWEP(i,j) = PCCs_8(2);
        
        P_AP_3h_GI_MSWEP(i,j) = P_5(2);
        P_AP_6h_GI_MSWEP(i,j) = P_6(2);
        P_AP_12h_GI_MSWEP(i,j) = P_7(2);
        P_AP_1d_GI_MSWEP(i,j) = P_8(2);
        
        clear PCCs_1 PCCs_2 PCCs_3 PCCs_4 PCCs_5 PCCs_6 PCCs_7 PCCs_8...
            P_1 P_2 P_3 P_4 P_5 P_6 P_7 P_8
        clear Temp_025_Grid AP_CN_MSWEP_Grid GI_3h_Grid GI_6h_Grid GI_12h_Grid GI_1d_Grid
    end
end

clear filename2
filename2 = 'PCCs_MAT_and_MSWEP_Gini_1985_2014_01mmh.mat';
save(['J:\6-硕士毕业论文\1-Data\MSWEP-V280-1985-2014\006-PCCs-MAT-AP-and-GI-1985-2014\',filename2],'PCCs_MAT_3h_GI_MSWEP','P_MAT_3h_GI_MSWEP',...
    'PCCs_MAT_6h_GI_MSWEP','P_MAT_6h_GI_MSWEP',...
    'PCCs_MAT_12h_GI_MSWEP','P_MAT_12h_GI_MSWEP',...
    'PCCs_MAT_1d_GI_MSWEP','P_MAT_1d_GI_MSWEP')

clear filename2
filename2 = 'PCCs_AP_and_MSWEP_Gini_1985_2014_01mmh.mat';
save(['J:\6-硕士毕业论文\1-Data\MSWEP-V280-1985-2014\006-PCCs-MAT-AP-and-GI-1985-2014\',filename2],'PCCs_AP_3h_GI_MSWEP','P_AP_3h_GI_MSWEP',...
    'PCCs_AP_6h_GI_MSWEP','P_AP_6h_GI_MSWEP',...
    'PCCs_AP_12h_GI_MSWEP','P_AP_12h_GI_MSWEP',...
    'PCCs_AP_1d_GI_MSWEP','P_AP_1d_GI_MSWEP')
