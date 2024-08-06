%% 这个文件将未来两个时期的多年平均年降水量和年均温空间分布图画出
%% 两个时期分别为2031-2060、2070-2099
%% 具体包括原始数据和升尺度后的

%% MAT-原始空间分辨率
clear;clc;

path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')
model_name = {'MPI-ESM1-2-HR','NorESM2-MM','BCC-CSM2-MR'};
SSP_type = {'ssp126','ssp245','ssp370','ssp585'};
Time_period = {'2031_2060','2070_2099'};
Time_period_name = {'2031-2060','2070-2099'};

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

% 首先找到 不同未来情景下-三个模型-两个未来时期 多年平均温度的最大最小值范围
MAT_max = nan(length(model_name),length(SSP_type),length(Time_period));
MAT_min = nan(length(model_name),length(SSP_type),length(Time_period));
for i = 1 : length(model_name) % 选择模式读取数据
    for j = 1 : length(SSP_type)
        for m = 1 : length(Time_period)
            save_peth_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\4-MAT-AP\';
            cd(save_peth_1)
            filename_1 = [model_name{i},'_',SSP_type{j},'_MAT_and_AP_CN_',Time_period{m},'.mat'];
            load(filename_1)
            eval(['Model_MAT_multiyear = nanmean(Model_MAT_',Time_period{m},',3);'])
            MAT_max(i,j,m) = max(max(Model_MAT_multiyear));
            MAT_min(i,j,m) = min(min(Model_MAT_multiyear));
            clear Model_MAT_multiyear Model_MAT_2031_2060 Model_MAT_2070_2099 filename_1
        end
    end
end
a1 = ceil(max(max(max(MAT_max))));
b1 = floor(min(min(min((MAT_min)))));
index_2 = 1;
for i = 1 : length(model_name) % 选择模式读取数据
    for j = 1 : length(SSP_type)
        for m = 1 : length(Time_period)
            save_peth_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\4-MAT-AP\';
            cd(save_peth_1)
            filename_1 = [model_name{i},'_',SSP_type{j},'_MAT_and_AP_CN_',Time_period{m},'.mat'];
            load(filename_1)
            eval(['Model_MAT_multiyear = nanmean(Model_MAT_',Time_period{m},',3);'])
            sub_plot_name = ['(',char(96+index_2),') ',model_name{i},' ',SSP_type{j},' ',Time_period_name{m},' MAT'];
            mask_CN_MAT(Lon_CN,Lat_CN,Model_MAT_multiyear,shp0,shp,shp1,shp2,b1,a1,shp_line_HR,shp_line_TR,shp_line_AR,shp_line_TP,sub_plot_name)
            cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\001-04-Future-AP-and-MAT\origin-resolution-MAT\')
            exportgraphics(gcf,[model_name{i},' ',SSP_type{j},' ',Time_period_name{m},' multiyear_average_MAT.jpg'])
            index_2 = index_2 + 1;
            clear Model_MAT_multiyear Model_MAT_2031_2060 Model_MAT_2070_2099 filename_1 sub_plot_name
            close all
        end
    end
end

%% 升尺度后的MAT
clear;clc;

path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')
model_name = {'MPI-ESM1-2-HR','NorESM2-MM','BCC-CSM2-MR'};
SSP_type = {'ssp126','ssp245','ssp370','ssp585'};
Time_period = {'2031_2060','2070_2099'};
Time_period_name = {'2031-2060','2070-2099'};

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

% 首先找到 不同未来情景下-三个模型-两个未来时期 多年平均温度的最大最小值范围
MAT_max = nan(length(model_name),length(SSP_type),length(Time_period));
MAT_min = nan(length(model_name),length(SSP_type),length(Time_period));
for i = 1 : length(model_name) % 选择模式读取数据
    for j = 1 : length(SSP_type)
        for m = 1 : length(Time_period)
            save_peth_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\6-future-025-scale-MAT-AP\';
            cd(save_peth_1)
            filename_1 = [model_name{i},'_',SSP_type{j},'_Tas_025_scale_CN_',Time_period{m},'.mat'];
            load(filename_1)
            eval(['Model_MAT_multiyear = nanmean(Model_MAT_025_scale_',Time_period{m},',3);'])
            MAT_max(i,j,m) = max(max(Model_MAT_multiyear));
            MAT_min(i,j,m) = min(min(Model_MAT_multiyear));
            clear Model_MAT_multiyear Model_MAT_025_scale_2031_2060 Model_MAT_025_scale_2070_2099 filename_1
        end
    end
end
Lon_CN = xx_025(:,1);
Lat_CN = yy_025(1,:)';

