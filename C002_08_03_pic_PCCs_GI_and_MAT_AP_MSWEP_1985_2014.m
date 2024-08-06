%% 这个文件将MSWEP数据计算得到的基尼系数与年均温相关系数画成空间分布图
%% 将年降水量的一起画在一起
%% 研究时段为1985-2014
% 有点问题，不画了
clear;clc;

% 画图
shp0 = shaperead('J:\4-论文备份\论文代码2021.4.14\map\bou1_4p.shp');
shp = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\基于审图号GS(2019)1822号新制作的底图\新国界_无东沙赤尾钓鱼_需和Chinaline连用.shp');
shp1 = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\基于审图号GS(2019)1822号新制作的底图\New_China_line.shp');
shp2 = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\基于审图号GS(2019)1822号新制作的底图\Dongsha_Chiwei_Diaoyu.shp');
% 读取4个气候区的线shp图，叠加在绘图上
shp_line_HR = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\中国农业自然区划-中国科学院地理科学与资源研究所资源环境科学与数据中心\气候分区\Humid_Region_Dissolv_Line_GCS1984.shp');
shp_line_TR = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\中国农业自然区划-中国科学院地理科学与资源研究所资源环境科学与数据中心\气候分区\Transition_Region_Dissolv_Line_GCS1984.shp');
shp_line_AR = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\中国农业自然区划-中国科学院地理科学与资源研究所资源环境科学与数据中心\气候分区\Arid_Region_Dissolv_Line_GCS1984.shp');
shp_line_TP = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\中国农业自然区划-中国科学院地理科学与资源研究所资源环境科学与数据中心\气候分区\Tibetan_Plateau_Dissolv_Line_GCS1984.shp');

save_peth_1 = 'J:\6-硕士毕业论文\1-Data\MSWEP-V280-1985-2014\006-PCCs-MAT-AP-and-GI-1985-2014\';
cd(save_peth_1)
filename2 = 'PCCs_MAT_and_MSWEP_Gini_1985_2014_01mmh.mat';
load(filename2)

% 需要转置
load('J:\6-硕士毕业论文\1-Data\MSWEP-V280-1985-2014\range.mat')
Lat_2 = flip(Lat); % lat是按照递减序列排列的，所以要现改成增序

% 注意MWSEP在处理过程中，lat是按照递减序列排列的，所以要现改成增序
PCCs_MAT_3h_GI_MSWEP_2 = nan(size(PCCs_MAT_3h_GI_MSWEP));
PCCs_MAT_6h_GI_MSWEP_2 = nan(size(PCCs_MAT_6h_GI_MSWEP));
PCCs_MAT_12h_GI_MSWEP_2 = nan(size(PCCs_MAT_12h_GI_MSWEP));
PCCs_MAT_1d_GI_MSWEP_2 = nan(size(PCCs_MAT_1d_GI_MSWEP));

P_MAT_3h_GI_MSWEP_2 = nan(size(P_MAT_3h_GI_MSWEP));
P_MAT_6h_GI_MSWEP_2 = nan(size(P_MAT_6h_GI_MSWEP));
P_MAT_12h_GI_MSWEP_2 = nan(size(P_MAT_12h_GI_MSWEP));
P_MAT_1d_GI_MSWEP_2 = nan(size(P_MAT_1d_GI_MSWEP));

for i = 1 : length(Lat)
    PCCs_MAT_3h_GI_MSWEP_2(length(Lat)+1-i,:) = PCCs_MAT_3h_GI_MSWEP(i,:);
    PCCs_MAT_6h_GI_MSWEP_2(length(Lat)+1-i,:) = PCCs_MAT_6h_GI_MSWEP(i,:);
    PCCs_MAT_12h_GI_MSWEP_2(length(Lat)+1-i,:) = PCCs_MAT_12h_GI_MSWEP(i,:);
    PCCs_MAT_1d_GI_MSWEP_2(length(Lat)+1-i,:) = PCCs_MAT_1d_GI_MSWEP(i,:);
    
    P_MAT_3h_GI_MSWEP_2(length(Lat)+1-i,:) = P_MAT_3h_GI_MSWEP(i,:);
    P_MAT_6h_GI_MSWEP_2(length(Lat)+1-i,:) = P_MAT_6h_GI_MSWEP(i,:);
    P_MAT_12h_GI_MSWEP_2(length(Lat)+1-i,:) = P_MAT_12h_GI_MSWEP(i,:);
    P_MAT_1d_GI_MSWEP_2(length(Lat)+1-i,:) = P_MAT_1d_GI_MSWEP(i,:);
end
clear PCCs_MAT_3h_GI_MSWEP PCCs_MAT_6h_GI_MSWEP PCCs_MAT_12h_GI_MSWEP PCCs_MAT_1d_GI_MSWEP...
    P_MAT_3h_GI_MSWEP P_MAT_6h_GI_MSWEP P_MAT_12h_GI_MSWEP P_MAT_1d_GI_MSWEP

mask_CN_PCCs_MAT_group(Lon,Lat_2,PCCs_MAT_3h_GI_MSWEP_2',PCCs_MAT_6h_GI_MSWEP_2',PCCs_MAT_12h_GI_MSWEP_2',...
    PCCs_MAT_1d_GI_MSWEP_2',P_MAT_3h_GI_MSWEP_2',P_MAT_6h_GI_MSWEP_2',P_MAT_12h_GI_MSWEP_2',P_MAT_1d_GI_MSWEP_2',...
    shp0,shp,shp1,shp2,-1,1,10,shp_line_HR,shp_line_TR,shp_line_AR,shp_line_TP)





%%
% cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\003-01-PCCs-MAT-and-GI\CMFD\')
% exportgraphics(gcf,['温度对降水集中度的影响-CMFD.jpg'])