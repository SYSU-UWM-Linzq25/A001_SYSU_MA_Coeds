%% 这个文化根据升尺度的CMFD降水计算得到的基尼系数，进一步计算线性趋势
%% 研究时段为1985-2014

%% 阈值为 0.1 mm/h

clear;clc;
clear filename2
filename2 = 'CMFD_1d_Gini_025_scale_01mmh_1979_2018_from_Paper2.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\0-from-paper2\',filename2])
Gini_CMFD_1d_025_scale_01mmh_1985_2014 = Gini_CMFD_1d_025_scale_01mmh(:,:,7:end-4);
clear Gini_CMFD_1d_025_scale_01mmh

% 计算线性趋势
[Gini_LineTrend_1d,~,Gini_p_value_1d,~] = Line_Trend_time_3D(Gini_CMFD_1d_025_scale_01mmh_1985_2014,1985:2014);

clear filename2
filename2 = 'CMFD_1d_Gini_025_scale_LinearTrend_01mmh_1985_2014_from_Paper2.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\6-1-CMFD-025-scale-Gini-LinearTend\',filename2],'Gini_LineTrend_1d','Gini_p_value_1d')



