%% 这个文件将三个选出来的最优模型的多年平均基尼系数画出来
%% 基尼系数为历史时期（1985-2014）
%% 同时画集合平均的结果

clear;clc;

model_name = {'MPI-ESM1-2-HR','NorESM2-MM','MIROC6'};
save_path_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\5-1-His-pr-025-scale-Gini\';
cd(save_path_1)

for i = 1 : length(model_name) % 选择模式读取数据
    filename = [model_name{i},'_1d_Gini_025_scale_1975_2014.mat'];
    load(filename)
    clear filename
    
    % 只保留1985-2014
    Model_His_Gini = Model_His_Gini(:,:,11:end);
    eval(['Model_His_Gini_mean_',num2str(i),' = nanmean(Model_His_Gini,3);'])
    clear Model_His_Gini
end


% 集合平均的结果直接计算
Model_His_Gini_mean_all = nan(size(Model_His_Gini_mean_3,1),size(Model_His_Gini_mean_3,2),3);
Model_His_Gini_mean_all(:,:,1) = Model_His_Gini_mean_1;
Model_His_Gini_mean_all(:,:,2) = Model_His_Gini_mean_2;
Model_His_Gini_mean_all(:,:,3) = Model_His_Gini_mean_3;
Model_His_Gini_mean_all_mean = nanmean(Model_His_Gini_mean_all,3);


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

Lon_025 = xx_025(:,1);
Lat_025 = yy_025(1,:);

mask_CN_Gini_group(Lon_025,Lat_025,Model_His_Gini_mean_1,Model_His_Gini_mean_2,Model_His_Gini_mean_3,Model_His_Gini_mean_all_mean,...
    shp0,shp,shp1,shp2,0.7,1,shp_line_HR,shp_line_TR,shp_line_AR,shp_line_TP);
cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\002-04-01-Three-best-CMIP6-His-GI-and-LinearTrend\')
exportgraphics(gcf,'历史时期模型最好的3个模型及集合平均的多年平均基尼系数的空间分布.jpg')

