%% 这个文件根据计算得到的未来时期逐年年均温、年降水量和基尼系数
%% 计算温度和降水量对降水集中度的印象

% 年均温在全国并没有很明显的线性关系，因此分气候区研究

clear;clc;

path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')

% 读取基尼系数逐年数据
SSP_type = {'ssp126','ssp245','ssp370','ssp585'};

for j = 1 : length(SSP_type)
    filename2 = [SSP_type{j},'_3_Model_ensemble_annual_GI_025_scale_CN_2031_2060.mat'];
    load(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\7-4-future-025-ensemble-annual-GI\',filename2])
    
    eval(['GI_ensemble_',SSP_type{j},'_2D = reshape(Model_GI_3_model_ensemble_annual,[],size(Model_GI_3_model_ensemble_annual,3));'])
    clear Model_GI_3_model_ensemble_annual
    
    % 计算全国区域平均
    eval(['GI_ensemble_',SSP_type{j},'_Areamean = nanmean(GI_ensemble_',SSP_type{j},'_2D,1);'])
    %     eval(['clear GI_ensemble_',SSP_type{j},'_2D'])
end

% 读取年均温和年降水量逐年数据
for j = 1 : length(SSP_type)
    filename2 = [SSP_type{j},'_3_Model_ensemble_annual_MAT_025_scale_CN_2031_2060.mat'];
    load(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\6-3-future-025-scale-ensemble-annual-MAT-AP\',filename2])
    
    eval(['MAT_ensemble_',SSP_type{j},'_2D = reshape(Model_MAT_3_model_ensemble_annual,[],size(Model_MAT_3_model_ensemble_annual,3));'])
    clear Model_MAT_3_model_ensemble_annual
    
    % 计算全国区域平均
    eval(['MAT_ensemble_',SSP_type{j},'_Areamean = nanmean(MAT_ensemble_',SSP_type{j},'_2D,1);'])
    %     eval(['clear MAT_ensemble_',SSP_type{j},'_2D'])
end


for j = 1 : length(SSP_type)
    filename2 = [SSP_type{j},'_3_Model_ensemble_annual_AP_025_scale_CN_2031_2060.mat'];
    load(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\6-3-future-025-scale-ensemble-annual-MAT-AP\',filename2])
    
    eval(['AP_ensemble_',SSP_type{j},'_2D = reshape(Model_AP_3_model_ensemble_annual,[],size(Model_AP_3_model_ensemble_annual,3));'])
    clear Model_AP_3_model_ensemble_annual
    
    % 计算全国区域平均
    eval(['AP_ensemble_',SSP_type{j},'_Areamean = nanmean(AP_ensemble_',SSP_type{j},'_2D,1)'';'])
%     eval(['clear AP_ensemble_',SSP_type{j},'_2D'])
end

% % 尝试画全国的散点图
% for j = 1 : length(SSP_type)
%     figure
%     eval(['plot(MAT_ensemble_',SSP_type{j},'_Areamean,GI_ensemble_',SSP_type{j},'_Areamean,''b.'');'])
%     title(['MAT and GI satter in ',SSP_type{j}])
% end

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

% 根据索引进行气候区的提取
Climate_zone_name = {'HR','TR','AR','TP'};

for i = 1 : length(Climate_zone_name)
    for j = 1 : length(SSP_type)
        eval(['MAT_ensemble_',SSP_type{j},'_2D_',Climate_zone_name{i},' = nanmean(MAT_ensemble_',SSP_type{j},'_2D(k_',Climate_zone_name{i},',:),1)'';'])
        eval(['GI_ensemble_',SSP_type{j},'_2D_',Climate_zone_name{i},' = nanmean(GI_ensemble_',SSP_type{j},'_2D(k_',Climate_zone_name{i},',:),1)'';'])
        eval(['AP_ensemble_',SSP_type{j},'_2D_',Climate_zone_name{i},' = nanmean(AP_ensemble_',SSP_type{j},'_2D(k_',Climate_zone_name{i},',:),1)'';'])
    end
end

% 直接计算线性关系
b_MAT_GI = nan(4,4);
P_MAT_GI = nan(4,4);
b_AP_GI = nan(4,4);
P_AP_GI = nan(4,4);
for i = 1 : length(Climate_zone_name)
    for j = 1 : length(SSP_type)

        eval(['X1 = [ones(length(MAT_ensemble_',SSP_type{j},'_2D_',Climate_zone_name{i},'),1),MAT_ensemble_',SSP_type{j},'_2D_',Climate_zone_name{i},'];'])
        eval(['X2 = [ones(length(AP_ensemble_',SSP_type{j},'_2D_',Climate_zone_name{i},'),1),AP_ensemble_',SSP_type{j},'_2D_',Climate_zone_name{i},'];'])
        eval(['Y = GI_ensemble_',SSP_type{j},'_2D_',Climate_zone_name{i},';'])
        [b1,~,~,~,stats1] = regress(Y,X1,0.05);
        [b2,~,~,~,stats2] = regress(Y,X2,0.05);
        b_MAT_GI(i,j) = b1(2);
        P_MAT_GI(i,j) = stats1(3);
        
        b_AP_GI(i,j) = b2(2);
        P_AP_GI(i,j) = stats2(3);
        clear b1 stats1 b2 stats2 X1 X2 Y
    end
end
clearvars -except b_MAT_GI P_MAT_GI b_AP_GI P_AP_GI

table1 = cell(8,4);

table1(1:4,:) = num2cell(b_MAT_GI);
table1(5:end,:) = num2cell(b_AP_GI);

P_values = [P_MAT_GI;P_AP_GI];

for i = 1 : size(table1,1)
    for j = 1 : size(table1,2)
        aa = table1{i,j};
        if P_values(i,j) < 0.01
           table1{i,j} = [sprintf('%e',aa),'**']; 
        elseif P_values(i,j) < 0.05
           table1{i,j} = [sprintf('%e',aa),'*']; 
        else
           table1{i,j} = sprintf('%e',aa); 
        end
    end
end
cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\010-04-Table-future-MAT-and-AP-influence-in-four-climate-zones\')
filename = 'Table-5.2.3.xls';
xlswrite(filename, table1);