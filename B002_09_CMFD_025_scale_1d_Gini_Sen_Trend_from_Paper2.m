%% 这个文化根据升尺度的CMFD降水计算得到的基尼系数，进一步计算Sen趋势
%% 研究时段为1985-2014
%% 阈值为 0.1 mm/h

clear;clc;
clear filename2
filename2 = 'CMFD_1d_Gini_025_scale_01mmh_1979_2018_from_Paper2.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\0-from-paper2\',filename2])
Gini_CMFD_1d_025_scale_01mmh_1985_2014 = Gini_CMFD_1d_025_scale_01mmh(:,:,7:end-4);
clear Gini_CMFD_1d_025_scale_01mmh

Gini_Sen_slope_1d = nan(size(Gini_CMFD_1d_025_scale_01mmh_1985_2014,1),size(Gini_CMFD_1d_025_scale_01mmh_1985_2014,2));
Gini_MK_1d = nan(size(Gini_CMFD_1d_025_scale_01mmh_1985_2014,1),size(Gini_CMFD_1d_025_scale_01mmh_1985_2014,2));
% 计算Sen趋势
for i = 1 : size(Gini_CMFD_1d_025_scale_01mmh_1985_2014,1)
    for j = 1 : size(Gini_CMFD_1d_025_scale_01mmh_1985_2014,2)
        a = reshape(Gini_CMFD_1d_025_scale_01mmh_1985_2014(i,j,:),[1,size(Gini_CMFD_1d_025_scale_01mmh_1985_2014,3)]);
        Gini_Sen_slope_1d(i,j) = Theil_Sen_Regress((1985:2014)',a');
        Gini_MK_1d(i,j) = MK(a');
        clear a
    end
end

clear filename2
filename2 = 'CMFD_1d_Gini_025_scale_Sen_Trend_01mmh_1985_2014_from_Paper2.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\6-2-CMFD-025-scale-Gini-Sen-Trend\',filename2],'Gini_Sen_slope_1d','Gini_MK_1d','Lon_025','Lat_025')



