%% 这个文件根据历史和未来两个时期和历史时期中年均温的气候态进行画图
%% 未来时期是2031-2060年
%% 历史时期是1985-2014年
%% 使用的都是CMIP6数据
%% 画统计表
%% 在不同气候区

clear;clc;

% 历史时期
save_peth_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\6-0-His-025-scale-MAT-AP\';
cd(save_peth_1)
filename_1 = 'Three_Model_ensemble_average_025_scale_MAT_CN_1985_2014.mat';
load(filename_1)

% 多年平均
Model_MAT_ensemble_average_climatic = nanmean(Model_MAT_ensemble_average_year,3);
clear Model_MAT_ensemble_average_year

% 转为单列
Model_MAT_ensemble_average_climatic_line = reshape(Model_MAT_ensemble_average_climatic,[1,size(Model_MAT_ensemble_average_climatic,1)*size(Model_MAT_ensemble_average_climatic,2)]);
clear Model_MAT_ensemble_average_climatic



% 未来两个时期-四个情景
SSP_type = {'ssp126','ssp245','ssp370','ssp585'};
Time_period = {'2031_2060'};

for j = 1 : length(SSP_type)
    for m = 1 : length(Time_period)
        save_peth_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\6-2-future-025-scale-ensemble-climatic-MAT-AP\';
        cd(save_peth_1)
        filename_1 = [SSP_type{j},'_3_Model_ensemble_climatic_MAT_025_scale_CN_',Time_period{m},'.mat'];
        load(filename_1)
        
        eval(['Model_Future_climatic_MAT_',SSP_type{j},'_',Time_period{m},' = Model_MAT_ensemble_climatic_MAT;'])
        clear Model_MAT_ensemble_climatic_MAT
        
        eval(['Model_Future_climatic_MAT_',SSP_type{j},'_',Time_period{m},'_line = reshape(Model_Future_climatic_MAT_',SSP_type{j},'_',Time_period{m},',[1,size(xx_025,1)*size(xx_025,2)]);'])
        
    end
end

% 整合在一起
MAT_CN = nan(length(Model_MAT_ensemble_average_climatic_line),5);
MAT_CN(:,1) = Model_MAT_ensemble_average_climatic_line';
MAT_CN(:,2) = Model_Future_climatic_MAT_ssp126_2031_2060_line';
MAT_CN(:,3) = Model_Future_climatic_MAT_ssp245_2031_2060_line';
MAT_CN(:,4) = Model_Future_climatic_MAT_ssp370_2031_2060_line';
MAT_CN(:,5) = Model_Future_climatic_MAT_ssp585_2031_2060_line';

clearvars -except MAT_CN

