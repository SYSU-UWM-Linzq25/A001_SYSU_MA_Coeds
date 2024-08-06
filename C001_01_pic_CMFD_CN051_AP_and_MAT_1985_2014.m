%% 这个文件将CMFD和CN051的年降水量和年均温画出来
%% 但是研究时段改成1985-2014

%% CMFD
% 两种时间尺度：3-hour & 1-day
% 这里画没有阈值处理的版本
% AP
% 原始数据单位为mmh,要变成降水量还要乘以相应的时段
% 3h尺度为×3
% 日尺度为×24

clear;clc;

clear filename2
filename2 = 'Annual_Pr_3h_data_no_preprocessing.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\4-AP-and-MAT\',filename2]);
Annual_Pr_3h_1985_2014 = Annual_Pr_3h_all(:,:,7:end-4);
clear Annual_Pr_3h_all
Annual_Pr_3h_data_mean = nanmean(Annual_Pr_3h_1985_2014.*3,3);

clear filename2
filename2 = 'Annual_Pr_1d_data_no_preprocessing.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\4-AP-and-MAT\',filename2]);
Annual_Pr_1d_1985_2014 = Annual_Pr_1d_all(:,:,7:end-4);
clear Annual_Pr_1d_all
Annual_Pr_1d_data_mean = nanmean(Annual_Pr_1d_1985_2014.*24,3);

% 画图
shp0 = shaperead('J:\4-论文备份\论文代码2021.4.14\map\bou1_4p.shp');
shp = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\基于审图号GS(2019)1822号新制作的底图\新国界_无东沙赤尾钓鱼_需和Chinaline连用.shp');
shp1 = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\基于审图号GS(2019)1822号新制作的底图\New_China_line.shp');
shp2 = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\基于审图号GS(2019)1822号新制作的底图\Dongsha_Chiwei_Diaoyu.shp');
% 读取4个气候区的线shp图，叠加在绘图上
shp_line_HR = shaperead('F:\File_of_MATLAB\关于3h尺度的CMFD降水数据研究2022.3.2\New climate seperate method from Du\湿润区\shiRunQu_Line.shp');
shp_line_TR = shaperead('F:\File_of_MATLAB\关于3h尺度的CMFD降水数据研究2022.3.2\New climate seperate method from Du\过渡区\guoDuQu_Line.shp');
shp_line_AR = shaperead('F:\File_of_MATLAB\关于3h尺度的CMFD降水数据研究2022.3.2\New climate seperate method from Du\干旱区\ganHanQu_Line.shp');
shp_line_TP = shaperead('F:\File_of_MATLAB\关于3h尺度的CMFD降水数据研究2022.3.2\New climate seperate method from Du\高寒区\qingZangGaoYuanQu_Line.shp');

Var_name = {'Annual_Pr_3h_data_mean','Annual_Pr_1d_data_mean'};
Var_name2 = {'AP-CMFD-3h-data-nothresold-1985-2014','AP-CMFD-1d-data-nothresold-1985-2014'};

for i = 1 : length(Var_name)
    subplotname = Var_name2{i};
    eval(['mask_CN_AR(Lon,Lat,',Var_name{i},',shp0,shp,shp1,shp2,0,2500,shp_line_HR,shp_line_TR,shp_line_AR,shp_line_TP,subplotname)'])
    cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\001-02-CMFD-CN051-1985-2014-AP-and-MAT\')
    exportgraphics(gcf,[subplotname,' .jpg'])
end

%% MAT
clear Var_name Var_name2
clear filename2
filename2 = 'MAT_3h_1979_2018.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\4-AP-and-MAT\',filename2]);
MAT_3h_1985_2014 = MAT_3h(:,:,7:end-4);
clear MAT_3h
MAT_3h_mean = nanmean(MAT_3h_1985_2014,3);

clear filename2
filename2 = 'MAT_1d_1979_2018.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\4-AP-and-MAT\',filename2]);
MAT_1d_1985_2014 = MAT_1d(:,:,7:end-4);
clear MAT_1d
MAT_1d_mean = nanmean(MAT_1d_1985_2014,3);

