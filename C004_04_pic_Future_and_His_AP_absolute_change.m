%% 这个文件根据未来两个时期和历史时期中年降水量气候态的绝对变化率进行画图
%% 画绝对变化率

clear;clc;
path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')

% 未来两个时期-四个情景
SSP_type = {'ssp126','ssp245','ssp370','ssp585'};
% Time_period = {'2031_2060','2070_2099'};
Time_period = {'2031_2060'};
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

save_peth_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\9-3-Absolute-cahnge-of-Future-and-His-AP\';
cd(save_peth_1)
filename_1 = ['Absolute_change_ssp126_2031_2060_025_scale_climatic_AP.mat'];
load(filename_1)
% 经纬度坐标
Lon_025 = xx_025(:,1);
Lat_025 = yy_025(1,:);
clear Absolute_change_ssp126_2031_2060

Absolute_change_2031_2060_all = nan(length(Lon_025),length(Lat_025),4);

index_2 = 1;
for j = 1 : length(SSP_type)
    for m = 1 : length(Time_period)
        save_peth_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\9-3-Absolute-cahnge-of-Future-and-His-AP\';
        cd(save_peth_1)
        filename_1 = ['Absolute_change_',SSP_type{j},'_',Time_period{m},'_025_scale_climatic_AP.mat'];
        load(filename_1)
        
        eval(['Absolute_change_2031_2060_all(:,:,j) = Absolute_change_',SSP_type{j},'_',Time_period{m},';'])
                
    end
end

b1 = min(min(min(Absolute_change_2031_2060_all)));
a1 = max(max(max(Absolute_change_2031_2060_all)));


mask_CN_climatic_AP_Absolute_change(Lon_025,Lat_025,Absolute_change_ssp126_2031_2060,Absolute_change_ssp245_2031_2060,...
    Absolute_change_ssp370_2031_2060,Absolute_change_ssp585_2031_2060,shp0,shp,shp1,shp2,-180,180,shp_line_HR,shp_line_TR,shp_line_AR,shp_line_TP)

cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\004-03-CMIP6-Future-and-His-AP-Absolute-change\')
exportgraphics(gcf,'2031-2060未来时期和历史时期年降水量气候态的绝对变化率.jpg')


%% 看下2071-2099

clear;clc;
path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')

% 未来两个时期-四个情景
SSP_type = {'ssp126','ssp245','ssp370','ssp585'};
% Time_period = {'2031_2060','2070_2099'};
Time_period = {'2070_2099'};
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

save_peth_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\9-3-Absolute-cahnge-of-Future-and-His-AP\';
cd(save_peth_1)
filename_1 = ['Absolute_change_ssp126_2070_2099_025_scale_climatic_AP.mat'];
load(filename_1)
% 经纬度坐标
Lon_025 = xx_025(:,1);
Lat_025 = yy_025(1,:);
clear Absolute_change_ssp126_2070_2099

Absolute_change_2070_2099_all = nan(length(Lon_025),length(Lat_025),4);

index_2 = 1;
for j = 1 : length(SSP_type)
    for m = 1 : length(Time_period)
        save_peth_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\9-3-Absolute-cahnge-of-Future-and-His-AP\';
        cd(save_peth_1)
        filename_1 = ['Absolute_change_',SSP_type{j},'_',Time_period{m},'_025_scale_climatic_AP.mat'];
        load(filename_1)
        
        eval(['Absolute_change_2070_2099_all(:,:,j) = Absolute_change_',SSP_type{j},'_',Time_period{m},';'])
                
    end
end

b1 = min(min(min(Absolute_change_2070_2099_all)));
a1 = max(max(max(Absolute_change_2070_2099_all)));

mask_CN_climatic_AP_Absolute_change(Lon_025,Lat_025,Absolute_change_ssp126_2070_2099,Absolute_change_ssp245_2070_2099,...
    Absolute_change_ssp370_2070_2099,Absolute_change_ssp585_2070_2099,shp0,shp,shp1,shp2,-180,180,shp_line_HR,shp_line_TR,shp_line_AR,shp_line_TP)

cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\002-08-CMIP6-Future-and-His-AP-Absolute-change\')
exportgraphics(gcf,'未来时期（2071-2099）和历史时期年降水量气候态的绝对变化率.jpg')







% close all