% 读取气候分区的index
load(['J:\6-硕士毕业论文\1-Data\Climate_zone_index\', 'Four_Climite_zone_index_025_scale.mat'])
Four_climate_zone_index_025_line = reshape(Four_climate_zone_index_025,[length(Lon_025)*length(Lat_025),1]);
clear Four_climate_zone_index_025
% 提取气候区的索引(按单列的做)
k_HR = find(Four_climate_zone_index_025_line == 1);
k_TR = find(Four_climate_zone_index_025_line == 2);
k_AR = find(Four_climate_zone_index_025_line == 3);
k_TP = find(Four_climate_zone_index_025_line == 4);
clear Four_climate_zone_index_025_line

MAT_HR = MAT_CN(k_HR,:);
MAT_TR = MAT_CN(k_TR,:);
MAT_AR = MAT_CN(k_AR,:);
MAT_TP = MAT_CN(k_TP,:);

MAT_all_Areamean = nan(5,5);
MAT_all_Areamean(1,:) = nanmean(MAT_CN,1);
MAT_all_Areamean(2,:)  = nanmean(MAT_HR,1);
MAT_all_Areamean(3,:)  = nanmean(MAT_TR,1);
MAT_all_Areamean(4,:)  = nanmean(MAT_AR,1);
MAT_all_Areamean(5,:)  = nanmean(MAT_TP,1);


Table = num2cell(MAT_all_Areamean);
for i = 1 : size(Table,1)
    for j = 1 : size(Table,2)
        aa = Table{i,j};
        Table{i,j} = [num2str(roundn(aa,-1),'%4.1f')];% 保留两位小数
    end
end


cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\004-02-CMIP6-Future-and-His-MAT-Absolute-change\')
filename = 'Table-5.2.1.xls';
xlswrite(filename, Table);


%% 加入年降水量的统计表

clear;clc;

% 历史时期
save_peth_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\6-0-His-025-scale-MAT-AP\';
cd(save_peth_1)
filename_1 = 'Three_Model_ensemble_average_025_scale_AP_CN_1985_2014.mat';
load(filename_1)

% 多年平均
Model_AP_ensemble_average_year_mean = nanmean(Model_AP_ensemble_average_year,3);
clear Model_AP_ensemble_average_year

% 转为单列
Model_AP_ensemble_average_year_line = reshape(Model_AP_ensemble_average_year_mean,[1,size(Model_AP_ensemble_average_year_mean,1)*size(Model_AP_ensemble_average_year_mean,2)]);
clear Model_AP_ensemble_average_year_mean


% 未来两个时期-四个情景
SSP_type = {'ssp126','ssp245','ssp370','ssp585'};
Time_period = {'2031_2060'};

for j = 1 : length(SSP_type)
    for m = 1 : length(Time_period)
        save_peth_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\6-2-future-025-scale-ensemble-climatic-MAT-AP\';
        cd(save_peth_1)
        filename_1 = [SSP_type{j},'_3_Model_ensemble_climatic_AP_025_scale_CN_',Time_period{m},'.mat'];
        load(filename_1)
        
        eval(['Model_Future_climatic_AP_',SSP_type{j},'_',Time_period{m},' = Model_AP_ensemble_climatic_AP;'])
        clear Model_AP_ensemble_climatic_AP
        
        eval(['Model_Future_climatic_AP_',SSP_type{j},'_',Time_period{m},'_line = reshape(Model_Future_climatic_AP_',SSP_type{j},'_',Time_period{m},',[1,size(xx_025,1)*size(xx_025,2)]);'])
        
    end
end

% 整合在一起
AP_CN = nan(length(Model_AP_ensemble_average_year_line),5);
AP_CN(:,1) = Model_AP_ensemble_average_year_line';
AP_CN(:,2) = Model_Future_climatic_AP_ssp126_2031_2060_line';
AP_CN(:,3) = Model_Future_climatic_AP_ssp245_2031_2060_line';
AP_CN(:,4) = Model_Future_climatic_AP_ssp370_2031_2060_line';
AP_CN(:,5) = Model_Future_climatic_AP_ssp585_2031_2060_line';

clearvars -except AP_CN

% 读取气候分区的index
load(['J:\6-硕士毕业论文\1-Data\Climate_zone_index\', 'Four_Climite_zone_index_025_scale.mat'])
Four_climate_zone_index_025_line = reshape(Four_climate_zone_index_025,[length(Lon_025)*length(Lat_025),1]);
clear Four_climate_zone_index_025
% 提取气候区的索引(按单列的做)
k_HR = find(Four_climate_zone_index_025_line == 1);
k_TR = find(Four_climate_zone_index_025_line == 2);
k_AR = find(Four_climate_zone_index_025_line == 3);
k_TP = find(Four_climate_zone_index_025_line == 4);
clear Four_climate_zone_index_025_line

AP_HR = AP_CN(k_HR,:);
AP_TR = AP_CN(k_TR,:);
AP_AR = AP_CN(k_AR,:);
AP_TP = AP_CN(k_TP,:);

AP_all_Areamean = nan(5,5);
AP_all_Areamean(1,:) = nanmean(AP_CN,1);
AP_all_Areamean(2,:)  = nanmean(AP_HR,1);
AP_all_Areamean(3,:)  = nanmean(AP_TR,1);
AP_all_Areamean(4,:)  = nanmean(AP_AR,1);
AP_all_Areamean(5,:)  = nanmean(AP_TP,1);


Table = num2cell(AP_all_Areamean);
for i = 1 : size(Table,1)
    for j = 1 : size(Table,2)
        aa = Table{i,j};
        Table{i,j} = [num2str(roundn(aa,0),'%4.0f')];% 保留两位小数
    end
end


cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\004-03-CMIP6-Future-and-His-AP-Absolute-change\')
filename = 'Table-5.2.2.xls';
xlswrite(filename, Table);
