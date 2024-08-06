%% 这个文件计算暴雨的不同特征对降水集中度的影响
%% 包括暴雨的降水量占比
%% 对象为CMIP6未来时期，2031-2060年
%% 集合平均下的降水集中度和暴雨降水量占比

clear;clc;

% 读取未来时期集合平均的基尼系数(逐年取集合平均)
% 读取基尼系数逐年数据
SSP_type = {'ssp126','ssp245','ssp370','ssp585'};

for j = 1 : length(SSP_type)
    filename2 = [SSP_type{j},'_3_Model_ensemble_annual_GI_025_scale_CN_2031_2060.mat'];
    load(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\7-4-future-025-ensemble-annual-GI\',filename2])
    
    eval(['GI_ensemble_',SSP_type{j},'_2D = reshape(Model_GI_3_model_ensemble_annual,[],size(Model_GI_3_model_ensemble_annual,3));'])
    clear Model_GI_3_model_ensemble_annual
    
    % 计算全国区域平均
    eval(['GI_ensemble_',SSP_type{j},'_Areamean = nanmean(GI_ensemble_',SSP_type{j},'_2D,1)'';'])
    %     eval(['clear GI_ensemble_',SSP_type{j},'_2D'])
end

% 读取暴雨发生频率(逐年取集合平均)
cd('J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\10-1-30a-all-pre-R95\Model_ensemble_Heavy_rain_percentage_and_Moderate_rain_intervals_3D_matrix\annual\')

for j = 1 : length(SSP_type)
    
    filename = [SSP_type{j},'three_models_ensemble_yearly_heavy_rain_percentage_025_scale_pre_event_thresold_5_95_matrix.mat'];
    load(filename)
    %     filename2 = [SSP_type{j},'three_models_ensemble_yearly_moderate_rain_intervals_025_scale_pre_event_thresold_5_95_matrix.mat'];
    %     load(filename2)
    
    eval(['Heavy_rain_percent_year_ensemble_',SSP_type{j},'_2D = reshape(heavy_rain_amount_percentage_year_ensemble,[],size(heavy_rain_amount_percentage_year_ensemble,3));']);
    %     eval(['Moderate_rain_intervals_year_ensemble_',SSP_type{j},'_2D = reshape(Moderate_rain_intervals_year_ensemble,[],size(Moderate_rain_intervals_year_ensemble,3));']);
    clear heavy_rain_amount_percentage_year_ensemble
    
    % 计算全国区域平均
    eval(['Heavy_rain_percent_',SSP_type{j},'_Areamean = nanmean(Heavy_rain_percent_year_ensemble_',SSP_type{j},'_2D,1)'';'])
    %     eval(['clear Heavy_rain_percent_year_ensemble_',SSP_type{j},'_2D'])
end

% 读取气候分区信息，重新划分
% 读取气候分区的index
load(['J:\6-硕士毕业论文\1-Data\Climate_zone_index\', 'Four_Climite_zone_index_025_scale.mat'])
Four_climate_zone_index_025_line = reshape(Four_climate_zone_index_025,[length(Lon_025)*length(Lat_025),1]);
% 提取气候区的索引(按单列的做)
k_HR = find(Four_climate_zone_index_025_line == 1);
k_TR = find(Four_climate_zone_index_025_line == 2);
k_AR = find(Four_climate_zone_index_025_line == 3);
k_TP = find(Four_climate_zone_index_025_line == 4);
% clear Four_climate_zone_index_025_line

% 按照气候区划分，然后计算heavy_rain_amount_percent和基尼系数的关系
climate_zone_name = {'HR','TR','AR','TP'};
for j = 1 : length(SSP_type)
    for m = 1 : length(climate_zone_name)
        
        eval(['GI_',SSP_type{j},'_',climate_zone_name{m},' = GI_ensemble_',SSP_type{j},'_2D(k_',climate_zone_name{m},',:);'])
        eval(['Heavy_rain_',SSP_type{j},'_',climate_zone_name{m},' = Heavy_rain_percent_year_ensemble_',SSP_type{j},'_2D(k_',climate_zone_name{m},',:);'])
        
        eval(['Grid_num = length(k_',climate_zone_name{m},');'])
        
        % 求每个网格的相关系数
        for n = 1 : Grid_num
            eval(['[PCCs_1,P_1] = corrcoef(Heavy_rain_',SSP_type{j},'_',climate_zone_name{m},'(n,:),GI_',SSP_type{j},'_',climate_zone_name{m},'(n,:));'])
            eval(['PCCs_Heavy_rain_and_GI_',SSP_type{j},'_',climate_zone_name{m},'(n,1) = PCCs_1(2);'])
            clear PCCs_1 P_1
        end
    end
end

% 按照气候区整理在一起
for m = 1 : length(climate_zone_name)
    for j = 1 : length(SSP_type)
        eval(['PCCs_',climate_zone_name{m},'_all(:,j) = PCCs_Heavy_rain_and_GI_',SSP_type{j},'_',climate_zone_name{m},';'])
    end
    eval(['PCCs_',climate_zone_name{m},'_all_mean = nanmean(PCCs_',climate_zone_name{m},'_all,1);'])
    eval(['PCCs_',climate_zone_name{m},'_all_25 = prctile(PCCs_',climate_zone_name{m},'_all,25);'])
    eval(['PCCs_',climate_zone_name{m},'_all_75 = prctile(PCCs_',climate_zone_name{m},'_all,75);'])
end

clearvars -except PCCs_HR_all_mean PCCs_HR_all_25 PCCs_HR_all_75

% 0.1尺度的CMFD的相关系数
% 读取四个气候区下，四个时间尺度下
% 基尼系数和暴雨降水量占比的数据
save_path = 'J:\6-硕士毕业论文\1-Data\PCCs-bewteen-Heavy-rain-features-and-GI\';
Temporal_scale_name = {'3h','6h','12h','1d'};
climate_zone_name = {'HR','TR','AR','TP'};

% 循环读取变量
for i = 1 : length(Temporal_scale_name)
    for j = 1 : length(climate_zone_name)
        filename2 = ['PCCs_GI_and_heavy_rain_amount_percentage_',Temporal_scale_name{i},'_',climate_zone_name{j},'.mat'];
        load([save_path,filename2])
    end
end

% 进行合并调整,按照气候区的放在一起
for j = 1 : length(climate_zone_name)
    for i = 1 : length(Temporal_scale_name)
        
        eval(['PCCs_',climate_zone_name{j},'_all_01(:,i) = PCCs_GI_and_heavy_rain_amount_percentage_',Temporal_scale_name{i},'_',climate_zone_name{j},''';'])
        eval(['P_',climate_zone_name{j},'_all_01(:,i) = P_GI_and_heavy_rain_amount_percentage_',Temporal_scale_name{i},'_',climate_zone_name{j},''';'])
    end
end
for j = 1 : length(climate_zone_name)
    eval(['PCCs_',climate_zone_name{j},'_all_mean_01 = nanmean(PCCs_',climate_zone_name{j},'_all_01,1);'])
    eval(['PCCs_',climate_zone_name{j},'_all_01_25 = prctile(PCCs_',climate_zone_name{j},'_all_01,25);'])
    eval(['PCCs_',climate_zone_name{j},'_all_01_75 = prctile(PCCs_',climate_zone_name{j},'_all_01,75);'])
end
% clearvars -except PCCs_HR_all PCCs_TR_all PCCs_AR_all PCCs_TP_all PCCs_HR_all_mean PCCs_TR_all_mean PCCs_AR_all_mean PCCs_TP_all_mean...
%     PCCs_HR_all_01 PCCs_AR_all_01 PCCs_TR_all_01 PCCs_TP_all_01 PCCs_HR_all_mean_01 PCCs_TR_all_mean_01 PCCs_AR_all_mean_01 PCCs_TP_all_mean_01

clearvars -except PCCs_HR_all_mean PCCs_HR_all_mean_01 PCCs_HR_all_25 PCCs_HR_all_75 PCCs_HR_all_01_25 PCCs_HR_all_01_75

% 只画湿润区，因为历史时期只有这部分在日尺度暴雨降水量占比与基尼系数有比较好的正相关关系
% 历史时期只保留日尺度，然后整合在一起

PCCs_HR_HR = nan(1,5);
PCCs_HR_HR_25 = nan(1,5);
PCCs_HR_HR_75 = nan(1,5);

PCCs_HR_HR(1) = PCCs_HR_all_mean_01(4);
PCCs_HR_HR(2:end) = PCCs_HR_all_mean;
PCCs_HR_HR_25(1) = PCCs_HR_all_01_25(4);
PCCs_HR_HR_25(2:end) = PCCs_HR_all_25;
PCCs_HR_HR_75(1) = PCCs_HR_all_01_75(4);
PCCs_HR_HR_75(2:end) = PCCs_HR_all_75;

%%
clearvars -except PCCs_HR_HR PCCs_HR_HR_25 PCCs_HR_HR_75


%% 画图

% 误差矩阵
AVG = PCCs_HR_HR - PCCs_HR_HR_25;
STD = PCCs_HR_HR_75 - PCCs_HR_HR;
PCCs_HR_HR = PCCs_HR_HR';
AVG = AVG';
STD = STD';

model_name_order = {'CMFD','SSP1-2.6','SSP2-4.5','SSP3-7.0','SSP5-8.5'};
X = 1 : 1 : 5;

figure1 = figure('Position', [1, 1, 1000, 600],'paperpositionmode','auto');
GO = bar(X,PCCs_HR_HR,1,'EdgeColor','k');
hold on

% 添加误差棒
[M,N] = size(PCCs_HR_HR);
xpos = zeros(M,N);
for i = 1:N
    xpos(:,i) = GO(1,i).XEndPoints'; % v2019b
end
hE = errorbar(xpos, PCCs_HR_HR, AVG, STD);
hold off
set(hE,'linestyle','none','linewidth',2)
set(GO,'Facecolor',[.1,.1,.2])
set(GO,'Barwidth',0.5,'linewidth',1)
set(gca, 'Box', 'on', ...                                         % 边框
    'XGrid', 'off', 'YGrid', 'off', ...                        % 网格
    'TickDir', 'in', 'TickLength', [.01 .01], ...            % 刻度
    'XMinorTick', 'off', 'YMinorTick', 'on', ...             % 小刻度
    'XColor', [.1 .1 .1],  'YColor', [.1 .1 .1],...           % 坐标轴颜色
    'YTick', -0.05:0.05:0.5,...                                      % 刻度位置、间隔
    'Ylim' , [-0.05 0.5], ...                                     % 坐标轴范围
    'Xticklabel',model_name_order,...% X坐标轴刻度标签
    'fontname','Times new roman','fontsize',15,...
    'linewidth',2)
%          'Yticklabel',{[0:0.02:0.06]})


% 强制保留小数位数
clear cb_tick Tick_label n
cb_tick = get(gca,'ytick');
Tick_label = cell(1,length(cb_tick));
for n = 1 : length(cb_tick)
    Tick_label{1,n} = num2str(roundn(cb_tick(n),-2),'%4.2f');
end
set(gca,'yticklabel',Tick_label)


ylabel('相关系数','fontname','宋体','fontsize',20)
text('string','1-day','Units','normalized','position',[0.138,-0.08],  'FontSize',16,'FontName','times new roman')

cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\008-07-PCCs-bar-heavy-rain-amount-percent-and-GI-HR-CMIP6-2031-2060\')
exportgraphics(gcf,'未来时期湿润区暴雨降水量占比和基尼系数相关系数柱状图.jpg')