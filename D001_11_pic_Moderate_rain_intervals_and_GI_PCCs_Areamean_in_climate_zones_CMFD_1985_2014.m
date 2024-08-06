%% 这个文件根据CMFD历史时期（1985-2014年）计算得到的基尼系数和中雨和小雨降水时段数的相关系数
%% 在气候区内的所有相关系数，箱型图的结果太好了，没法说明
%% 尝试先求中国或者气候区平均，然后再求相关系数

% 尝试中等程度降雨

clear;clc;

% 读取四个时间尺度下
% 中雨时段数的数据
% 四个时间尺度+四个气候区
cd('J:\6-硕士毕业论文\1-Data\CMFD\9-4-GI-and-Moderate-rain-features-in-climate-zones\')
Temporal_scale_name = {'3h','6h','12h','1d'};
climate_zone_name = {'HR','TR','AR','TP'};
for i = 1 : length(Temporal_scale_name)
    for j = 1 : length(climate_zone_name)
        filename = ['GI_and_Moderate_rain_intervals_',Temporal_scale_name{i},'_',climate_zone_name{j}];
        load(filename)
        clear filename
        
        % 计算区域平均
        eval(['Moderate_rain_intervals_Areamean_',Temporal_scale_name{i},'_',climate_zone_name{j},' = nanmean(Moderate_rain_intervals_',Temporal_scale_name{i},'_',climate_zone_name{j},',2);'])
        eval(['GI_Areamean_',Temporal_scale_name{i},'_',climate_zone_name{j},' = nanmean(GI_',Temporal_scale_name{i},'_',climate_zone_name{j},',2);'])
    end
end

% 求区域平均的相关系数
for i = 1 : length(Temporal_scale_name)
    for j = 1 : length(climate_zone_name)
        eval(['[PCCs_1,P_1] = corrcoef(Moderate_rain_intervals_Areamean_',Temporal_scale_name{i},'_',climate_zone_name{j},',GI_Areamean_',Temporal_scale_name{i},'_',climate_zone_name{j},')'])
        eval(['PCCs_Areamean_GI_and_moderate_rain_intervals_',Temporal_scale_name{i},'_',climate_zone_name{j},' = PCCs_1(2);'])
        eval(['P_Areamean_GI_and_moderate_rain_intervals_',Temporal_scale_name{i},'_',climate_zone_name{j},' = P_1(2);'])
        clear PCCs_1 P_1
    end
end

% cosquareheatmap

