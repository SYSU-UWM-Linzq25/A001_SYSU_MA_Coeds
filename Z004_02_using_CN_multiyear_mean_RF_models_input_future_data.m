%% 这个文件将根据历史时期全国多年平均建立的随机森林模型
%% 代入未来时期的年均温和年降水量气候态，预测基尼系数
%% 先完成对未来数据的准备

clear;clc;
path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\RamdomForest-master\RamdomForest-master\')

% 读取不同情景下的数据
SSP_type = {'ssp126','ssp245','ssp370','ssp585'};
Time_period = {'2031_2060'};
for j = 1 : length(SSP_type)
    for m = 1 : length(Time_period)
        save_peth_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\6-2-future-025-scale-ensemble-climatic-MAT-AP\';
        cd(save_peth_1)
        filename_1 = [SSP_type{j},'_3_Model_ensemble_climatic_MAT_025_scale_CN_',Time_period{m},'.mat'];
        load(filename_1)
        
        eval(['T_',SSP_type{j},'_line = reshape(Model_MAT_ensemble_climatic_MAT,[size(Model_MAT_ensemble_climatic_MAT,1)*size(Model_MAT_ensemble_climatic_MAT,2),1]);'])
        clear Model_MAT_ensemble_climatic_MAT
        
    end
end

for j = 1 : length(SSP_type)
    for m = 1 : length(Time_period)
        save_peth_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\6-2-future-025-scale-ensemble-climatic-MAT-AP\';
        cd(save_peth_1)
        filename_1 = [SSP_type{j},'_3_Model_ensemble_climatic_AP_025_scale_CN_',Time_period{m},'.mat'];
        load(filename_1)
        
        eval(['AP_',SSP_type{j},'_line = reshape(Model_AP_ensemble_climatic_AP,[size(Model_AP_ensemble_climatic_AP,1)*size(Model_AP_ensemble_climatic_AP,2),1]);'])
        clear Model_AP_ensemble_climatic_AP
        
    end
end