a1 = ceil(max(max(max(MAT_max))));
b1 = floor(min(min(min((MAT_min)))));
index_2 = 1;
for i = 1 : length(model_name) % 选择模式读取数据
    for j = 1 : length(SSP_type)
        for m = 1 : length(Time_period)
            save_peth_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\6-future-025-scale-MAT-AP\';
            cd(save_peth_1)
            filename_1 = [model_name{i},'_',SSP_type{j},'_Tas_025_scale_CN_',Time_period{m},'.mat'];
            load(filename_1)
            eval(['Model_MAT_multiyear = nanmean(Model_MAT_025_scale_',Time_period{m},',3);'])
            sub_plot_name = ['(',char(96+index_2),') ',model_name{i},' ',SSP_type{j},' ',Time_period_name{m},' MAT'];
            mask_CN_MAT(Lon_CN,Lat_CN,Model_MAT_multiyear,shp0,shp,shp1,shp2,b1,a1,shp_line_HR,shp_line_TR,shp_line_AR,shp_line_TP,sub_plot_name)
            cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\001-04-Future-AP-and-MAT\025-scale-MAT\')
            exportgraphics(gcf,[model_name{i},' ',SSP_type{j},' ',Time_period_name{m},' multiyear_average_MAT.jpg'])
            index_2 = index_2 + 1;
            clear Model_MAT_multiyear Model_MAT_025_scale_2031_2060 Model_MAT_025_scale_2070_2099 filename_1 sub_plot_name
            close all
        end
    end
end

%% 三个模型集合平均的结果（0.25°）
clear;clc;

path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')
SSP_type = {'ssp126','ssp245','ssp370','ssp585'};
Time_period = {'2031_2060','2070_2099'};
Time_period_name = {'2031-2060','2070-2099'};

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

% 首先找到 不同未来情景下-三个模型-两个未来时期 多年平均温度的最大最小值范围
MAT_max = nan(length(SSP_type),length(Time_period));
MAT_min = nan(length(SSP_type),length(Time_period));
for j = 1 : length(SSP_type)
    for m = 1 : length(Time_period)
        save_peth_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\6-1-future-025-scale-ensemble-MAT-AP\';
        cd(save_peth_1)
        filename_1 = [SSP_type{j},'_Three_Model_ensemble_average_025_scale_MAT_CN_',Time_period{m},'.mat'];
        load(filename_1)
        Model_MAT_multiyear = nanmean(Model_MAT_ensemble_average_year,3);
        MAT_max(j,m) = max(max(Model_MAT_multiyear));
        MAT_min(j,m) = min(min(Model_MAT_multiyear));
        clear Model_MAT_multiyear Model_MAT_ensemble_average_year filename_1
    end
end
Lon_CN = xx_025(:,1);
Lat_CN = yy_025(1,:)';

a1 = ceil(max(max(max(MAT_max))));
b1 = floor(min(min(min((MAT_min)))));
index_2 = 1;
for j = 1 : length(SSP_type)
    for m = 1 : length(Time_period)
        save_peth_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\6-1-future-025-scale-ensemble-MAT-AP\';
        cd(save_peth_1)
        filename_1 = [SSP_type{j},'_Three_Model_ensemble_average_025_scale_MAT_CN_',Time_period{m},'.mat'];
        load(filename_1)
        Model_MAT_multiyear = nanmean(Model_MAT_ensemble_average_year,3);
        sub_plot_name = ['(',char(96+index_2),') ',SSP_type{j},' ensemble average ',Time_period_name{m},' MAT'];
        mask_CN_MAT(Lon_CN,Lat_CN,Model_MAT_multiyear,shp0,shp,shp1,shp2,b1,a1,shp_line_HR,shp_line_TR,shp_line_AR,shp_line_TP,sub_plot_name)
        cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\001-04-Future-AP-and-MAT\集合平均结果\')
        exportgraphics(gcf,[SSP_type{j},' ensemble average ',Time_period_name{m},' multiyear_average_MAT.jpg'])
        index_2 = index_2 + 1;
        clear Model_MAT_multiyear Model_MAT_ensemble_average_year filename_1 sub_plot_name
        close all
    end
end


%% AP-原始空间分辨率
clear;clc;

path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')
model_name = {'MPI-ESM1-2-HR','NorESM2-MM','BCC-CSM2-MR'};
SSP_type = {'ssp126','ssp245','ssp370','ssp585'};
Time_period = {'2031_2060','2070_2099'};
Time_period_name = {'2031-2060','2070-2099'};

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

