%% 根据提取出来的未来时期数据以及阈值（以未来时期30a的95分位数），提取三种雨的时段数和降水量占比
%% 涉及三个模型
%% 这里先模型各自求气候态，然后再求集合平均

%% 先转为3维矩阵
%% 降水时段数+暴雨降水量占比
clear;clc;
path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')
model_name = {'MPI-ESM1-2-HR','NorESM2-MM','MIROC6'};
SSP_type = {'ssp126','ssp245','ssp370','ssp585'};

save_peth_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\5-2-future-pr-and-Tas-025-scale-cell-data\';
cd(save_peth_1)
filename_1 = 'MIROC6_ssp126_Pr_CN_025_scale_2031_2060.mat';
load(filename_1)
clear filename_1

Lon = xx_025(:,1);
Lat = yy_025(1,:);

for i = 1 : length(model_name) % 选择模式读取数据
    for j = 1 : length(SSP_type)
        save_peth_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\10-1-30a-all-pre-R95\pre_amount_percentage_and_pre_intervals\';
        cd(save_peth_1)
        load([model_name{i},'_',SSP_type{j},'_2031_2060_Pre_intervals_of_pre_event_thresold_5_95_in_cell.mat'])
        load([model_name{i},'_',SSP_type{j},'_2031_2060_Pre_amount_percentage_of_pre_event_thresold_5_95_in_cell.mat'])
        
        heavy_rain_amount_percentage_3h_matrix = nan(length(Lon),length(Lat),size(Pre_intervals_pre_event,1));
        Moderate_rain_intervals_3h_matrix = nan(length(Lon),length(Lat),size(Pre_intervals_pre_event,1));
        
        for year = 1 : size(Pre_intervals_pre_event,1)
            Pre_amount_percentage_pre_event_year = Pre_amount_percentage_pre_event(year,:);
            Pre_intervals_pre_event_year = Pre_intervals_pre_event(year,:);
            
            heavy_rain_percentage_3h_matrix_line = nan(1,length(Lon)*length(Lat));
            moderate_rain_intervals_3h_matrix_line = nan(1,length(Lon)*length(Lat));
            for m = 1 : length(heavy_rain_percentage_3h_matrix_line)
                moderate_rain_intervals_3h_matrix_line(m) = Pre_intervals_pre_event_year{1,m}(2); % 中雨时段数
                heavy_rain_percentage_3h_matrix_line(m) = Pre_amount_percentage_pre_event_year{1,m}(3); % 这里的单位是%
            end
            clear Pre_intervals_pre_event_year Pre_amount_percentage_pre_event_year
            
            heavy_rain_percentage_3h_year = reshape(heavy_rain_percentage_3h_matrix_line,[length(Lon),length(Lat)]);
            moderate_rain_intervals_3h_year = reshape(moderate_rain_intervals_3h_matrix_line,[length(Lon),length(Lat)]);
            clear moderate_rain_intervals_3h_matrix_line heavy_rain_percentage_3h_matrix_line
            heavy_rain_amount_percentage_3h_matrix(:,:,year) = heavy_rain_percentage_3h_year;
            Moderate_rain_intervals_3h_matrix(:,:,year) = moderate_rain_intervals_3h_year;
            clear heavy_rain_percentage_3h_year moderate_rain_intervals_3h_year
            disp([num2str(year),'of ',model_name{i},' in ',SSP_type{j},' is done!'])
        end
        filename = [model_name{i},'_',SSP_type{j},'_heavy_rain_percentage_025_scale_pre_event_thresold_5_95_matrix.mat'];
        save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\10-1-30a-all-pre-R95\Heavy_rain_percentage_and_Moderate_rain_intervals_3D_matrix\',filename],...
            'heavy_rain_amount_percentage_3h_matrix','Lon','Lat')
        filename2 = [model_name{i},'_',SSP_type{j},'_moderate_rain_intervals_025_scale_pre_event_thresold_5_95_matrix.mat'];
        save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\10-1-30a-all-pre-R95\Heavy_rain_percentage_and_Moderate_rain_intervals_3D_matrix\',filename2],...
            'Moderate_rain_intervals_3h_matrix','Lon','Lat')
        clear filename filename2 heavy_rain_amount_percentage_3h_matrix Moderate_rain_intervals_3h_matrix
    end
end

%% 计算三个模型的集合平均
%% 第一种是要用于揭示暴雨降水量占比与降水集中度的关系

clear;clc;

path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')
model_name = {'MPI-ESM1-2-HR','NorESM2-MM','MIROC6'};
SSP_type = {'ssp126','ssp245','ssp370','ssp585'};

save_peth_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\5-2-future-pr-and-Tas-025-scale-cell-data\';
cd(save_peth_1)
filename_1 = 'MIROC6_ssp126_Pr_CN_025_scale_2031_2060.mat';
load(filename_1)
clear filename_1

Lon = xx_025(:,1);
Lat = yy_025(1,:);