% 读取基尼系数
for j = 1 : length(SSP_type)
    filename2 = [SSP_type{j},'_3_Model_ensemble_climatic_GI_025_scale_CN_2031_2060.mat'];
    load(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\7-3-future-025-scale-ensemble-climatic-GI\',filename2])
    eval(['GI_',SSP_type{j},'_line = reshape(Model_GI_ensemble_climatic_GI,[size(Model_GI_ensemble_climatic_GI,1)*size(Model_GI_ensemble_climatic_GI,2),1]);'])
end

xx_025_line = reshape(xx_025,[size(xx_025,1)*size(xx_025,2),1]);
yy_025_line = reshape(yy_025,[size(yy_025,1)*size(yy_025,2),1]);
xx_025_line_ssp126 = xx_025_line;
yy_025_line_ssp126 = yy_025_line;
xx_025_line_ssp245 = xx_025_line;
yy_025_line_ssp245 = yy_025_line;
xx_025_line_ssp370 = xx_025_line;
yy_025_line_ssp370 = yy_025_line;
xx_025_line_ssp585 = xx_025_line;
yy_025_line_ssp585 = yy_025_line;
clear xx_025_line yy_025_line


% 查找同一情景下不同数据的nan，去除！
for j = 1 : length(SSP_type)
     eval(['k_1 = find(isnan(GI_',SSP_type{j},'_line));'])   
     eval(['k_2 = find(isnan(T_',SSP_type{j},'_line));'])    
     eval(['k_3 = find(isnan(AP_',SSP_type{j},'_line));'])    
     kk = unique([k_1;k_2;k_3]);
     kk(isnan(kk)) = [];
     
     eval(['GI_',SSP_type{j},'_line(kk) = [];'])   
     eval(['T_',SSP_type{j},'_line(kk) = [];'])    
     eval(['AP_',SSP_type{j},'_line(kk) = [];'])    
     eval(['xx_025_line_',SSP_type{j},'(kk) = [];'])    
     eval(['yy_025_line_',SSP_type{j},'(kk) = [];'])    
end


% 整合成一整个的数组
for j = 1 : length(SSP_type)
    
    eval(['X_Future_',SSP_type{j},' = nan(length(T_',SSP_type{j},'_line),4);'])
    eval(['X_Future_',SSP_type{j},'(:,1) = xx_025_line_',SSP_type{j},';'])
    eval(['X_Future_',SSP_type{j},'(:,2) = yy_025_line_',SSP_type{j},';'])
    eval(['X_Future_',SSP_type{j},'(:,3) = T_',SSP_type{j},'_line;'])
    eval(['X_Future_',SSP_type{j},'(:,4) = AP_',SSP_type{j},'_line;'])
    
    eval(['Y_Future_',SSP_type{j},' = GI_',SSP_type{j},'_line;'])
    
end

%% 代入过去的随机森林模型中
clearvars -except Y_Future_ssp126 Y_Future_ssp245 Y_Future_ssp370 Y_Future_ssp585...
    X_Future_ssp126 X_Future_ssp245 X_Future_ssp370 X_Future_ssp585 SSP_type xx_025 yy_025

load('J:\6-硕士毕业论文\1-Data\CMFD\10-4-RF-models-025-scale\multiyear_mean\RF_model_CN_1d_025_scale_multiyear_mean_500_4.mat')

for j = 1 : length(SSP_type)
    eval(['Y_hat_',SSP_type{j},' = regRF_predict(X_Future_',SSP_type{j},',model);'])
end

% 根据历史建立的随机森林模型，代入未来四个情景的特征，计算出来的模拟的未来时期的基尼系数
% 根据经纬度信息，重新转换回2维矩阵，然后在空间上画出来
% 不同情景下的经纬度坐标是一致的

clear i
GI_predict_SSP126 = nan(size(xx_025));
GI_predict_SSP245 = nan(size(xx_025));
GI_predict_SSP370 = nan(size(xx_025));
GI_predict_SSP585 = nan(size(xx_025));

for i = 1 : length(Y_hat_ssp126) 

    % 预测的Y_hat对应的X矩阵前两列
    Lon_1 = X_Future_ssp126(i,1);
    Lat_1 = X_Future_ssp126(i,2);

    % 找到这个经纬度下的索引
    k1 = find(xx_025 == Lon_1 & yy_025 == Lat_1);
    GI_predict_SSP126(k1) = Y_hat_ssp126(i);
    GI_predict_SSP245(k1) = Y_hat_ssp245(i);
    GI_predict_SSP370(k1) = Y_hat_ssp370(i);
    GI_predict_SSP585(k1) = Y_hat_ssp585(i);
    
end
    
    
    
% cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\011-01-RF-models-for-1d-GI_025_regression\climate_annual\')
% exportgraphics(gcf,'TP-测试集效果.jpg')



% 读取用未来时期降水数据直接算出来的基尼系数
for j = 1 : length(SSP_type)
    filename2 = [SSP_type{j},'_3_Model_ensemble_climatic_GI_025_scale_CN_2031_2060.mat'];
    load(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\7-3-future-025-scale-ensemble-climatic-GI\',filename2])
    eval(['GI_',SSP_type{j},' = Model_GI_ensemble_climatic_GI;'])
    clear Model_GI_ensemble_climatic_GI
end

% 加入校正的矩阵
% load('J:\6-硕士毕业论文\1-Data\Correcttion_matrix_for_CMIP6_future\Correction_matrix_from_His_for_future.mat')
% GI_predict_SSP126 = GI_predict_SSP126 + Correction_matrix_for_CMIP6_GI;
% GI_predict_SSP245 = GI_predict_SSP245 + Correction_matrix_for_CMIP6_GI;
% GI_predict_SSP370 = GI_predict_SSP370 + Correction_matrix_for_CMIP6_GI;
% GI_predict_SSP585 = GI_predict_SSP585 + Correction_matrix_for_CMIP6_GI;
% 
% GI_ssp126 = GI_ssp126 + Correction_matrix_for_CMIP6_GI;
% GI_ssp245 = GI_ssp245 + Correction_matrix_for_CMIP6_GI;
% GI_ssp370 = GI_ssp370 + Correction_matrix_for_CMIP6_GI;
% GI_ssp585 = GI_ssp585 + Correction_matrix_for_CMIP6_GI;

Diff_ssp126 = GI_ssp126 - GI_predict_SSP126;
Diff_ssp245 = GI_ssp245 - GI_predict_SSP245;
Diff_ssp370 = GI_ssp370 - GI_predict_SSP370;
Diff_ssp585 = GI_ssp585 - GI_predict_SSP585;

GI_ssp126_line = reshape(GI_ssp126,[1,size(GI_ssp126,1)*size(GI_ssp126,2)]);
GI_ssp245_line = reshape(GI_ssp245,[1,size(GI_ssp245,1)*size(GI_ssp245,2)]);
GI_ssp370_line = reshape(GI_ssp370,[1,size(GI_ssp370,1)*size(GI_ssp370,2)]);
GI_ssp585_line = reshape(GI_ssp585,[1,size(GI_ssp585,1)*size(GI_ssp585,2)]);

GI_predict_SSP126_line = reshape(GI_predict_SSP126,[1,size(GI_predict_SSP126,1)*size(GI_predict_SSP126,2)]);
GI_predict_SSP245_line = reshape(GI_predict_SSP245,[1,size(GI_predict_SSP245,1)*size(GI_predict_SSP245,2)]);
GI_predict_SSP370_line = reshape(GI_predict_SSP370,[1,size(GI_predict_SSP370,1)*size(GI_predict_SSP370,2)]);
GI_predict_SSP585_line = reshape(GI_predict_SSP585,[1,size(GI_predict_SSP585,1)*size(GI_predict_SSP585,2)]);

% 去除nan
k126_1 = find(isnan(GI_ssp126_line));
k126_2 = find(isnan(GI_predict_SSP126_line));
k126 = unique([k126_1,k126_2]);
GI_ssp126_line(k126) = [];
GI_predict_SSP126_line(k126) = [];

k245_1 = find(isnan(GI_ssp245_line));
k245_2 = find(isnan(GI_predict_SSP245_line));
k245 = unique([k245_1,k245_2]);
GI_ssp245_line(k245) = [];
GI_predict_SSP245_line(k245) = [];

k370_1 = find(isnan(GI_ssp370_line));
k370_2 = find(isnan(GI_predict_SSP370_line));
k370 = unique([k370_1,k370_2]);
GI_ssp370_line(k370) = [];
GI_predict_SSP370_line(k370) = [];

k585_1 = find(isnan(GI_ssp585_line));
k585_2 = find(isnan(GI_predict_SSP585_line));
k585 = unique([k585_1,k585_2]);
GI_ssp585_line(k585) = [];
GI_predict_SSP585_line(k585) = [];


[PCCs_126,P_126] = corrcoef(GI_ssp126_line,GI_predict_SSP126_line);
[PCCs_245,P_245] = corrcoef(GI_ssp245_line,GI_predict_SSP245_line);
[PCCs_370,P_370] = corrcoef(GI_ssp370_line,GI_predict_SSP370_line);
[PCCs_585,P_585] = corrcoef(GI_ssp585_line,GI_predict_SSP585_line);



Diff_ssp126_mean = nanmean(nanmean(Diff_ssp126,1));
Diff_ssp245_mean = nanmean(nanmean(Diff_ssp245,1));
Diff_ssp370_mean = nanmean(nanmean(Diff_ssp370,1));
Diff_ssp585_mean = nanmean(nanmean(Diff_ssp585,1));


% 尝试画图
shp0 = shaperead('J:\4-论文备份\论文代码2021.4.14\map\bou1_4p.shp');
shp = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\基于审图号GS(2019)1822号新制作的底图\新国界_无东沙赤尾钓鱼_需和Chinaline连用.shp');
shp1 = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\基于审图号GS(2019)1822号新制作的底图\New_China_line.shp');
shp2 = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\基于审图号GS(2019)1822号新制作的底图\Dongsha_Chiwei_Diaoyu.shp');
% 读取4个气候区的线shp图，叠加在绘图上
shp_line_HR = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\中国农业自然区划-中国科学院地理科学与资源研究所资源环境科学与数据中心\气候分区\Humid_Region_Dissolv_Line_GCS1984.shp');
shp_line_TR = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\中国农业自然区划-中国科学院地理科学与资源研究所资源环境科学与数据中心\气候分区\Transition_Region_Dissolv_Line_GCS1984.shp');
shp_line_AR = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\中国农业自然区划-中国科学院地理科学与资源研究所资源环境科学与数据中心\气候分区\Arid_Region_Dissolv_Line_GCS1984.shp');
shp_line_TP = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\中国农业自然区划-中国科学院地理科学与资源研究所资源环境科学与数据中心\气候分区\Tibetan_Plateau_Dissolv_Line_GCS1984.shp');

Lon_CN = xx_025(:,1);
Lat_CN = yy_025(1,:)';

mask_CN_Gini_group(Lon_CN,Lat_CN,GI_predict_SSP126,GI_predict_SSP245,GI_predict_SSP370,GI_predict_SSP585,...
    shp0,shp,shp1,shp2,0.7,1,shp_line_HR,shp_line_TR,shp_line_AR,shp_line_TP);

cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\011-02-His-RF-models-input-future-X-and-plus-correction\')
% exportgraphics(gcf,'历史模型-未来输入-校正后的基尼系数空间分布图.jpg')

%% 计算模拟的降水集中度与直接用未来时期降水计算得到的集中度的差值
% 直接计算的集中度也要进行校正，不然就不是接近了
% 直接计算的-模拟的

clearvars -except Diff_ssp126 Diff_ssp245 Diff_ssp370 Diff_ssp585


% 根据绝对差值画箱形图
% 在不同的气候区
%读取气候区的索引，分开气候区
% 读取气候分区的index
load(['J:\6-硕士毕业论文\1-Data\Climate_zone_index\', 'Four_Climite_zone_index_025_scale.mat'])
k_HR = find(Four_climate_zone_index_025 == 1);
k_TR = find(Four_climate_zone_index_025 == 2);
k_AR = find(Four_climate_zone_index_025 == 3);
k_TP = find(Four_climate_zone_index_025 == 4);
clear Four_climate_zone_index_025

climate_zone = {'HR','TR','AR','TP'};
for i = 1 : length(climate_zone)
    eval(['Diff_ssp126_',climate_zone{i},' = Diff_ssp126(k_',climate_zone{i},');'])
    eval(['Diff_ssp245_',climate_zone{i},' = Diff_ssp245(k_',climate_zone{i},');'])
    eval(['Diff_ssp370_',climate_zone{i},' = Diff_ssp370(k_',climate_zone{i},');'])
    eval(['Diff_ssp585_',climate_zone{i},' = Diff_ssp585(k_',climate_zone{i},');'])
end

SSP_name = {'ssp126','ssp245','ssp370','ssp585'};

% 进行合并调整,按照气候区的放在一起
clear i j 
for j = 1 : length(climate_zone)
    for i = 1 : length(SSP_name)
        
        eval(['Diffs_',climate_zone{j},'_all(:,i) = Diff_',SSP_name{i},'_',climate_zone{j},';'])

    end
end
%%
clearvars -except Diffs_AR_all Diffs_HR_all Diffs_TR_all Diffs_TP_all
% 箱形图看不出差别
Diffs_AR_all_Areamean = nanmean(Diffs_AR_all,1);
Diffs_HR_all_Areamean = nanmean(Diffs_HR_all,1);
Diffs_TR_all_Areamean = nanmean(Diffs_TR_all,1);
Diffs_TP_all_Areamean = nanmean(Diffs_TP_all,1);

Diffs_AR_all_25 = prctile(Diffs_AR_all,25);
Diffs_HR_all_25 = prctile(Diffs_HR_all,25);
Diffs_TR_all_25 = prctile(Diffs_TR_all,25);
Diffs_TP_all_25 = prctile(Diffs_TP_all,25);

Diffs_AR_all_75 = prctile(Diffs_AR_all,75);
Diffs_HR_all_75 = prctile(Diffs_HR_all,75);
Diffs_TR_all_75 = prctile(Diffs_TR_all,75);
Diffs_TP_all_75 = prctile(Diffs_TP_all,75);

% 画结合一副图的柱状图
% 误差矩阵
AVG_HR = Diffs_HR_all_Areamean - Diffs_HR_all_25;
STD_HR = Diffs_HR_all_75 - Diffs_HR_all_Areamean;
Diffs_HR_all_Areamean = Diffs_HR_all_Areamean';
AVG_HR = AVG_HR';
STD_HR = STD_HR';

AVG_TR = Diffs_TR_all_Areamean - Diffs_TR_all_25;
STD_TR = Diffs_TR_all_75 - Diffs_TR_all_Areamean;
Diffs_TR_all_Areamean = Diffs_TR_all_Areamean';
AVG_TR = AVG_TR';
STD_TR = STD_TR';

AVG_AR = Diffs_AR_all_Areamean - Diffs_AR_all_25;
STD_AR = Diffs_AR_all_75 - Diffs_AR_all_Areamean;
Diffs_AR_all_Areamean = Diffs_AR_all_Areamean';
AVG_AR = AVG_AR';
STD_AR = STD_AR';

AVG_TP = Diffs_TP_all_Areamean - Diffs_TP_all_25;
STD_TP = Diffs_TP_all_75 - Diffs_TP_all_Areamean;
Diffs_TP_all_Areamean = Diffs_TP_all_Areamean';
AVG_TP = AVG_TP';
STD_TP = STD_TP';

X_HR = 1 : 3 : 10;
X_TR = 1.5 : 3 : 10.5;
X_AR = 2 : 3 : 11;
X_TP = 2.5 : 3 : 11.5;
model_name_order = {'SSP1-2.6','SSP2-4.5','SSP3-7.0','SSP5-8.5'}

figure1 = figure('Position', [1, 1, 1000, 600],'paperpositionmode','auto');
GO_HR = bar(X_HR,Diffs_HR_all_Areamean,1,'EdgeColor','k');
hold on
GO_TR = bar(X_TR,Diffs_TR_all_Areamean,1,'EdgeColor','k');
hold on
GO_AR = bar(X_AR,Diffs_AR_all_Areamean,1,'EdgeColor','k');
hold on
GO_TP = bar(X_TP,Diffs_TP_all_Areamean,1,'EdgeColor','k');

set(GO_HR,'Barwidth',0.2,'linewidth',1)
set(GO_TR,'Barwidth',0.2,'linewidth',1)
set(GO_AR,'Barwidth',0.2,'linewidth',1)
set(GO_TP,'Barwidth',0.2,'linewidth',1)

RGB = cbrewer('seq','OrRd',6,'linear');

set(GO_HR, 'Facecolor', RGB(2,:)) % 橙色
set(GO_TR, 'Facecolor', RGB(3,:)) % 深橙色
set(GO_AR, 'Facecolor', RGB(4,:)) % 红色
set(GO_TP, 'Facecolor', RGB(5,:)) % 深红色

% set(hE,'linestyle','none','linewidth',2)

set(gca, 'Box', 'on', ...                                         % 边框
    'XGrid', 'off', 'YGrid', 'on', ...                        % 网格
    'TickDir', 'in', 'TickLength', [.01 .01], ...            % 刻度
    'XMinorTick', 'off', 'YMinorTick', 'on', ...             % 小刻度
    'XColor', [.1 .1 .1],  'YColor', [.1 .1 .1],...           % 坐标轴颜色
    'YTick', 0.01:0.02:0.07,...                                      % 刻度位置、间隔
    'Ylim' , [0.01 0.07], ...                                     % 坐标轴范围
    'XTick', 1.75:3:10.75,...                                      % 刻度位置、间隔
    'Xlim' , [0 12.5], ...                                     % 坐标轴范围
    'Xticklabel',model_name_order,...% X坐标轴刻度标签
    'fontname','Times new roman','fontsize',15,...
    'linewidth',2)

% 强制保留小数位数
clear cb_tick Tick_label n
cb_tick = get(gca,'ytick');
Tick_label = cell(1,length(cb_tick));
for n = 1 : length(cb_tick)
    Tick_label{1,n} = num2str(roundn(cb_tick(n),-2),'%4.2f');
end
set(gca,'yticklabel',Tick_label)

ylabel('降水集中度差值','fontname','宋体','fontsize',20)
text('string','(e)','Units','normalized','position',[0.02,0.95],'fontsize',25,'FontName','Times new Roman')

lgd = legend([GO_HR,GO_TR,GO_AR,GO_TP],'湿润区','过渡区','干旱区','高寒区','fontname','宋体','fontsize',20,'location','north');
set(lgd,'box','off',...
    'NumColumns',4)

cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\011-02-His-RF-models-input-future-X-and-plus-correction\')
exportgraphics(gcf,'未来时期模拟的基尼系数与CMIP6降水数据的基尼系数的差值在气候区的分布情况.jpg')