Var_name = {'MAT_3h_mean','MAT_1d_mean'};
Var_name2 = {'MAT-CMFD-3h-data-1985-2014','MAT-CMFD-1d-data-1985-2014'};

% 可以先计算两种数据下的温度数据范围
MAT_range(1,1) = min(min(MAT_3h_mean));
MAT_range(1,2) = max(max(MAT_3h_mean));
MAT_range(2,1) = min(min(MAT_1d_mean));
MAT_range(2,2) = max(max(MAT_1d_mean));

% 使用与CMIP6-future-MAT相同的范围

for i = 1 : length(Var_name)
    subplotname = Var_name2{i};
    eval(['mask_CN_MAT(Lon,Lat,',Var_name{i},',shp0,shp,shp1,shp2,-10,33,shp_line_HR,shp_line_TR,shp_line_AR,shp_line_TP,subplotname)'])
    cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\001-02-CMFD-CN051-1985-2014-AP-and-MAT\')
    exportgraphics(gcf,[subplotname,' .jpg'])
end

%% CN051

clear;clc;

clear filename2
filename2 = 'CN051_Daily_AP_1979_2018.mat';
load(['J:\6-硕士毕业论文\1-Data\CN051-TM-Pre-1979-2018\4-AP-and-MAT\',filename2]);
CN051_AP_year_1985_2014 = CN051_AP_year(:,:,7:end-4);
clear CN051_AP_year
CN051_AP_year_mean = nanmean(CN051_AP_year_1985_2014,3);

clear filename2
filename2 = 'CN051_Daily_MAT_1979_2018.mat';
load(['J:\6-硕士毕业论文\1-Data\CN051-TM-Pre-1979-2018\4-AP-and-MAT\',filename2]);
CN051_MAT_year_1985_2014 = CN051_MAT_year(:,:,7:end-4);
clear CN051_MAT_year
CN051_MAT_year_mean = nanmean(CN051_MAT_year_1985_2014,3);

% 画图
shp0 = shaperead('J:\4-论文备份\论文代码2021.4.14\map\bou1_4p.shp');
shp = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\基于审图号GS(2019)1822号新制作的底图\新国界_无东沙赤尾钓鱼_需和Chinaline连用.shp');
shp1 = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\基于审图号GS(2019)1822号新制作的底图\New_China_line.shp');
shp2 = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\基于审图号GS(2019)1822号新制作的底图\Dongsha_Chiwei_Diaoyu.shp');
% 读取4个气候区的线shp图，叠加在绘图上
shp_line_HR = shaperead('F:\File_of_MATLAB\关于3h尺度的CMFD降水数据研究2022.3.2\New climate seperate method from Du\湿润区\shiRunQu_Line.shp');
shp_line_TR = shaperead('F:\File_of_MATLAB\关于3h尺度的CMFD降水数据研究2022.3.2\New climate seperate method from Du\过渡区\guoDuQu_Line.shp');
shp_line_AR = shaperead('F:\File_of_MATLAB\关于3h尺度的CMFD降水数据研究2022.3.2\New climate seperate method from Du\干旱区\ganHanQu_Line.shp');
shp_line_TP = shaperead('F:\File_of_MATLAB\关于3h尺度的CMFD降水数据研究2022.3.2\New climate seperate method from Du\高寒区\qingZangGaoYuanQu_Line.shp');

Var_name = {'CN051_AP_year_mean','CN051_MAT_year_mean'};
Var_name2 = {'AP-CN051-1985-2014','MAT-CN051-1985-2014'};

for i = 1 : length(Var_name)
    subplotname = Var_name2{i};
    if i == 1
        eval(['mask_CN_AR(Lon,Lat,',Var_name{i},',shp0,shp,shp1,shp2,0,2500,shp_line_HR,shp_line_TR,shp_line_AR,shp_line_TP,subplotname)'])
    else
        eval(['mask_CN_MAT(Lon,Lat,',Var_name{i},',shp0,shp,shp1,shp2,-10,33,shp_line_HR,shp_line_TR,shp_line_AR,shp_line_TP,subplotname)'])
    end
    cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\001-02-CMFD-CN051-1985-2014-AP-and-MAT\')
    exportgraphics(gcf,[subplotname,' .jpg'])
end

close all

