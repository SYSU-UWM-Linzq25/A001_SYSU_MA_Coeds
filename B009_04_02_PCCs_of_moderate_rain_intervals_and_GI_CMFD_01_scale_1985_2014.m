%% 这个文件计算中雨的年内时段数对降水集中度的影响
%% 对象为CMFD历史时期，空间分辨率为0.1°
%% 这里计算的是四个气候区，逐个网格下的时间维度上的相关系数

clear;clc;

% 读取原始空间分辨率的基尼系数
% 3-hour
% 3h
filename2 = 'CMFD_3h_Gini_1979_2018_01mmh.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\3-1-Gini&LinearTrend\',filename2])
% 统一选取年份范围为1985-2014
Gini_CMFD_3h_1985_2014 = Gini_CMFD_3h(:,:,7:end-4);
clear Gini_CMFD_3h

% 6-hour
clear filename2
filename2 = 'Full Gini index 6h.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\0-from-paper2\6h\full Gini\',filename2])
% 统一选取年份范围为1985-2014
Gini_CMFD_6h_1985_2014 = Full_Gini_6h_all(:,:,7:end-4);
clear Full_Gini_6h_all

% 12h
path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')
clear filename2
filename2 = 'Full Gini index 12h.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\0-from-paper2\12h\full Gini\',filename2])
% 统一选取年份范围为1985-2014
Gini_CMFD_12h_1985_2014 = Full_Gini_12h_all(:,:,7:end-4);
clear Full_Gini_12h_all

% 1d
clear filename2
filename2 = 'Full Gini index 1d.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\0-from-paper2\1d\full Gini\',filename2])
% 统一选取年份范围为1985-2014
Gini_CMFD_1d_1985_2014 = Full_Gini_1d_all(:,:,7:end-4);
clear Full_Gini_1d_all

