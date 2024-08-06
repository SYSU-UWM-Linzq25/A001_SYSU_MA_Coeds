%% 针对集合平均的未来时期和历史时期的年降水量气候态开展分析
%% 未来时期包括两个2031-2060、2070-2099
%% 包括计算相对变化率、分气候区统计分析
%% 空间尺度均为0.25°

%% 空间计算全国的气候态绝对变化
clear;clc;
path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')

% 历史时期
save_peth_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\6-0-His-025-scale-MAT-AP\';
cd(save_peth_1)
filename_1 = 'Three_Model_ensemble_average_025_scale_AP_CN_1985_2014.mat';
load(filename_1)
Model_ensemble_climatic_AP_His = nanmean(Model_AP_ensemble_average_year,3);
clear Model_AP_ensemble_average_year

% 未来两个时期-四个情景
SSP_type = {'ssp126','ssp245','ssp370','ssp585'};
Time_period = {'2031_2060','2070_2099'};

for j = 1 : length(SSP_type)
    for m = 1 : length(Time_period)
        save_peth_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\6-2-future-025-scale-ensemble-climatic-MAT-AP\';
        cd(save_peth_1)
        filename_1 = [SSP_type{j},'_3_Model_ensemble_climatic_AP_025_scale_CN_',Time_period{m},'.mat'];
        load(filename_1)
        
        eval(['Model_Future_climatic_AP_',SSP_type{j},'_',Time_period{m},' = Model_AP_ensemble_climatic_AP;'])
        clear Model_AP_ensemble_climatic_AP
        
        % 绝对变化的矩阵
        eval(['Absolute_change_',SSP_type{j},'_',Time_period{m},' = (Model_Future_climatic_AP_',SSP_type{j},'_',Time_period{m},' - Model_ensemble_climatic_AP_His);'])
        filename2 = ['Absolute_change_',SSP_type{j},'_',Time_period{m},'_025_scale_climatic_AP.mat'];
        save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\9-3-Absolute-cahnge-of-Future-and-His-AP\',filename2],['Absolute_change_',SSP_type{j},'_',Time_period{m}],'xx_025','yy_025')
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
        filename2 = ['Absolute_change_',SSP_type{j},'_',Time_period{m},'_025_scale_climatic_AP.mat'];
        load(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\9-3-Absolute-cahnge-of-Future-and-His-AP\',filename2])
        
        eval(['Absolute_change_',SSP_type{j},'_',Time_period{m},'_HR = Absolute_change_',SSP_type{j},'_',Time_period{m},'(k_HR);'])
        eval(['Absolute_change_',SSP_type{j},'_',Time_period{m},'_TR = Absolute_change_',SSP_type{j},'_',Time_period{m},'(k_TR);'])
        eval(['Absolute_change_',SSP_type{j},'_',Time_period{m},'_AR = Absolute_change_',SSP_type{j},'_',Time_period{m},'(k_AR);'])
        eval(['Absolute_change_',SSP_type{j},'_',Time_period{m},'_TP = Absolute_change_',SSP_type{j},'_',Time_period{m},'(k_TP);'])
    end
end
for j = 1 : length(SSP_type)
    for m = 1 : length(Time_period)
        clear filename2
        filename2 = ['Absolute_change_',SSP_type{j},'_',Time_period{m},'_025_scale_climatic_AP_climate_zone.mat'];
        save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\9-3-Absolute-cahnge-of-Future-and-His-AP\分气候区\',filename2],['Absolute_change_',SSP_type{j},'_',Time_period{m},'_HR'],...
            ['Absolute_change_',SSP_type{j},'_',Time_period{m},'_TR'],...
            ['Absolute_change_',SSP_type{j},'_',Time_period{m},'_AR'],...
            ['Absolute_change_',SSP_type{j},'_',Time_period{m},'_TP'],'xx_025','yy_025')
    end
end


%% 补充相对变化率的计算

clear;clc;
path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')

% 历史时期
save_peth_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\6-0-His-025-scale-MAT-AP\';
cd(save_peth_1)
filename_1 = 'Three_Model_ensemble_average_025_scale_AP_CN_1985_2014.mat';
load(filename_1)
Model_ensemble_climatic_AP_His = nanmean(Model_AP_ensemble_average_year,3);
clear Model_AP_ensemble_average_year

% 未来两个时期-四个情景
SSP_type = {'ssp126','ssp245','ssp370','ssp585'};
Time_period = {'2031_2060','2070_2099'};

for j = 1 : length(SSP_type)
    for m = 1 : length(Time_period)
        save_peth_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\6-2-future-025-scale-ensemble-climatic-MAT-AP\';
        cd(save_peth_1)
        filename_1 = [SSP_type{j},'_3_Model_ensemble_climatic_AP_025_scale_CN_',Time_period{m},'.mat'];
        load(filename_1)
        
        eval(['Model_Future_climatic_AP_',SSP_type{j},'_',Time_period{m},' = Model_AP_ensemble_climatic_AP;'])
        clear Model_AP_ensemble_climatic_AP
        
        % 绝对变化的矩阵
        eval(['AP_Percentage_change_',SSP_type{j},'_',Time_period{m},' = (Model_Future_climatic_AP_',SSP_type{j},'_',Time_period{m},' - Model_ensemble_climatic_AP_His)./abs(Model_ensemble_climatic_AP_His);'])
        filename2 = ['Percentage_change_',SSP_type{j},'_',Time_period{m},'_025_scale_climatic_AP.mat'];
        save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\9-6-Relative-cahnge-of-Future-and-His-AP\',filename2],['AP_Percentage_change_',SSP_type{j},'_',Time_period{m}],'xx_025','yy_025')
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
        filename2 = ['Percentage_change_',SSP_type{j},'_',Time_period{m},'_025_scale_climatic_AP.mat'];
        load(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\9-6-Relative-cahnge-of-Future-and-His-AP\',filename2])
        
        eval(['AP_Percentage_change_',SSP_type{j},'_',Time_period{m},'_HR = AP_Percentage_change_',SSP_type{j},'_',Time_period{m},'(k_HR);'])
        eval(['AP_Percentage_change_',SSP_type{j},'_',Time_period{m},'_TR = AP_Percentage_change_',SSP_type{j},'_',Time_period{m},'(k_TR);'])
        eval(['AP_Percentage_change_',SSP_type{j},'_',Time_period{m},'_AR = AP_Percentage_change_',SSP_type{j},'_',Time_period{m},'(k_AR);'])
        eval(['AP_Percentage_change_',SSP_type{j},'_',Time_period{m},'_TP = AP_Percentage_change_',SSP_type{j},'_',Time_period{m},'(k_TP);'])
    end
end
for j = 1 : length(SSP_type)
    for m = 1 : length(Time_period)
        clear filename2
        filename2 = ['Percentage_change_',SSP_type{j},'_',Time_period{m},'_025_scale_climatic_AP_climate_zone.mat'];
        save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\9-6-Relative-cahnge-of-Future-and-His-AP\分气候区\',filename2],['AP_Percentage_change_',SSP_type{j},'_',Time_period{m},'_HR'],...
            ['AP_Percentage_change_',SSP_type{j},'_',Time_period{m},'_TR'],...
            ['AP_Percentage_change_',SSP_type{j},'_',Time_period{m},'_AR'],...
            ['AP_Percentage_change_',SSP_type{j},'_',Time_period{m},'_TP'],'xx_025','yy_025')
    end
end





