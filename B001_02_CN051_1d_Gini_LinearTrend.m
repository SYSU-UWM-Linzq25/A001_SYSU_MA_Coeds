%% 根据CN051计算出来的日尺度降水基尼系数计算其线性趋势
%% 研究时段为1979-2018

% 存在两种阈值处理的结果
clear;clc;

filename2 = 'CN051_Daily_Gini_1979_2018_01mmday.mat';
load(['J:\6-硕士毕业论文\1-Data\CN051-TM-Pre-1979-2018\3-CN051-Pr-Gini&LinearTrend\',filename2])

% 计算线性趋势
[Gini_LineTrend_1d_CN051_01,~,Gini_p_value_1d_CN051_01,~] = Line_Trend_time_3D(Gini_CN051,1979:2018);

clear filename2
filename2 = 'CN051_Daily_Gini_LinearTrend_1979_2018_01mmday.mat';
save(['J:\6-硕士毕业论文\1-Data\CN051-TM-Pre-1979-2018\3-CN051-Pr-Gini&LinearTrend\',filename2],'Gini_LineTrend_1d_CN051_01','Gini_p_value_1d_CN051_01')

clear;clc;

filename2 = 'CN051_Daily_Gini_1979_2018_01mmh.mat';
load(['J:\6-硕士毕业论文\1-Data\CN051-TM-Pre-1979-2018\3-CN051-Pr-Gini&LinearTrend\',filename2])

% 计算线性趋势
[Gini_LineTrend_1d_CN051_24,~,Gini_p_value_1d_CN051_24,~] = Line_Trend_time_3D(Gini_CN051,1979:2018);

clear filename2
filename2 = 'CN051_Daily_Gini_LinearTrend_1979_2018_01mmh.mat';
save(['J:\6-硕士毕业论文\1-Data\CN051-TM-Pre-1979-2018\3-CN051-Pr-Gini&LinearTrend\',filename2],'Gini_LineTrend_1d_CN051_24','Gini_p_value_1d_CN051_24')


%% 研究时段为1985-2014
% 存在两种阈值处理的结果

clear;clc;

filename2 = 'CN051_Daily_Gini_1979_2018_01mmday.mat';
load(['J:\6-硕士毕业论文\1-Data\CN051-TM-Pre-1979-2018\3-CN051-Pr-Gini&LinearTrend\',filename2])
Gini_CN051_1985_2014 = Gini_CN051(:,:,7:end-4);
clear Gini_CN051
% 计算线性趋势
[Gini_LineTrend_1d_CN051_01,~,Gini_p_value_1d_CN051_01,~] = Line_Trend_time_3D(Gini_CN051_1985_2014,1985:2014);

clear filename2
filename2 = 'CN051_Daily_Gini_LinearTrend_1985_2014_01mmday.mat';
save(['J:\6-硕士毕业论文\1-Data\CN051-TM-Pre-1979-2018\3-CN051-Pr-Gini&LinearTrend\',filename2],'Gini_LineTrend_1d_CN051_01','Gini_p_value_1d_CN051_01')

clear;clc;

filename2 = 'CN051_Daily_Gini_1979_2018_01mmh.mat';
load(['J:\6-硕士毕业论文\1-Data\CN051-TM-Pre-1979-2018\3-CN051-Pr-Gini&LinearTrend\',filename2])
Gini_CN051_1985_2014 = Gini_CN051(:,:,7:end-4);
clear Gini_CN051

% 计算线性趋势
[Gini_LineTrend_1d_CN051_24,~,Gini_p_value_1d_CN051_24,~] = Line_Trend_time_3D(Gini_CN051_1985_2014,1985:2014);

clear filename2
filename2 = 'CN051_Daily_Gini_LinearTrend_1985_2014_01mmh.mat';
save(['J:\6-硕士毕业论文\1-Data\CN051-TM-Pre-1979-2018\3-CN051-Pr-Gini&LinearTrend\',filename2],'Gini_LineTrend_1d_CN051_24','Gini_p_value_1d_CN051_24')