for j = 1 : length(SSP_type)
    
    heavy_rain_amount_percentage_year_ensemble = nan(length(Lon),length(Lat),30);
    Moderate_rain_intervals_year_ensemble = nan(length(Lon),length(Lat),30);
    
    for year = 1 : 30
        heavy_rain_amount_percentage_year_3_model = nan(length(Lon),length(Lat),length(model_name));
        Moderate_rain_intervals_year_3_model = nan(length(Lon),length(Lat),length(model_name));
        
        for i = 1 : length(model_name) % 选择模式读取数据
            
            filename = [model_name{i},'_',SSP_type{j},'_heavy_rain_percentage_025_scale_pre_event_thresold_5_95_matrix.mat'];
            load(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\10-1-30a-all-pre-R95\Heavy_rain_percentage_and_Moderate_rain_intervals_3D_matrix\',filename])
            filename2 = [model_name{i},'_',SSP_type{j},'_moderate_rain_intervals_025_scale_pre_event_thresold_5_95_matrix.mat'];
            load(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\10-1-30a-all-pre-R95\Heavy_rain_percentage_and_Moderate_rain_intervals_3D_matrix\',filename2])
            
            heavy_rain_amount_percentage_year_3_model(:,:,i) = heavy_rain_amount_percentage_3h_matrix(:,:,year);
            Moderate_rain_intervals_year_3_model(:,:,i) = Moderate_rain_intervals_3h_matrix(:,:,year);
            
        end
        
        heavy_rain_amount_percentage_year_ensemble(:,:,year) = nanmean(heavy_rain_amount_percentage_year_3_model,3);
        Moderate_rain_intervals_year_ensemble(:,:,year)  = nanmean(Moderate_rain_intervals_year_3_model,3);
        clear heavy_rain_amount_percentage_year_3_model Moderate_rain_intervals_year_3_model
        disp([num2str(year),' in ',SSP_type{j},' ensemble is done!'])
    end
    
    filename = [SSP_type{j},'three_models_ensemble_yearly_heavy_rain_percentage_025_scale_pre_event_thresold_5_95_matrix.mat'];
    save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\10-1-30a-all-pre-R95\Model_ensemble_Heavy_rain_percentage_and_Moderate_rain_intervals_3D_matrix\annual\',filename],...
        'heavy_rain_amount_percentage_year_ensemble','Lon','Lat')
    filename2 = [SSP_type{j},'three_models_ensemble_yearly_moderate_rain_intervals_025_scale_pre_event_thresold_5_95_matrix.mat'];
    save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\10-1-30a-all-pre-R95\Model_ensemble_Heavy_rain_percentage_and_Moderate_rain_intervals_3D_matrix\annual\',filename2],...
        'Moderate_rain_intervals_year_ensemble','Lon','Lat')
    clear Moderate_rain_intervals_year_ensemble heavy_rain_amount_percentage_year_ensemble
end


%% 先求模型自己的气候态

clear;clc;

path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')
model_name = {'MPI-ESM1-2-HR','NorESM2-MM','MIROC6'};
SSP_type = {'ssp126','ssp245','ssp370','ssp585'};

save_peth_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\5-2-future-pr-and-Tas-025-scale-cell-data\';
cd(save_peth_1)
filename_1 = 'MIROC6_ssp126_Pr_CN_025_scale_2031_2060.mat';
load(filename_1)
clear filename_1

Lon = xx_025(:,1);
Lat = yy_025(1,:);

for j = 1 : length(SSP_type)
    
    heavy_rain_amount_percentage_climatic_3_model = nan(length(Lon),length(Lat),length(model_name));
    Moderate_rain_intervals_climatic_3_model = nan(length(Lon),length(Lat),length(model_name));
    
    for i = 1 : length(model_name) % 选择模式读取数据
        
        filename = [model_name{i},'_',SSP_type{j},'_heavy_rain_percentage_025_scale_pre_event_thresold_5_95_matrix.mat'];
        load(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\10-1-30a-all-pre-R95\Heavy_rain_percentage_and_Moderate_rain_intervals_3D_matrix\',filename])
        filename2 = [model_name{i},'_',SSP_type{j},'_moderate_rain_intervals_025_scale_pre_event_thresold_5_95_matrix.mat'];
        load(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\10-1-30a-all-pre-R95\Heavy_rain_percentage_and_Moderate_rain_intervals_3D_matrix\',filename2])
        
        heavy_rain_amount_percentage_climatic_3_model(:,:,i) = nanmean(heavy_rain_amount_percentage_3h_matrix,3);
        Moderate_rain_intervals_climatic_3_model(:,:,i) = nanmean(Moderate_rain_intervals_3h_matrix,3);
        
    end
    
    % 求集合平均
    heavy_rain_amount_percentage_climatic_ensemble = nanmean(heavy_rain_amount_percentage_climatic_3_model,3);
    Moderate_rain_intervals_climatic_ensemble = nanmean(Moderate_rain_intervals_climatic_3_model,3);
    clear heavy_rain_amount_percentage_climatic_3_model Moderate_rain_intervals_climatic_3_model
    
    filename = [SSP_type{j},'three_models_ensemble_heavy_rain_percentage_025_scale_pre_event_thresold_5_95_matrix.mat'];
    save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\10-1-30a-all-pre-R95\Model_ensemble_Heavy_rain_percentage_and_Moderate_rain_intervals_3D_matrix\climatic\',filename],...
        'heavy_rain_amount_percentage_climatic_ensemble','Lon','Lat')
    filename2 = [SSP_type{j},'three_models_ensemble_moderate_rain_intervals_025_scale_pre_event_thresold_5_95_matrix.mat'];
    save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\10-1-30a-all-pre-R95\Model_ensemble_Heavy_rain_percentage_and_Moderate_rain_intervals_3D_matrix\climatic\',filename2],...
        'Moderate_rain_intervals_climatic_ensemble','Lon','Lat')
    
end



