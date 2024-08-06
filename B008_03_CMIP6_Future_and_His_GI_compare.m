%% 针对集合平均的未来时期和历史时期的基尼系数气候态开展分析
%% 未来时期包括两个2031-2060、2070-2099
%% 包括计算相对变化率、分气候区统计分析
%% 基尼系数气候态的历史时期与未来时期相比下的相对变化量

%% 需要加入校正矩阵，因为计算的是相对变化率，历史时期加入校正，在分母，会改变相对变化率

clear;clc;
path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')
% 读取校正的矩阵
load('J:\6-硕士毕业论文\1-Data\Correcttion_matrix_for_CMIP6_future\Correction_matrix_from_His_for_future.mat')

% 历史时期
load('J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\5-1-His-pr-025-scale-Gini\asemble\Three_Model_ensemble_average_025_scale_Gini_CN_1985_2014.mat')
Model_His_GI_ensemble_climatic = nanmean(Model_GI_ensemble_average_year,3);
clear Model_GI_ensemble_average_year
% 加上校正
Model_His_GI_ensemble_climatic = Model_His_GI_ensemble_climatic + Correction_matrix_for_CMIP6_GI;

% 未来两个时期-四个情景
SSP_type = {'ssp126','ssp245','ssp370','ssp585'};
Time_period = {'2031_2060','2070_2099'};

for j = 1 : length(SSP_type)
    for m = 1 : length(Time_period)
        save_peth_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\7-3-future-025-scale-ensemble-climatic-GI\';
        cd(save_peth_1)
        filename_1 = [SSP_type{j},'_3_Model_ensemble_climatic_GI_025_scale_CN_',Time_period{m},'.mat'];
        load(filename_1)
        % 加上校正
        eval(['Model_Future_climatic_GI_',SSP_type{j},'_',Time_period{m},' = Model_GI_ensemble_climatic_GI + Correction_matrix_for_CMIP6_GI;'])
        clear Model_GI_ensemble_climatic_GI
        
        % 相对变化率的矩阵
        eval(['Relative_change_percent_',SSP_type{j},'_',Time_period{m},' = (Model_Future_climatic_GI_',SSP_type{j},'_',Time_period{m},' - Model_His_GI_ensemble_climatic)./Model_His_GI_ensemble_climatic;'])
        filename2 = ['Relative_change_percent_',SSP_type{j},'_',Time_period{m},'_025_scale.mat'];
        save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\9-1-Relative-change-percent-of-Future-and-His_Gi\',filename2],['Relative_change_percent_',SSP_type{j},'_',Time_period{m}],'xx_025','yy_025')
        clear filename2 filename_1
    end
end



%% 分气候区的计算
clear;clc;

% 读取气候分区的index
load(['J:\6-硕士毕业论文\1-Data\Climate_zone_index\', 'Four_Climite_zone_index_025_scale.mat'])
% 提取气候区的索引
k_HR = find(Four_climate_zone_index_025 == 1);
k_TR = find(Four_climate_zone_index_025 == 2);
k_AR = find(Four_climate_zone_index_025 == 3);
k_TP = find(Four_climate_zone_index_025 == 4);

% 未来两个时期-四个情景
SSP_type = {'ssp126','ssp245','ssp370','ssp585'};
Time_period = {'2031_2060','2070_2099'};

for j = 1 : length(SSP_type)
    for m = 1 : length(Time_period)
        filename2 = ['Relative_change_percent_',SSP_type{j},'_',Time_period{m},'_025_scale.mat'];
        load(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\9-1-Relative-change-percent-of-Future-and-His_Gi\',filename2])
        
        eval(['GI_Relative_change_percent_',SSP_type{j},'_',Time_period{m},'_HR = Relative_change_percent_',SSP_type{j},'_',Time_period{m},'(k_HR);'])
        eval(['GI_Relative_change_percent_',SSP_type{j},'_',Time_period{m},'_TR = Relative_change_percent_',SSP_type{j},'_',Time_period{m},'(k_TR);'])
        eval(['GI_Relative_change_percent_',SSP_type{j},'_',Time_period{m},'_AR = Relative_change_percent_',SSP_type{j},'_',Time_period{m},'(k_AR);'])
        eval(['GI_Relative_change_percent_',SSP_type{j},'_',Time_period{m},'_TP = Relative_change_percent_',SSP_type{j},'_',Time_period{m},'(k_TP);'])
    end
end
for j = 1 : length(SSP_type)
    for m = 1 : length(Time_period)
        clear filename2
        filename2 = ['Relative_change_percent_',SSP_type{j},'_',Time_period{m},'_025_scale_climatic_GI_climate_zone.mat'];
        save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\9-1-Relative-change-percent-of-Future-and-His_Gi\分气候区\',filename2],['GI_Relative_change_percent_',SSP_type{j},'_',Time_period{m},'_HR'],...
            ['GI_Relative_change_percent_',SSP_type{j},'_',Time_period{m},'_TR'],...
            ['GI_Relative_change_percent_',SSP_type{j},'_',Time_period{m},'_AR'],...
            ['GI_Relative_change_percent_',SSP_type{j},'_',Time_period{m},'_TP'],'xx_025','yy_025')
    end
end








