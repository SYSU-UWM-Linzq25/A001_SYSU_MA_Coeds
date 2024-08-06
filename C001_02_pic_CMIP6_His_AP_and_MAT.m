%% 画气候模型历史时期的年均温和年降水量
%% 研究时段为1985-2014
%% 包括数据原始尺度和升尺度（实际为降尺度0.25°）

%% MAT-原始空间分辨率

clear;clc;

path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')
model_name = {'MPI-ESM1-2-HR','NorESM2-MM'};

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

% 统一colorbar：-10℃——33℃
index_2 = 1;
for i = 1 : length(model_name) % 选择模式读取数据
    save_peth_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\4-origin-scale-MAT-AP\';
    cd(save_peth_1)
    filename_1 = [model_name{i},'_MAT_CN_1985_2014.mat'];
    load(filename_1)
    Model_MAT_multiyear = nanmean(Model_MAT_1985_2014,3);
    sub_plot_name = ['(',char(96+index_2),') ',model_name{i},'-1985-2014-MAT'];
    mask_CN_MAT(Lon_CN,Lat_CN,Model_MAT_multiyear,shp0,shp,shp1,shp2,-10,33,shp_line_HR,shp_line_TR,shp_line_AR,shp_line_TP,sub_plot_name)
    cd('F:F:\File_of_MATLAB\6-硕士毕业论文\4-pic\001-03-CMIP6-model-His-AR-and-MAT\origin-scale\')
    exportgraphics(gcf,[model_name{i},'-multiyear-average-MAT-1985-2014.jpg'])
    index_2 = index_2 + 1;
    clear Model_MAT_multiyear Model_MAT_1985_2014 filename_1 sub_plot_name
    %     close all
end

%% MAT-升尺度

clear;clc;

path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')
model_name = {'MPI-ESM1-2-HR','NorESM2-MM'};

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


% 统一colorbar：-10℃——33℃
index_2 = 1;
for i = 1 : length(model_name) % 选择模式读取数据
    save_peth_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\6-0-His-025-scale-MAT-AP\';
    cd(save_peth_1)
    filename_1 = [model_name{i},'_MAT_CN_025_scale_1985_2014.mat'];
    load(filename_1)
    Model_MAT_multiyear = nanmean(Model_MAT_1985_2014_025_scale,3);
    sub_plot_name = ['(',char(96+index_2),') ',model_name{i},'-025-scale-1985-2014-MAT'];
    Lon_CN = xx_025(:,1);
    Lat_CN = yy_025(1,:);
    mask_CN_MAT(Lon_CN,Lat_CN,Model_MAT_multiyear,shp0,shp,shp1,shp2,-10,33,shp_line_HR,shp_line_TR,shp_line_AR,shp_line_TP,sub_plot_name)
    cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\001-03-CMIP6-model-His-AR-and-MAT\025-scale\')
    exportgraphics(gcf,[model_name{i},'-025-scale-MAT-1985-2014.jpg'])
    index_2 = index_2 + 1;
    clear Model_MAT_multiyear Model_MAT_1985_2014 filename_1 sub_plot_name
    %     close all
end

%% 集合平均的年均温（'MPI-ESM1-2-HR','NorESM2-MM'）

clear;clc;

path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')

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

save_peth_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\6-0-His-025-scale-MAT-AP\';
cd(save_peth_1)
filename_1 = 'Three_Model_ensemble_average_025_scale_MAT_CN_1985_2014.mat';
load(filename_1)

Model_MAT_multiyear = nanmean(Model_MAT_ensemble_average_year,3);
sub_plot_name = ['(',char(96+1),') ensemble-average-1985-2014-MAT'];
Lon_CN = xx_025(:,1);
Lat_CN = yy_025(1,:);
mask_CN_MAT(Lon_CN,Lat_CN,Model_MAT_multiyear,shp0,shp,shp1,shp2,-10,33,shp_line_HR,shp_line_TR,shp_line_AR,shp_line_TP,sub_plot_name)
cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\001-03-CMIP6-model-His-AR-and-MAT\集合平均\')
exportgraphics(gcf,'ensemble_average_025_scale_MAT_CN_1985_2014.jpg')

%% AR-原始空间分辨率

clear;clc;

path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')
model_name = {'MPI-ESM1-2-HR','NorESM2-MM','BCC-CSM2-MR'};

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

% 统一colorbar：0-2500
index_2 = 1;
for i = 1 : length(model_name) % 选择模式读取数据
    save_peth_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\4-origin-scale-MAT-AP\';
    cd(save_peth_1)
    filename_1 = [model_name{i},'_AP_CN_1985_2014.mat'];
    load(filename_1)
    Model_AP_multiyear = nanmean(Model_AP_1985_2014,3);
    sub_plot_name = ['(',char(96+index_2),') ',model_name{i},'-1985-2014-AP'];
    mask_CN_AR(Lon_CN,Lat_CN,Model_AP_multiyear,shp0,shp,shp1,shp2,0,2500,shp_line_HR,shp_line_TR,shp_line_AR,shp_line_TP,sub_plot_name)
    cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\001-03-CMIP6-model-His-AR-and-MAT\origin-scale\')
    exportgraphics(gcf,[model_name{i},'-multiyear-average-AP-1985-2014.jpg'])
    index_2 = index_2 + 1;
    clear Model_AP_multiyear Model_AP_1985_2014 filename_1 sub_plot_name
    %     close all
end

%% AR-升尺度

clear;clc;

path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')
model_name = {'MPI-ESM1-2-HR','NorESM2-MM','BCC-CSM2-MR'};

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


% 统一colorbar：0-2500
index_2 = 1;
for i = 1 : length(model_name) % 选择模式读取数据
    save_peth_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\6-0-His-025-scale-MAT-AP\';
    cd(save_peth_1)
    filename_1 = [model_name{i},'_AP_CN_025_scale_1985_2014.mat'];
    load(filename_1)
    Model_AP_multiyear = nanmean(Model_AP_1985_2014_025_scale,3);
    sub_plot_name = ['(',char(96+index_2),') ',model_name{i},'-025-scale-1985-2014-AP'];
    Lon_CN = xx_025(:,1);
    Lat_CN = yy_025(1,:);
    mask_CN_AR(Lon_CN,Lat_CN,Model_AP_multiyear,shp0,shp,shp1,shp2,0,2500,shp_line_HR,shp_line_TR,shp_line_AR,shp_line_TP,sub_plot_name)
    cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\001-03-CMIP6-model-His-AR-and-MAT\025-scale\')
    exportgraphics(gcf,[model_name{i},'-025-scale-AP-1985-2014.jpg'])
    index_2 = index_2 + 1;
    clear Model_AP_multiyear Model_AP_1985_2014_025_scale filename_1 sub_plot_name
    %     close all
end

%% 集合平均的年降水量（'MPI-ESM1-2-HR','NorESM2-MM','BCC-CSM2-MR'）

clear;clc;

path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')

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

save_peth_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\6-0-His-025-scale-MAT-AP\';
cd(save_peth_1)
filename_1 = 'Three_Model_ensemble_average_025_scale_AP_CN_1985_2014.mat';
load(filename_1)

Model_AP_multiyear = nanmean(Model_AP_ensemble_average_year,3);
sub_plot_name = ['(',char(96+1),') ensemble-average-1985-2014-AP'];
Lon_CN = xx_025(:,1);
Lat_CN = yy_025(1,:);
mask_CN_AR(Lon_CN,Lat_CN,Model_AP_multiyear,shp0,shp,shp1,shp2,0,2500,shp_line_HR,shp_line_TR,shp_line_AR,shp_line_TP,sub_plot_name)
cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\001-03-CMIP6-model-His-AR-and-MAT\集合平均\')
exportgraphics(gcf,'ensemble_average_025_scale_AP_CN_1985_2014.jpg')
