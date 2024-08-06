%% 这个文件根据未来两个时期和历史时期中基尼系数的相对变化率进行画图

clear;clc;
path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')

% 未来两个时期-四个情景
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

for j = 1 : length(SSP_type)
    for m = 1 : length(Time_period)
        save_peth_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\9-1-Relative-change-percent-of-Future-and-His_Gi\';
        cd(save_peth_1)
        filename_1 = ['Relative_change_percent_',SSP_type{j},'_',Time_period{m},'_025_scale.mat'];
        load(filename_1)
        
        
        eval(['a1(j,m) = ceil(max(max(Relative_change_percent_',SSP_type{j},'_',Time_period{m},')));'])
        eval(['b1(j,m) = floor(min(min(Relative_change_percent_',SSP_type{j},'_',Time_period{m},')));'])
        
        % 经纬度坐标
        Lon_025 = xx_025(:,1);
        Lat_025 = yy_025(1,:);
                        
    end
end

mask_CN_Gini_Relative_change_percent_group(Lon_025,Lat_025,Relative_change_percent_ssp126_2031_2060*100,Relative_change_percent_ssp245_2031_2060*100,...
    Relative_change_percent_ssp370_2031_2060*100,Relative_change_percent_ssp585_2031_2060*100,...
    shp0,shp,shp1,shp2,-3,3,shp_line_HR,shp_line_TR,shp_line_AR,shp_line_TP);

cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\002-06-CMIP6-Future-and-His-GI-Relative-change-percent\')
exportgraphics(gcf,'未来时期和历史时期基尼系数气候态的相对变化率.jpg')