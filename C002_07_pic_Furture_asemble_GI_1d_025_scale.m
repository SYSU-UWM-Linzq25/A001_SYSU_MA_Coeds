%% 这个文件根据未来两个时期，三个模型多年平均基尼系数的集合平均画空间分布图
%% 分辨率0.25°的结果
%% 包含4个未来情景
%% 加入校正

clear;clc;

path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')
model_name = {'MPI-ESM1-2-HR','NorESM2-MM','MIROC6'};
SSP_type = {'ssp126','ssp245','ssp370','ssp585'};
Time_period = {'2031_2060','2070_2099'};
Time_period_name = {'2031-2060','2070-2099'};

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

% 读取校正的矩阵
load('J:\6-硕士毕业论文\1-Data\Correcttion_matrix_for_CMIP6_future\Correction_matrix_from_His_for_future.mat')

% 首先找到 不同未来情景下-三个模型-两个未来时期 多年平均基尼系数的最大最小值范围
GI_max = nan(length(SSP_type),length(Time_period));
GI_min = nan(length(SSP_type),length(Time_period));
for j = 1 : length(SSP_type)
    for m = 1 : length(Time_period)
        save_peth_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\7-3-future-025-scale-ensemble-climatic-GI\';
        cd(save_peth_1)
        filename_1 = [SSP_type{j},'_3_Model_ensemble_climatic_GI_025_scale_CN_',Time_period{m},'.mat'];
        load(filename_1)
        
        % 加上校正
        Model_GI_ensemble_climatic_GI = Model_GI_ensemble_climatic_GI + Correction_matrix_for_CMIP6_GI;
        
        GI_max(j,m) = max(max(Model_GI_ensemble_climatic_GI));
        GI_min(j,m) = min(min(Model_GI_ensemble_climatic_GI));
        clear Model_GI_ensemble_climatic_GI filename_1
    end
end
    
a1 = ceil(max(max(max(GI_max))));
b1 = floor(min(min(min((GI_min)))));

Lon_CN = xx_025(:,1);
Lat_CN = yy_025(1,:)';

index_2 = 1;
for m = 1 : length(Time_period)
    for j = 1 : length(SSP_type)
        save_peth_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\7-3-future-025-scale-ensemble-climatic-GI\';
        cd(save_peth_1)
        filename_1 = [SSP_type{j},'_3_Model_ensemble_climatic_GI_025_scale_CN_',Time_period{m},'.mat'];
        load(filename_1)
        eval(['Model_GI_ensemble_climatic_GI_',num2str(j),' = Model_GI_ensemble_climatic_GI + Correction_matrix_for_CMIP6_GI;']);
        clear Model_GI_ensemble_climatic_GI
    end
    
    mask_CN_Gini_group(Lon_CN,Lat_CN,Model_GI_ensemble_climatic_GI_1,Model_GI_ensemble_climatic_GI_2,Model_GI_ensemble_climatic_GI_3,Model_GI_ensemble_climatic_GI_4,...
        shp0,shp,shp1,shp2,0.7,1,shp_line_HR,shp_line_TR,shp_line_AR,shp_line_TP);
    cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\002-05-CMIP6-Future-GI\')
    exportgraphics(gcf,[Time_period_name{m},'时期基尼系数集合平均结果.jpg'])
    clear Model_GI_ensemble_climatic_GI_1 Model_GI_ensemble_climatic_GI_2 Model_GI_ensemble_climatic_GI_3 filename_1 Model_GI_ensemble_climatic_GI_4
    close all
end