% 读取中雨和小雨时段总数
% 3-hour
cd('J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\3h\Moderate_rain_intervals_3D_matrix\')
load('Moderate_rain_intervals_01_scale_3h_pre_event_thresold_5_95_matrix.mat')

% 6-hour
cd('J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\6h-from-Paper2\Moderate_rain_intervals_3D_matrix\')
load('Moderate_rain_intervals_01_scale_6h_pre_event_thresold_5_95_matrix.mat')

% 12-hour
cd('J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\12h-from-Paper2\Moderate_rain_intervals_3D_matrix\')
load('Moderate_rain_intervals_01_scale_12h_pre_event_thresold_5_95_matrix.mat')

% 1-day
cd('J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\1d-from-Paper2\Moderate_rain_intervals_3D_matrix\')
load('Moderate_rain_intervals_01_scale_1d_pre_event_thresold_5_95_matrix.mat')

% 读取气候区的分界
% 读取气候分区的index
load(['J:\6-硕士毕业论文\1-Data\Climate_zone_index\', 'Four_Climite_zone_index_01_scale.mat'])
% 提取气候区的索引
k_HR = find(Four_climate_zone_index_01 == 1);
k_TR = find(Four_climate_zone_index_01 == 2);
k_AR = find(Four_climate_zone_index_01 == 3);
k_TP = find(Four_climate_zone_index_01 == 4);

Temporal_scale_name = {'3h','6h','12h','1d'};
climate_zone_name = {'HR','TR','AR','TP'};

% 首先利用循环创建变量
for i = 1 : length(Temporal_scale_name)
    for j = 1 : length(climate_zone_name)
        eval(['GI_',Temporal_scale_name{i},'_',climate_zone_name{j},' = nan(size(Gini_CMFD_3h_1985_2014,3),length(k_',climate_zone_name{j},'));'])
        eval(['Moderate_rain_intervals_',Temporal_scale_name{i},'_',climate_zone_name{j},' = nan(size(Gini_CMFD_3h_1985_2014,3),length(k_',climate_zone_name{j},'));'])
%         eval(['heavy_rain_amount_percentage_',Temporal_scale_name{i},'_',climate_zone_name{j},' = nan(size(Gini_CMFD_3h_1985_2014,3),length(k_',climate_zone_name{j},'));'])
        
        eval(['PCCs_GI_and_Moderate_rain_intervals_',Temporal_scale_name{i},'_',climate_zone_name{j},' = nan(1,length(k_',climate_zone_name{j},'));'])
%         eval(['PCCs_GI_and_heavy_rain_amount_percentage_',Temporal_scale_name{i},'_',climate_zone_name{j},' = nan(1,length(k_',climate_zone_name{j},'));'])
        eval(['P_GI_and_Moderate_rain_intervals_',Temporal_scale_name{i},'_',climate_zone_name{j},' = nan(1,length(k_',climate_zone_name{j},'));'])
%         eval(['P_GI_and_heavy_rain_amount_percentage_',Temporal_scale_name{i},'_',climate_zone_name{j},' = nan(1,length(k_',climate_zone_name{j},'));'])
    end
end

% 根据气候区和时间尺度，分别提取降水集中度和暴雨发生频率/暴雨雨量占比
for i = 1 : length(Temporal_scale_name)
    for j = 1 : length(climate_zone_name)
        for year = 1 : size(Gini_CMFD_3h_1985_2014,3)
            % 提取逐年的数据
            eval(['GI_',Temporal_scale_name{i},'_year = Gini_CMFD_',Temporal_scale_name{i},'_1985_2014(:,:,year);'])
            eval(['Moderate_rain_intervals_',Temporal_scale_name{i},'_year = Moderate_rain_intervals_',Temporal_scale_name{i},'_matrix(:,:,year);'])
%             eval(['heavy_rain_amount_percentage_',Temporal_scale_name{i},'_year = heavy_rain_amount_percentage_',Temporal_scale_name{i},'_matrix(:,:,year);'])
            eval(['GI_',Temporal_scale_name{i},'_',climate_zone_name{j},'(year,:) = GI_',Temporal_scale_name{i},'_year(k_',climate_zone_name{j},');'])
            eval(['Moderate_rain_intervals_',Temporal_scale_name{i},'_',climate_zone_name{j},'(year,:) = Moderate_rain_intervals_',Temporal_scale_name{i},'_year(k_',climate_zone_name{j},');'])
%             eval(['heavy_rain_amount_percentage_',Temporal_scale_name{i},'_',climate_zone_name{j},'(year,:) = heavy_rain_amount_percentage_',Temporal_scale_name{i},'_year(k_',climate_zone_name{j},');'])
        end
        eval(['clear GI_',Temporal_scale_name{i},'_year Moderate_rain_intervals_',Temporal_scale_name{i},'_year '])
    end
end

% 循环保存变量
for i = 1 : length(Temporal_scale_name)
    for j = 1 : length(climate_zone_name)
        savepath2 = 'J:\6-硕士毕业论文\1-Data\CMFD\9-4-GI-and-Moderate-rain-features-in-climate-zones\';
        filename2 = ['GI_and_Moderate_rain_intervals_',Temporal_scale_name{i},'_',climate_zone_name{j},'.mat'];
        eval(['save([savepath2,filename2],''GI_',Temporal_scale_name{i},'_',climate_zone_name{j},''',''Moderate_rain_intervals_',Temporal_scale_name{i},'_',climate_zone_name{j},''')'])
    end
end

%% 计算相关系数
for i = 1 : length(Temporal_scale_name)
    for j = 1 : length(climate_zone_name)
        clear K_len
        eval(['K_len = length(k_',climate_zone_name{j},')'])
        
        for n = 1 : K_len
            eval(['GI_1 = GI_',Temporal_scale_name{i},'_',climate_zone_name{j},'(:,n);'])
            eval(['Moderate_rain_intervals_1 = Moderate_rain_intervals_',Temporal_scale_name{i},'_',climate_zone_name{j},'(:,n);'])
%             eval(['Heavy_rain_amount_percentage_1 = heavy_rain_amount_percentage_',Temporal_scale_name{i},'_',climate_zone_name{j},'(:,n);'])
            
            [PCCs_1,P_1] = corrcoef(Moderate_rain_intervals_1,GI_1);
%             [PCCs_2,P_2] = corrcoef(Heavy_rain_amount_percentage_1,GI_1);
            
            eval(['PCCs_GI_and_Moderate_rain_intervals_',Temporal_scale_name{i},'_',climate_zone_name{j},'(n) = PCCs_1(2);'])
%             eval(['PCCs_GI_and_heavy_rain_amount_percentage_',Temporal_scale_name{i},'_',climate_zone_name{j},'(n) = PCCs_2(2);'])
            eval(['P_GI_and_Moderate_rain_intervals_',Temporal_scale_name{i},'_',climate_zone_name{j},'(n) = P_1(2);'])
%             eval(['P_GI_and_heavy_rain_amount_percentage_',Temporal_scale_name{i},'_',climate_zone_name{j},'(n) = P_2(2);'])
            
            clear PCCs_1 P_1 GI_1 Moderate_rain_intervals_1 
        end
        
        savepath2 = 'J:\6-硕士毕业论文\1-Data\PCCs-bewteen-Moderate-rain-features-and-GI\';
        filename2 = ['PCCs_GI_and_Moderate_rain_intervals_',Temporal_scale_name{i},'_',climate_zone_name{j},'.mat'];
        eval(['save([savepath2,filename2],''PCCs_GI_and_Moderate_rain_intervals_',Temporal_scale_name{i},'_',climate_zone_name{j},''',''P_GI_and_Moderate_rain_intervals_',Temporal_scale_name{i},'_',climate_zone_name{j},''')'])
%         filename3 = ['PCCs_GI_and_heavy_rain_amount_percentage_',Temporal_scale_name{i},'_',climate_zone_name{j},'.mat'];
%         eval(['save([savepath2,filename3],''PCCs_GI_and_heavy_rain_amount_percentage_',Temporal_scale_name{i},'_',climate_zone_name{j},''',''P_GI_and_heavy_rain_amount_percentage_',Temporal_scale_name{i},'_',climate_zone_name{j},''')'])
    end
end

