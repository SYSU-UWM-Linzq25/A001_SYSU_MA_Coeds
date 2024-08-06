%% 针对集合平均的未来时期和历史时期的年均温气候态气候态开展分析
%% 未来时期包括两个2031-2060、2070-2099
%% 包括计算相对变化率、分气候区统计分析
%% 空间尺度均为0.25°

%% 空间计算全国的气候态绝对变化
clear;clc;
path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')

% 历史时期
save_peth_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\6-0-His-025-scale-MAT-AP\';
cd(save_peth_1)
filename_1 = 'Three_Model_ensemble_average_025_scale_MAT_CN_1985_2014.mat';
load(filename_1)
Model_ensemble_climatic_MAT_His = nanmean(Model_MAT_ensemble_average_year,3);
clear Model_MAT_ensemble_average_year

% 未来两个时期-四个情景
SSP_type = {'ssp126','ssp245','ssp370','ssp585'};
Time_period = {'2031_2060','2070_2099'};

for j = 1 : length(SSP_type)
    for m = 1 : length(Time_period)
        save_peth_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\6-2-future-025-scale-ensemble-climatic-MAT-AP\';
        cd(save_peth_1)
        filename_1 = [SSP_type{j},'_3_Model_ensemble_climatic_MAT_025_scale_CN_',Time_period{m},'.mat'];
        load(filename_1)
        
        eval(['Model_Future_climatic_MAT_',SSP_type{j},'_',Time_period{m},' = Model_MAT_ensemble_climatic_MAT;'])
        clear Model_MAT_ensemble_climatic_MAT
        
        % 绝对变化的矩阵
        eval(['Absolute_change_',SSP_type{j},'_',Time_period{m},' = (Model_Future_climatic_MAT_',SSP_type{j},'_',Time_period{m},' - Model_ensemble_climatic_MAT_His);'])
        filename2 = ['Absolute_change_',SSP_type{j},'_',Time_period{m},'_025_scale_climatic_MAT.mat'];
        save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\9-2-Absolute-change-of-Future-and-His-MAT\',filename2],['Absolute_change_',SSP_type{j},'_',Time_period{m}],'xx_025','yy_025')
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
        filename2 = ['Absolute_change_',SSP_type{j},'_',Time_period{m},'_025_scale_climatic_MAT.mat'];
        load(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\9-2-Absolute-chang-of-Future-and-His-MAT\',filename2])
        
        eval(['Absolute_change_',SSP_type{j},'_',Time_period{m},'_HR = Absolute_change_',SSP_type{j},'_',Time_period{m},'(k_HR);'])
        eval(['Absolute_change_',SSP_type{j},'_',Time_period{m},'_TR = Absolute_change_',SSP_type{j},'_',Time_period{m},'(k_TR);'])
        eval(['Absolute_change_',SSP_type{j},'_',Time_period{m},'_AR = Absolute_change_',SSP_type{j},'_',Time_period{m},'(k_AR);'])
        eval(['Absolute_change_',SSP_type{j},'_',Time_period{m},'_TP = Absolute_change_',SSP_type{j},'_',Time_period{m},'(k_TP);'])
    end
end
for j = 1 : length(SSP_type)
    for m = 1 : length(Time_period)
        clear filename2
        filename2 = ['Absolute_change_',SSP_type{j},'_',Time_period{m},'_025_scale_climatic_MAT_climate_zone.mat'];
        save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\9-2-Absolute-change-of-Future-and-His-MAT\分气候区\',filename2],['Absolute_change_',SSP_type{j},'_',Time_period{m},'_HR'],...
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
filename_1 = 'Three_Model_ensemble_average_025_scale_MAT_CN_1985_2014.mat';
load(filename_1)
Model_ensemble_climatic_MAT_His = nanmean(Model_MAT_ensemble_average_year,3);
clear Model_MAT_ensemble_average_year

% 未来两个时期-四个情景
SSP_type = {'ssp126','ssp245','ssp370','ssp585'};
Time_period = {'2031_2060','2070_2099'};

for j = 1 : length(SSP_type)
    for m = 1 : length(Time_period)
        save_peth_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\6-2-future-025-scale-ensemble-climatic-MAT-AP\';
        cd(save_peth_1)
        filename_1 = [SSP_type{j},'_3_Model_ensemble_climatic_MAT_025_scale_CN_',Time_period{m},'.mat'];
        load(filename_1)
        
        eval(['Model_Future_climatic_MAT_',SSP_type{j},'_',Time_period{m},' = Model_MAT_ensemble_climatic_MAT;'])
        clear Model_MAT_ensemble_climatic_MAT
        
        % 相对变化的矩阵
        eval(['MAT_Percentage_change_',SSP_type{j},'_',Time_period{m},' = (Model_Future_climatic_MAT_',SSP_type{j},'_',Time_period{m},' - Model_ensemble_climatic_MAT_His)./abs(Model_ensemble_climatic_MAT_His);'])
        filename2 = ['Percentage_change_',SSP_type{j},'_',Time_period{m},'_025_scale_climatic_MAT.mat'];
        save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\9-5-Relative-change-of-Future-and-His-MAT\',filename2],['MAT_Percentage_change_',SSP_type{j},'_',Time_period{m}],'xx_025','yy_025')
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
        filename2 = ['Percentage_change_',SSP_type{j},'_',Time_period{m},'_025_scale_climatic_MAT.mat'];
        load(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\9-5-Relative-change-of-Future-and-His-MAT\',filename2])
        
        eval(['MAT_Percentage_change_',SSP_type{j},'_',Time_period{m},'_HR = MAT_Percentage_change_',SSP_type{j},'_',Time_period{m},'(k_HR);'])
        eval(['MAT_Percentage_change_',SSP_type{j},'_',Time_period{m},'_TR = MAT_Percentage_change_',SSP_type{j},'_',Time_period{m},'(k_TR);'])
        eval(['MAT_Percentage_change_',SSP_type{j},'_',Time_period{m},'_AR = MAT_Percentage_change_',SSP_type{j},'_',Time_period{m},'(k_AR);'])
        eval(['MAT_Percentage_change_',SSP_type{j},'_',Time_period{m},'_TP = MAT_Percentage_change_',SSP_type{j},'_',Time_period{m},'(k_TP);'])
    end
end
for j = 1 : length(SSP_type)
    for m = 1 : length(Time_period)
        clear filename2
        filename2 = ['MAT_Percentage_change_',SSP_type{j},'_',Time_period{m},'_025_scale_climatic_MAT_climate_zone.mat'];
        save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\9-5-Relative-change-of-Future-and-His-MAT\分气候区\',filename2],['MAT_Percentage_change_',SSP_type{j},'_',Time_period{m},'_HR'],...
            ['MAT_Percentage_change_',SSP_type{j},'_',Time_period{m},'_TR'],...
            ['MAT_Percentage_change_',SSP_type{j},'_',Time_period{m},'_AR'],...
            ['MAT_Percentage_change_',SSP_type{j},'_',Time_period{m},'_TP'],'xx_025','yy_025')
    end
end




