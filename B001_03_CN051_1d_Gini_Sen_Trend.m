%% 根据CN051计算出来的日尺度降水基尼系数计算其Sen趋势
%% 研究时段为1985-2014

clear;clc;

% filename2 = 'CN051_Daily_Gini_1979_2018_01mmday.mat';
% load(['J:\6-硕士毕业论文\1-Data\CN051-TM-Pre-1979-2018\3-CN051-Pr-Gini&LinearTrend\',filename2])
% Gini_CN051_1985_2014 = Gini_CN051(:,:,7:end-4);
% clear Gini_CN051
% % 计算线性趋势
% [Gini_LineTrend_1d_CN051_01,~,Gini_p_value_1d_CN051_01,~] = Line_Trend_time_3D(Gini_CN051_1985_2014,1985:2014);
% 
% clear filename2
% filename2 = 'CN051_Daily_Gini_LinearTrend_1985_2014_01mmday.mat';
% save(['J:\6-硕士毕业论文\1-Data\CN051-TM-Pre-1979-2018\3-CN051-Pr-Gini&LinearTrend\',filename2],'Gini_LineTrend_1d_CN051_01','Gini_p_value_1d_CN051_01')
% 
% clear;clc;

filename2 = 'CN051_Daily_Gini_1979_2018_01mmh.mat';
load(['J:\6-硕士毕业论文\1-Data\CN051-TM-Pre-1979-2018\3-CN051-Pr-Gini&LinearTrend\',filename2])
Gini_CN051_1985_2014 = Gini_CN051(:,:,7:end-4);
clear Gini_CN051

Gini_Sen_slope_1d = nan(size(Gini_CN051_1985_2014,1),size(Gini_CN051_1985_2014,2));
Gini_MK_1d = nan(size(Gini_CN051_1985_2014,1),size(Gini_CN051_1985_2014,2));
% 计算Sen趋势
for i = 1 : size(Gini_CN051_1985_2014,1)
    for j = 1 : size(Gini_CN051_1985_2014,2)
        a = reshape(Gini_CN051_1985_2014(i,j,:),[1,size(Gini_CN051_1985_2014,3)]);
        Gini_Sen_slope_1d(i,j) = Theil_Sen_Regress((1985:2014)',a');
        Gini_MK_1d(i,j) = MK(a');
        clear a
    end
end

clear filename2
filename2 = 'CN051_Daily_Gini_Sen_Trend_1985_2014_01mmh.mat';
save(['J:\6-硕士毕业论文\1-Data\CN051-TM-Pre-1979-2018\3-2-CN051-Pr-Gini&SenTrend\',filename2],'Gini_Sen_slope_1d','Gini_MK_1d','Lon','Lat')




