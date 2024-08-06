%% 这个文件求区域平均的SM和EVA的基尼系数
%% 然后同步计算降水基尼系数的区域平均
%% 线性拟合得到斜率，做统计表
%% 同时尝试相关系数的表格

clear;clc;

cd('J:\6-硕士毕业论文\1-Data\GLEAM-V3.8a-025-scale\')
filename = 'GLEAM_SMsurf_1d_Gini_1985_2014.mat';
load(filename)

cd('J:\6-硕士毕业论文\1-Data\GLEAM-V3.8a-025-scale\')
filename = 'GLEAM_Eva_1d_Gini_remove_negative_1985_2014.mat';
load(filename)

% 降水的基尼系数

% 升尺度的CMFD
% 读取CMFD整合到0.25°上的经纬度坐标
filename2 = 'CMFD_1d_Gini_025_scale_01mmh_1979_2018_from_Paper2.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\0-from-paper2\',filename2])
Gini_CMFD_1d_025_scale_01mmh_1985_2014 = Gini_CMFD_1d_025_scale_01mmh(:,:,7:end-4);
clear Gini_CMFD_1d_025_scale_01mmh

% 转置一下降水的基尼系数
Pre_GI_1d_CMFD = nan(length(Lon_025),length(Lat_025),size(Gini_CMFD_1d_025_scale_01mmh_1985_2014,3));
for i = 1 : size(Gini_CMFD_1d_025_scale_01mmh_1985_2014,3)
    Pre_GI = Gini_CMFD_1d_025_scale_01mmh_1985_2014(:,:,i);
    Pre_GI_1d_CMFD(:,:,i) = Pre_GI';
    clear Pre_GI
end
clear Gini_CMFD_1d_025_scale_01mmh_1985_2014


%读取气候区的索引，分开气候区
% 读取气候分区的index
load(['J:\6-硕士毕业论文\1-Data\Climate_zone_index\', 'Four_Climite_zone_index_025_scale.mat'])
Four_climate_zone_index_025_line = reshape(Four_climate_zone_index_025,[length(Lon_025)*length(Lat_025),1]);
clear Four_climate_zone_index_025
k_HR = find(Four_climate_zone_index_025_line == 1);
k_TR = find(Four_climate_zone_index_025_line == 2);
k_AR = find(Four_climate_zone_index_025_line == 3);
k_TP = find(Four_climate_zone_index_025_line == 4);
clear Four_climate_zone_index_025_line

% 将三种基尼系数在空间上展开
Gini_1d_SMsurf_GLEAM_line = reshape(Gini_1d_SMsurf_GLEAM,[],size(Gini_1d_SMsurf_GLEAM,3));
Gini_1d_Eva_GLEAM_line = reshape(Gini_1d_Eva_GLEAM,[],size(Gini_1d_Eva_GLEAM,3));
Pre_GI_1d_CMFD_line = reshape(Pre_GI_1d_CMFD,[],size(Pre_GI_1d_CMFD,3));
clear Gini_1d_SMsurf_GLEAM Gini_1d_Eva_GLEAM Pre_GI_1d_CMFD

% 根据气候区划分
Pre_GI_1d_CMFD_line_HR = Pre_GI_1d_CMFD_line(k_HR,:);
Pre_GI_1d_CMFD_line_TR = Pre_GI_1d_CMFD_line(k_TR,:);
Pre_GI_1d_CMFD_line_AR = Pre_GI_1d_CMFD_line(k_AR,:);
Pre_GI_1d_CMFD_line_TP = Pre_GI_1d_CMFD_line(k_TP,:);
clear Pre_GI_1d_CMFD_line

Gini_1d_Eva_GLEAM_line_HR = Gini_1d_Eva_GLEAM_line(k_HR,:);
Gini_1d_Eva_GLEAM_line_TR = Gini_1d_Eva_GLEAM_line(k_TR,:);
Gini_1d_Eva_GLEAM_line_AR = Gini_1d_Eva_GLEAM_line(k_AR,:);
Gini_1d_Eva_GLEAM_line_TP = Gini_1d_Eva_GLEAM_line(k_TP,:);
clear Gini_1d_Eva_GLEAM_line

Gini_1d_SMsurf_GLEAM_line_HR = Gini_1d_SMsurf_GLEAM_line(k_HR,:);
Gini_1d_SMsurf_GLEAM_line_TR = Gini_1d_SMsurf_GLEAM_line(k_TR,:);
Gini_1d_SMsurf_GLEAM_line_AR = Gini_1d_SMsurf_GLEAM_line(k_AR,:);
Gini_1d_SMsurf_GLEAM_line_TP = Gini_1d_SMsurf_GLEAM_line(k_TP,:);
clear Gini_1d_SMsurf_GLEAM_line

% 分别计算区域平均
Pre_GI_1d_CMFD_line_HR_Areamen = nanmean(Pre_GI_1d_CMFD_line_HR,1)';
Pre_GI_1d_CMFD_line_TR_Areamen = nanmean(Pre_GI_1d_CMFD_line_TR,1)';
Pre_GI_1d_CMFD_line_AR_Areamen = nanmean(Pre_GI_1d_CMFD_line_AR,1)';
Pre_GI_1d_CMFD_line_TP_Areamen = nanmean(Pre_GI_1d_CMFD_line_TP,1)';
clear Pre_GI_1d_CMFD_line_HR Pre_GI_1d_CMFD_line_TR Pre_GI_1d_CMFD_line_AR Pre_GI_1d_CMFD_line_TP

Gini_1d_Eva_GLEAM_line_HR_Areamen = nanmean(Gini_1d_Eva_GLEAM_line_HR,1)';
Gini_1d_Eva_GLEAM_line_TR_Areamen = nanmean(Gini_1d_Eva_GLEAM_line_TR,1)';
Gini_1d_Eva_GLEAM_line_AR_Areamen = nanmean(Gini_1d_Eva_GLEAM_line_AR,1)';
Gini_1d_Eva_GLEAM_line_TP_Areamen = nanmean(Gini_1d_Eva_GLEAM_line_TP,1)';
clear Gini_1d_Eva_GLEAM_line_HR Gini_1d_Eva_GLEAM_line_TR Gini_1d_Eva_GLEAM_line_AR Gini_1d_Eva_GLEAM_line_TP

Gini_1d_SMsurf_GLEAM_line_HR_Areamen = nanmean(Gini_1d_SMsurf_GLEAM_line_HR,1)';
Gini_1d_SMsurf_GLEAM_line_TR_Areamen = nanmean(Gini_1d_SMsurf_GLEAM_line_TR,1)';
Gini_1d_SMsurf_GLEAM_line_AR_Areamen = nanmean(Gini_1d_SMsurf_GLEAM_line_AR,1)';
Gini_1d_SMsurf_GLEAM_line_TP_Areamen = nanmean(Gini_1d_SMsurf_GLEAM_line_TP,1)';
clear Gini_1d_SMsurf_GLEAM_line_HR Gini_1d_SMsurf_GLEAM_line_TR Gini_1d_SMsurf_GLEAM_line_AR Gini_1d_SMsurf_GLEAM_line_TP

% 计算拟合的斜率和P值
X_HR = [ones(length(Pre_GI_1d_CMFD_line_HR_Areamen),1),Pre_GI_1d_CMFD_line_HR_Areamen];
[b_Eva_Pre_HR,~,~,~,stats_Eva_Pre_HR] = regress(Gini_1d_Eva_GLEAM_line_HR_Areamen,X_HR,0.05);
[b_SM_Pre_HR,~,~,~,stats_SM_Pre_HR] = regress(Gini_1d_SMsurf_GLEAM_line_HR_Areamen,X_HR,0.05);

X_TR = [ones(length(Pre_GI_1d_CMFD_line_TR_Areamen),1),Pre_GI_1d_CMFD_line_TR_Areamen];
[b_Eva_Pre_TR,~,~,~,stats_Eva_Pre_TR] = regress(Gini_1d_Eva_GLEAM_line_TR_Areamen,X_TR,0.05);
[b_SM_Pre_TR,~,~,~,stats_SM_Pre_TR] = regress(Gini_1d_SMsurf_GLEAM_line_TR_Areamen,X_TR,0.05);

X_AR = [ones(length(Pre_GI_1d_CMFD_line_AR_Areamen),1),Pre_GI_1d_CMFD_line_AR_Areamen];
[b_Eva_Pre_AR,~,~,~,stats_Eva_Pre_AR] = regress(Gini_1d_Eva_GLEAM_line_AR_Areamen,X_AR,0.05);
[b_SM_Pre_AR,~,~,~,stats_SM_Pre_AR] = regress(Gini_1d_SMsurf_GLEAM_line_AR_Areamen,X_AR,0.05);

X_TP = [ones(length(Pre_GI_1d_CMFD_line_TP_Areamen),1),Pre_GI_1d_CMFD_line_TP_Areamen];
[b_Eva_Pre_TP,~,~,~,stats_Eva_Pre_TP] = regress(Gini_1d_Eva_GLEAM_line_TP_Areamen,X_TP,0.05);
[b_SM_Pre_TP,~,~,~,stats_SM_Pre_TP] = regress(Gini_1d_SMsurf_GLEAM_line_TP_Areamen,X_TP,0.05);

% 计算相关系数
[PCCs_1,P_1] = corrcoef(Pre_GI_1d_CMFD_line_HR_Areamen,Gini_1d_SMsurf_GLEAM_line_HR_Areamen);
[PCCs_2,P_2] = corrcoef(Pre_GI_1d_CMFD_line_TR_Areamen,Gini_1d_SMsurf_GLEAM_line_TR_Areamen);
[PCCs_3,P_3] = corrcoef(Pre_GI_1d_CMFD_line_AR_Areamen,Gini_1d_SMsurf_GLEAM_line_AR_Areamen);
[PCCs_4,P_4] = corrcoef(Pre_GI_1d_CMFD_line_TP_Areamen,Gini_1d_SMsurf_GLEAM_line_TP_Areamen);

PCCs_1d_SM_Eva_Pre_GI(1,1) = PCCs_1(2);
PCCs_1d_SM_Eva_Pre_GI(2,1) = PCCs_2(2);
PCCs_1d_SM_Eva_Pre_GI(3,1) = PCCs_3(2);
PCCs_1d_SM_Eva_Pre_GI(4,1) = PCCs_4(2);

P_1d_SM_Eva_Pre_GI(1,1) = P_1(2);
P_1d_SM_Eva_Pre_GI(2,1) = P_2(2);
P_1d_SM_Eva_Pre_GI(3,1) = P_3(2);
P_1d_SM_Eva_Pre_GI(4,1) = P_4(2);

clear PCCs_1 P_1 PCCs_2 P_2 PCCs_3 P_3 PCCs_4 P_4
[PCCs_1,P_1] = corrcoef(Pre_GI_1d_CMFD_line_HR_Areamen,Gini_1d_Eva_GLEAM_line_HR_Areamen);
[PCCs_2,P_2] = corrcoef(Pre_GI_1d_CMFD_line_TR_Areamen,Gini_1d_Eva_GLEAM_line_TR_Areamen);
[PCCs_3,P_3] = corrcoef(Pre_GI_1d_CMFD_line_AR_Areamen,Gini_1d_Eva_GLEAM_line_AR_Areamen);
[PCCs_4,P_4] = corrcoef(Pre_GI_1d_CMFD_line_TP_Areamen,Gini_1d_Eva_GLEAM_line_TP_Areamen);

PCCs_1d_SM_Eva_Pre_GI(1,2) = PCCs_1(2);
PCCs_1d_SM_Eva_Pre_GI(2,2) = PCCs_2(2);
PCCs_1d_SM_Eva_Pre_GI(3,2) = PCCs_3(2);
PCCs_1d_SM_Eva_Pre_GI(4,2) = PCCs_4(2);

P_1d_SM_Eva_Pre_GI(1,2) = P_1(2);
P_1d_SM_Eva_Pre_GI(2,2) = P_2(2);
P_1d_SM_Eva_Pre_GI(3,2) = P_3(2);
P_1d_SM_Eva_Pre_GI(4,2) = P_4(2);
clear PCCs_1 P_1 PCCs_2 P_2 PCCs_3 P_3 PCCs_4 P_4


Table = cell(4,2);

LinearTend_all_climate = nan(4,2);
LinearTend_all_climate(1,1) = b_SM_Pre_HR(2);
LinearTend_all_climate(2,1) = b_SM_Pre_TR(2);
LinearTend_all_climate(3,1) = b_SM_Pre_AR(2);
LinearTend_all_climate(4,1) = b_SM_Pre_TP(2);

LinearTend_all_climate(1,2) = b_Eva_Pre_HR(2);
LinearTend_all_climate(2,2) = b_Eva_Pre_TR(2);
LinearTend_all_climate(3,2) = b_Eva_Pre_AR(2);
LinearTend_all_climate(4,2) = b_Eva_Pre_TP(2);

Stats_all_climate = nan(4,2);
Stats_all_climate(1,1) = stats_SM_Pre_HR(3);
Stats_all_climate(2,1) = stats_SM_Pre_TR(3);
Stats_all_climate(3,1) = stats_SM_Pre_AR(3);
Stats_all_climate(4,1) = stats_SM_Pre_TP(3);

Stats_all_climate(1,2) = stats_Eva_Pre_HR(3);
Stats_all_climate(2,2) = stats_Eva_Pre_TR(3);
Stats_all_climate(3,2) = stats_Eva_Pre_AR(3);
Stats_all_climate(4,2) = stats_Eva_Pre_TP(3);

clearvars -except LinearTend_all_climate Stats_all_climate P_1d_SM_Eva_Pre_GI PCCs_1d_SM_Eva_Pre_GI

Table = num2cell(LinearTend_all_climate);
for i = 1 : size(Table,1)
    for j = 1 : size(Table,2)
        aa = Table{i,j};
        PP = Stats_all_climate(i,j);
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

Table2 = num2cell(PCCs_1d_SM_Eva_Pre_GI);
for i = 1 : size(Table2,1)
    for j = 1 : size(Table2,2)
        aa = Table2{i,j};
        PP = P_1d_SM_Eva_Pre_GI(i,j);
        % 判断相关系数是否显著
        if PP < 0.01
            Table2{i,j} = [num2str(roundn(aa,-2),'%4.2f'),'**'];% 保留两位小数
        elseif PP < 0.05
            Table2{i,j} = [num2str(roundn(aa,-2),'%4.2f'),'*'];% 保留两位小数
        else
            Table2{i,j} = num2str(roundn(aa,-2),'%4.2f');% 保留两位小数
        end
        clear aa PP
    end
end
% cd('J:\6-硕士毕业论文\1-Data\PCCs_for_hydrological_response\')
% filename = 'Table-4.4.1.xls';
% xlswrite(filename, Table);