index_2 = 1;
for i = 1 : length(model_name) % 选择模式读取数据
    for j = 1 : length(SSP_type)
        for m = 1 : length(Time_period)
            save_peth_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\4-MAT-AP\';
            cd(save_peth_1)
            filename_1 = [model_name{i},'_',SSP_type{j},'_MAT_and_AP_CN_',Time_period{m},'.mat'];
            load(filename_1)
            eval(['Model_AP_multiyear = nanmean(Model_AP_',Time_period{m},',3);'])
            sub_plot_name = ['(',char(96+index_2),') ',model_name{i},' ',SSP_type{j},' ',Time_period_name{m},' AP'];
            mask_CN_AR(Lon_CN,Lat_CN,Model_AP_multiyear,shp0,shp,shp1,shp2,0,2500,shp_line_HR,shp_line_TR,shp_line_AR,shp_line_TP,sub_plot_name)
            cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\001-04-Future-AP-and-MAT\origin-resolution-AP\')
            exportgraphics(gcf,[model_name{i},' ',SSP_type{j},' ',Time_period_name{m},' multiyear_average_AP.jpg'])
            index_2 = index_2 + 1;
            clear Model_AP_multiyear Model_AP_2031_2060 Model_AP_2070_2099 filename_1 sub_plot_name
            close all
        end
    end
end

%% AP-升尺度后的结果
clear;clc;

path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')
model_name = {'MPI-ESM1-2-HR','NorESM2-MM','BCC-CSM2-MR'};
SSP_type = {'ssp126','ssp245','ssp370','ssp585'};
Time_period = {'2031_2060','2070_2099'};
Time_period_name = {'2031-2060','2070-2099'};

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

save_peth_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\6-future-025-scale-MAT-AP\';
cd(save_peth_1)
filename_1 = [model_name{1},'_',SSP_type{1},'_Pr_025_scale_CN_',Time_period{1},'.mat'];
load(filename_1)
Lon_CN = xx_025(:,1);
Lat_CN = yy_025(1,:)';
clear save_peth_1 filename_1 Model_AP_025_scale_2031_2060

index_2 = 1;
for i = 1 : length(model_name) % 选择模式读取数据
    for j = 1 : length(SSP_type)
        for m = 1 : length(Time_period)
            save_peth_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\6-future-025-scale-MAT-AP\';
            cd(save_peth_1)
            filename_1 = [model_name{i},'_',SSP_type{j},'_Pr_025_scale_CN_',Time_period{m},'.mat'];
            load(filename_1)
            eval(['Model_AP_multiyear = nanmean(Model_AP_025_scale_',Time_period{m},',3);'])
            sub_plot_name = ['(',char(96+index_2),') ',model_name{i},' ',SSP_type{j},' ',Time_period_name{m},' AP'];
            mask_CN_AR(Lon_CN,Lat_CN,Model_AP_multiyear,shp0,shp,shp1,shp2,0,2500,shp_line_HR,shp_line_TR,shp_line_AR,shp_line_TP,sub_plot_name)
            cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\001-04-Future-AP-and-MAT\025-scale-AP\')
            exportgraphics(gcf,[model_name{i},' ',SSP_type{j},' ',Time_period_name{m},' multiyear_average_AP.jpg'])
            index_2 = index_2 + 1;
            clear Model_AP_multiyear Model_AP_2031_2060 Model_AP_2070_2099 filename_1 sub_plot_name
            close all
        end
    end
end

%% 三个模型集合平均的结果（0.25°）
clear;clc;

path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')
SSP_type = {'ssp126','ssp245','ssp370','ssp585'};
Time_period = {'2031_2060','2070_2099'};
Time_period_name = {'2031-2060','2070-2099'};

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

save_peth_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\6-1-future-025-scale-ensemble-MAT-AP\';
cd(save_peth_1)
filename_1 = [SSP_type{1},'_Three_Model_ensemble_average_025_scale_AP_CN_',Time_period{1},'.mat'];
load(filename_1)
Lon_CN = xx_025(:,1);
Lat_CN = yy_025(1,:)';
clear save_peth_1 filename_1 Model_AP_025_scale_2031_2060

index_2 = 1;
for j = 1 : length(SSP_type)
    for m = 1 : length(Time_period)
        save_peth_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\6-1-future-025-scale-ensemble-MAT-AP\';
        cd(save_peth_1)
        filename_1 = [SSP_type{j},'_Three_Model_ensemble_average_025_scale_AP_CN_',Time_period{m},'.mat'];
        load(filename_1)
        Model_AP_multiyear = nanmean(Model_AP_ensemble_average_year,3);
        sub_plot_name = ['(',char(96+index_2),') ',SSP_type{j},' ensemble average ',Time_period_name{m},' AP'];
        mask_CN_AR(Lon_CN,Lat_CN,Model_AP_multiyear,shp0,shp,shp1,shp2,0,2500,shp_line_HR,shp_line_TR,shp_line_AR,shp_line_TP,sub_plot_name)
        cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\001-04-Future-AP-and-MAT\集合平均结果\')
        exportgraphics(gcf,[SSP_type{j},' ensemble average ',Time_period_name{m},' multiyear_average_AP.jpg'])
        index_2 = index_2 + 1;
        clear Model_AP_multiyear Model_AP_ensemble_average_year filename_1 sub_plot_name
        close all
    end
end
