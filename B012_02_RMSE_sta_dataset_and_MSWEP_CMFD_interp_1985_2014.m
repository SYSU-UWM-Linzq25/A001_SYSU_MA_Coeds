%% 这个文件使用站点的数据到CMFD网格和MSWEP插值到站点位置的基尼系数值
%% 计算RMSE

clear;clc;

filename2 = 'CMFD_12h_and_1d_Gini_01mmh_1985_2014_interp_to_Sta.mat';
load(['J:\6-硕士毕业论文\1-Data\Sta_Data_from_V3.0\CMFD插值到站点位置\',filename2])

filename2 = 'MSWEP_12h_and_1d_Gini_01mmh_1985_2014_interp_to_Sta.mat';
load(['J:\6-硕士毕业论文\1-Data\Sta_Data_from_V3.0\MSWEP插值到站点位置\',filename2])

filename2 = 'Sta_12h_and_1d_Gini_01mmh_1985_2014.mat';
load(['J:\6-硕士毕业论文\1-Data\Sta_Data_from_V3.0\气象站点数据V3.0-计算的基尼系数\',filename2])

% 计算RMSE
RMSE_sta_and_CMFD_12h = nan(size(Subdaily_Gini_sta_01mmh_1985_2014,1),1);
RMSE_sta_and_CMFD_1d = nan(size(Subdaily_Gini_sta_01mmh_1985_2014,1),1);
RMSE_sta_and_MSWEP_12h = nan(size(Subdaily_Gini_sta_01mmh_1985_2014,1),1);
RMSE_sta_and_MSWEP_1d = nan(size(Subdaily_Gini_sta_01mmh_1985_2014,1),1);
for i = 1 : size(Subdaily_Gini_sta_01mmh_1985_2014,1)
        
        Daily_GI_from_sta = Daily_Gini_sta_01mmh_1985_2014(i,:);
        Subdaily_GI_from_sta = Subdaily_Gini_sta_01mmh_1985_2014(i,:);
        
        GI_12h_CMFD = CMFD_data_interp_sta_subdaily(i,:);
        GI_1d_CMFD = CMFD_data_interp_sta_daily(i,:);
        
        GI_12h_MSWEP = MSWEP_data_interp_sta_subdaily(i,:);
        GI_1d_MSWEP = MSWEP_data_interp_sta_daily(i,:);
        
        % 计算RMSE
        RMSE_sta_and_CMFD_12h(i) = sqrt(mean((GI_12h_CMFD-Subdaily_GI_from_sta).^2));
        RMSE_sta_and_CMFD_1d(i) = sqrt(mean((GI_1d_CMFD-Daily_GI_from_sta).^2));
        RMSE_sta_and_MSWEP_12h(i) = sqrt(mean((GI_12h_MSWEP-Subdaily_GI_from_sta).^2));
        RMSE_sta_and_MSWEP_1d(i) = sqrt(mean((GI_1d_MSWEP-Daily_GI_from_sta).^2));
        
        clear Daily_GI_from_sta Subdaily_GI_from_sta GI_12h_CMFD GI_1d_CMFD GI_12h_MSWEP GI_1d_MSWEP
end

filename2 = 'RMSE_of_sta_and_CMFD_MSWEP_1985_2014.mat';
save(['J:\6-硕士毕业论文\1-Data\Sta_Data_from_V3.0\',filename2],'RMSE_sta_and_CMFD_12h','RMSE_sta_and_CMFD_1d','RMSE_sta_and_MSWEP_12h','RMSE_sta_and_MSWEP_1d')
