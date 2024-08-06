%% 这个文件做统计表，基于CMFD数据，统计四个气候区下的区域平均基尼系数和年均温的相关关系表
%% 空间尺度都是0.1°，没有升尺度
%% 研究时期为历史时期：1985-2014

clear;clc;

% 读取四种时间尺度的基尼系数
% 3h
filename2 = 'CMFD_3h_Gini_1979_2018_01mmh.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\3-1-Gini&LinearTrend\',filename2])
% 统一选取年份范围为1985-2014
Gini_CMFD_3h_1985_2014 = Gini_CMFD_3h(:,:,7:end-4);
clear Gini_CMFD_3h 

% 6h
path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')
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

% 读取年降水量数据集
clear filename2
filename2 = 'AP_3h_01mmh_1979_2018.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\5-1-CMFD-01-scale-AP-and-MAT-01mmh\',filename2]);
AP_01mmh_1985_2014 = Annual_Pr_3h_01mmh(:,:,7:end-4);
clear Annual_Pr_3h_01mmh

% 根据气候区进行划分
% 读取气候分区的index
load(['J:\6-硕士毕业论文\1-Data\Climate_zone_index\', 'Four_Climite_zone_index_01_scale.mat'])
% 提取气候区的索引
k_HR = find(Four_climate_zone_index_01 == 1);
k_TR = find(Four_climate_zone_index_01 == 2);
k_AR = find(Four_climate_zone_index_01 == 3);
k_TP = find(Four_climate_zone_index_01 == 4);

Temporal_scale_name = {'3h','6h','12h','1d'};
climate_zone_name = {'HR','TR','AR','TP'};

for year = 1 : size(AP_01mmh_1985_2014,3) % 逐年计算气候区的区域平均
    AP_year = AP_01mmh_1985_2014(:,:,year);
    for n = 1 : length(climate_zone_name)
        eval(['AP_',climate_zone_name{n},'(year,1) = nanmean(AP_year(k_',climate_zone_name{n},'));'])
    end
    % 读取该年下的四个时间尺度的GI
    for i = 1 : length(Temporal_scale_name)
        eval(['GI_',Temporal_scale_name{i},'_year = Gini_CMFD_',Temporal_scale_name{i},'_1985_2014(:,:,year);'])
        % 按照气候区索引提取
        for j = 1 : length(climate_zone_name)
            eval(['GI_',Temporal_scale_name{i},'_',climate_zone_name{j},'(year,1) = nanmean(GI_',Temporal_scale_name{i},'_year(k_',climate_zone_name{j},'));'])
        end
    end
    
    clear AP_year GI_3h_year GI_6h_year GI_12h_year GI_1d_year
end

% 计算相关系数和P值
PCCs_AP_GI_climatic_zone_Areamean = nan(4,4); % 横轴表示时间尺度的变化，纵轴表示气候区的变化
P_AP_GI_climatic_zone_Areamean = nan(4,4); % 横轴表示时间尺度的变化，纵轴表示气候区的变化

for i = 1 : length(Temporal_scale_name)
    for j = 1 : length(climate_zone_name)
        
        eval(['[PCCs_1,P_1] = corrcoef(AP_',climate_zone_name{j},', GI_',Temporal_scale_name{i},'_',climate_zone_name{j},');'])
        
        PCCs_AP_GI_climatic_zone_Areamean(i,j) = PCCs_1(2);
        P_AP_GI_climatic_zone_Areamean(i,j) = P_1(2);
        
        clear PCCs_1 P_1
    end
end

%% 制表
Table = cell(4,4);
% 横轴为时间尺度
% 纵轴为气候区

Table = num2cell(PCCs_AP_GI_climatic_zone_Areamean);
for i = 1 : size(Table,1)
    for j = 1 : size(Table,2)
        aa = Table{i,j};
        PP = P_AP_GI_climatic_zone_Areamean(i,j);
        % 判断相关系数是否显著
        if PP < 0.01
            Table{i,j} = [num2str(roundn(aa,-2),'%4.2f'),'**'];% 保留两位小数
        elseif PP < 0.05
            Table{i,j} = [num2str(roundn(aa,-2),'%4.2f'),'*'];% 保留两位小数
        else
            Table{i,j} = num2str(roundn(aa,-2),'%4.2f');% 保留两位小数
        end
        clear aa PP
    end
end


cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\010-03-Table-PCCs_bewteen_climate_zone_Areamean_AP_and_GI\')
filename = 'Table-4.3.1.xls';
xlswrite(filename, Table);
