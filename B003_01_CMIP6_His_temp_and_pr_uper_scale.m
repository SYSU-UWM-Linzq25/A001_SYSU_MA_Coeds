%% 根据CMIP6历史时期数据
%% 在统一的降水阈值处理下 0.1 mm/h
%% 与CMFD-1d-0.25°结果相比较，筛选其中模拟效果最好的
%% 可以计算RMSE的空间分布图，也可以在纬度方向上开展比较

%% 首先是将已有的CMIP6历史时期数据整合到0.25°上
%% 包括温度和降水数据

%% 降水数据
clear;clc;

% 读取整合到0.25°上的经纬度坐标
filename2 = 'CMFD_1d_Gini_025_scale_01mmh.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\6-CMFD-025-scale-Gini&LinearTend\',filename2]);
[xx_025,yy_025] = meshgrid(Lon_025,Lat_025);
xx_025 = xx_025';
yy_025 = yy_025';
clear Gini_CMFD_1d_025_scale_01mmh

% CMIP6不同模型的历史时期数据
model_name = {'MPI-ESM1-2-HR','IITM-ESM','NorESM2-LM','NorESM2-MM','MIROC6','TaiESM1','MPI-ESM1-2-LR','BCC-CSM2-MR','MRI-ESM2-0','CanESM5'};
save_path_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2018-2058\7-3-history-pr-process-cell-data\';
cd(save_path_1)
for i = 1 : length(model_name) % 选择模式读取数据
    
    filename = [model_name{i},'_CN_1975_2014.mat'];
    load(filename)
    clear filename
    % 将模型对应使用的经纬度插值为经纬度网格
    [xx_model,yy_model] = meshgrid(Lon_CN,Lat_CN);
    xx_model = xx_model';
    yy_model = yy_model';
    clear Lon_CN Lat_CN
    
    % 设立0.25°的模型cell库
    CMIP6_model_HisPr_1975_2014_025_scale = cell(length(CMIP6_model_HisPr_1975_2014),1);
    for j = 1 : length(CMIP6_model_HisPr_1975_2014)
        % 读取历史时期每一年的日降水数据
        Model_daily_pr_year = CMIP6_model_HisPr_1975_2014{j};
        Model_daily_pr_025_scale_year = nan(size(xx_025,1),size(xx_025,2),size(Model_daily_pr_year,3));
        % 进一步在日循环
        for m = 1 : size(Model_daily_pr_year,3)
            Model_daily_pr_day = Model_daily_pr_year(:,:,m);
            % 双线性插值到0.25°的网格
            Model_daily_pr_025_scale_year(:,:,m) = griddata(xx_model,yy_model,Model_daily_pr_day,xx_025,yy_025,'linear');
            clear Model_daily_pr_day
            disp([num2str(m), ' day of ',num2str(j + 1974), ' of Model ',num2str(i), ' is done!'])
        end
        CMIP6_model_HisPr_1975_2014_025_scale{j} = Model_daily_pr_025_scale_year;
        clear Model_daily_pr_025_scale_year Model_daily_pr_year
    end
    clear filename2 xx_model yy_model
    filename2 = [model_name{i},'_CN_025_scale_1975_2014.mat'];
    save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2018-2058\7-4-His-pr-025-scale-cell-data\',filename2],'CMIP6_model_HisPr_1975_2014_025_scale','xx_025','yy_025')
    clear CMIP6_model_HisPr_1975_2014_025_scale
end


% 验证
% figure('Position', [1, 1, 1300, 1000],'paperpositionmode','auto');
% m_proj('miller','lon',[70,140],'lat',[10,57]);%选择投影方式
% m_pcolor(xx_model,yy_model,Model_daily_pr_day);
% m_grid('fontsize',20,'tickdir','out','linestyle','none') % 在grid这里调整网格以及坐标模式，xtick可以直接改变坐标轴所需要的刻度多少
% m_ruler([0.03 0.2],0.05,2,'linewid',4,'ticklen',0.01,'fontsize',15); % 设置'tickdir','out'会导致图colorbar强制改变
% cc = caxis;
%
% figure('Position', [1, 1, 1300, 1000],'paperpositionmode','auto');
% m_proj('miller','lon',[70,140],'lat',[10,57]);%选择投影方式
% m_pcolor(xx_025,yy_025,Model_daily_pr_025_scale);
% m_grid('fontsize',20,'tickdir','out','linestyle','none') % 在grid这里调整网格以及坐标模式，xtick可以直接改变坐标轴所需要的刻度多少
% m_ruler([0.03 0.2],0.05,2,'linewid',4,'ticklen',0.01,'fontsize',15); % 设置'tickdir','out'会导致图colorbar强制改变
% caxis(cc)

%% 温度数据

clear;clc;

% 读取整合到0.25°上的经纬度坐标
filename2 = 'CMFD_1d_Gini_025_scale_01mmh.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\6-CMFD-025-scale-Gini&LinearTend\',filename2]);
[xx_025,yy_025] = meshgrid(Lon_025,Lat_025);
xx_025 = xx_025';
yy_025 = yy_025';
clear Gini_CMFD_1d_025_scale_01mmh

% CMIP6不同模型的历史时期数据
model_name = {'MPI-ESM1-2-HR','IITM-ESM','NorESM2-LM','NorESM2-MM','MIROC6','TaiESM1','MPI-ESM1-2-LR','BCC-CSM2-MR','MRI-ESM2-0','CanESM5'};
save_path_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2018-2058\7-3-history-temp-process-cell-data';
cd(save_path_1)
for i = 1 : length(model_name) % 选择模式读取数据
    if i ~= 2 && i~= 5 && i~= 8 && i~=10 % 部分模型并没有温度数据
        filename = [model_name{i},'_CN_1975_2014.mat'];
        load(filename)
        clear filename
        % 将模型对应使用的经纬度插值为经纬度网格
        [xx_model,yy_model] = meshgrid(Lon_CN,Lat_CN);
        xx_model = xx_model';
        yy_model = yy_model';
        clear Lon_CN Lat_CN
        
        % 设立0.25°的模型cell库
        CMIP6_model_HisTemp_1975_2014_025_scale = cell(length(CMIP6_model_HisTemp_1975_2014),1);
        for j = 1 : length(CMIP6_model_HisTemp_1975_2014)
            % 读取历史时期每一年的日降水数据
            Model_daily_temp_year = CMIP6_model_HisTemp_1975_2014{j};
            Model_daily_temp_025_scale_year = nan(size(xx_025,1),size(xx_025,2),size(Model_daily_temp_year,3));
            % 进一步在日循环
            for m = 1 : size(Model_daily_temp_year,3)
                Model_daily_temp_day = Model_daily_temp_year(:,:,m);
                % 双线性插值到0.25°的网格
                Model_daily_temp_025_scale_year(:,:,m) = griddata(xx_model,yy_model,Model_daily_temp_day,xx_025,yy_025,'linear');
                clear Model_daily_temp_day
                disp([num2str(m), ' day of ',num2str(j + 1974), ' of Model ',num2str(i), ' is done!'])
            end
            CMIP6_model_HisTemp_1975_2014_025_scale{j} = Model_daily_temp_025_scale_year;
            clear Model_daily_temp_025_scale_year Model_daily_temp_year
        end
        clear filename2 xx_model yy_model
        filename2 = [model_name{i},'_CN_025_scale_1975_2014.mat'];
        save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2018-2058\7-4-His-temp-025-scale-cell-data\',filename2],'CMIP6_model_HisTemp_1975_2014_025_scale','xx_025','yy_025')
        clear CMIP6_model_HisTemp_1975_2014_025_scale
    end
end




