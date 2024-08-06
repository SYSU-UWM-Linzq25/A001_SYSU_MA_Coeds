%% 这个文件根据提取出来得GLEAM表层土壤水含量数据，单位为(m3/m3)
%% 计算的基尼系数计算Sen斜率

clear;clc;

cd('J:\6-硕士毕业论文\1-Data\GLEAM-V3.8a-025-scale\')
filename = 'GLEAM_SMsurf_1d_Gini_1985_2014.mat';
load(filename)

Gini_SM_Sen_slope_1d = nan(size(Gini_1d_SMsurf_GLEAM,1),size(Gini_1d_SMsurf_GLEAM,2));
Gini_SM_MK_1d = nan(size(Gini_1d_SMsurf_GLEAM,1),size(Gini_1d_SMsurf_GLEAM,2));
% 计算Sen趋势
for i = 1 : size(Gini_1d_SMsurf_GLEAM,1)
    for j = 1 : size(Gini_1d_SMsurf_GLEAM,2)
        a = reshape(Gini_1d_SMsurf_GLEAM(i,j,:),[1,size(Gini_1d_SMsurf_GLEAM,3)]);
        Gini_SM_Sen_slope_1d(i,j) = Theil_Sen_Regress((1985:2014)',a');
        Gini_SM_MK_1d(i,j) = MK(a');
        clear a
    end
end
clear filename2
filename2 = 'GLEAM_1d_SMsurf_Gini_MK_Sen_1985_2014.mat';
save(['J:\6-硕士毕业论文\1-Data\GLEAM-V3.8a-025-scale\',filename2],'Gini_SM_Sen_slope_1d','Gini_SM_MK_1d','Lon_025','Lat_025')


