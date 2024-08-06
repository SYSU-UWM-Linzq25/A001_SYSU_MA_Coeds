%% 这个文件根据计算的土壤表层含水量和实际蒸发的基尼系数
%% 结合降水的基尼系数
%% 计算相关系数

clear;clc;

cd('J:\6-硕士毕业论文\1-Data\GLEAM-V3.8a-025-scale\')
filename = 'GLEAM_SMsurf_1d_Gini_1985_2014.mat';
load(filename)

cd('J:\6-硕士毕业论文\1-Data\GLEAM-V3.8a-025-scale\')
filename = 'GLEAM_Eva_1d_Gini_remove_negative_1985_2014.mat';
load(filename)

% 降水的基尼系数

% 升尺度的CMFD
% 读取CMFD整合到0.25°上的经纬度坐标
filename2 = 'CMFD_1d_Gini_025_scale_01mmh_1979_2018_from_Paper2.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\0-from-paper2\',filename2])
Gini_CMFD_1d_025_scale_01mmh_1985_2014 = Gini_CMFD_1d_025_scale_01mmh(:,:,7:end-4);
clear Gini_CMFD_1d_025_scale_01mmh

% 转置一下降水的基尼系数
Pre_GI_1d_CMFD = nan(length(Lon_025),length(Lat_025),size(Gini_CMFD_1d_025_scale_01mmh_1985_2014,3));
for i = 1 : size(Gini_CMFD_1d_025_scale_01mmh_1985_2014,3)
    Pre_GI = Gini_CMFD_1d_025_scale_01mmh_1985_2014(:,:,i);
    Pre_GI_1d_CMFD(:,:,i) = Pre_GI';
    clear Pre_GI
end
clear Gini_CMFD_1d_025_scale_01mmh_1985_2014


% 计算相关系数
PCCs_Pre_and_SM_GI_1d_025_scale = nan(size(Pre_GI_1d_CMFD,1),size(Pre_GI_1d_CMFD,2));
P_Pre_and_SM_GI_1d_025_scale = nan(size(Pre_GI_1d_CMFD,1),size(Pre_GI_1d_CMFD,2));
PCCs_Pre_and_Eva_GI_1d_025_scale = nan(size(Pre_GI_1d_CMFD,1),size(Pre_GI_1d_CMFD,2));
P_Pre_and_Eva_GI_1d_025_scale = nan(size(Pre_GI_1d_CMFD,1),size(Pre_GI_1d_CMFD,2));

clear i j
for i = 1 : size(Pre_GI_1d_CMFD,1)
    for j = 1 : size(Pre_GI_1d_CMFD,2)
        Pre_GI_1 = Pre_GI_1d_CMFD(i,j,:);
        SM_GI_1 = Gini_1d_SMsurf_GLEAM(i,j,:);
        Eva_GI_1 = Gini_1d_Eva_GLEAM(i,j,:);
        
        [PCCs_1,P_1] = corrcoef(Pre_GI_1,SM_GI_1);
        [PCCs_2,P_2] = corrcoef(Pre_GI_1,Eva_GI_1);
        
        PCCs_Pre_and_SM_GI_1d_025_scale(i,j) = PCCs_1(2);
        PCCs_Pre_and_Eva_GI_1d_025_scale(i,j) = PCCs_2(2);
        P_Pre_and_SM_GI_1d_025_scale(i,j) = P_1(2);
        P_Pre_and_Eva_GI_1d_025_scale(i,j) = P_2(2);
        
        clear PCCs_1 P_1 PCCs_2 P_2 Pre_GI_1 SM_GI_1 Eva_GI_1
    end
end

filename2 = 'PCCs_pre_and_SM_1d_025_scale_1985_2014.mat';
save(['J:\6-硕士毕业论文\1-Data\PCCs_for_hydrological_response\',filename2],'PCCs_Pre_and_SM_GI_1d_025_scale','P_Pre_and_SM_GI_1d_025_scale','Lon_025','Lat_025')
clear filename2
filename2 = 'PCCs_pre_and_Eva_1d_025_scale_1985_2014.mat';
save(['J:\6-硕士毕业论文\1-Data\PCCs_for_hydrological_response\',filename2],'PCCs_Pre_and_Eva_GI_1d_025_scale','P_Pre_and_Eva_GI_1d_025_scale','Lon_025','Lat_025')
