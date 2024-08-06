%% 计算没有升尺度的原始分辨率下，CMIP6-10个模型历史时期的基尼系数
%% 1985-2014

clear;clc;
path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')

model_name = {'MPI-ESM1-2-HR','IITM-ESM','NorESM2-LM','NorESM2-MM','MIROC6','TaiESM1','MPI-ESM1-2-LR','BCC-CSM2-MR','MRI-ESM2-0','CanESM5'};
save_path_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2018-2058\7-3-history-pr-process-cell-data\';
cd(save_path_1)

for i = 1 : length(model_name) % 选择模式读取数据
    
    filename = [model_name{i},'_CN_1975_2014.mat'];
    load(filename)
    
    Model_His_Gini = nan(length(Lon_CN),length(Lat_CN),length(CMIP6_model_HisPr_1975_2014));
    
    for j = 1 : length(CMIP6_model_HisPr_1975_2014)
        % 读取每一年的日尺度降水
        Model_daily_pr_year = CMIP6_model_HisPr_1975_2014{j};
        
        % 数据本身的单位是mm/day
        %以统一的阈值进行处理 0.1 mm/h
        Model_daily_pr_year(Model_daily_pr_year < 2.4) = 0;
        
        % 从三维转进二维
        Model_daily_pr_year_2D = reshape(Model_daily_pr_year,[],size(Model_daily_pr_year,3));
        
        % 计算基尼系数
        G_1D = ginicoeff(Model_daily_pr_year_2D,2,true);
        
        % 基尼系数转回2维
        Model_His_Gini(:,:,j) = reshape(G_1D,[size(Model_daily_pr_year,1),size(Model_daily_pr_year,2)]);
        disp([num2str(j + 1974), ' of Model ',num2str(i), ' is done!'])
        clear G_1D Model_daily_pr_year_2D Model_daily_pr_year
    end
    clear filename2
    filename2 = [model_name{i},'_1d_Gini_1975_2014.mat'];
    save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2018-2058\7-5-His-pr-origin-scale-Gini\',filename2],'Model_His_Gini','Lon_CN','Lat_CN')
    disp(['model ',num2str(i),' is done!'])
    clear Model_His_Gini filename CMIP6_model_HisPr_1975_2014
end

%% 根据升尺度（0.25°）的模型降水数据计算基尼系数

clear;clc;
path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')

model_name = {'MPI-ESM1-2-HR','IITM-ESM','NorESM2-LM','NorESM2-MM','MIROC6','TaiESM1','MPI-ESM1-2-LR','BCC-CSM2-MR','MRI-ESM2-0','CanESM5'};
save_path_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2018-2058\7-4-His-pr-025-scale-cell-data\';
cd(save_path_1)

for i = 1 : length(model_name) % 选择模式读取数据
    
    filename = [model_name{i},'_CN_025_scale_1975_2014.mat'];
    load(filename)
    
    Model_His_Gini = nan(size(xx_025,1),size(xx_025,2),length(CMIP6_model_HisPr_1975_2014_025_scale));
    
    for j = 1 : length(CMIP6_model_HisPr_1975_2014_025_scale)
        % 读取每一年的日尺度降水
        Model_daily_pr_year = CMIP6_model_HisPr_1975_2014_025_scale{j};
        
        % 数据本身的单位是mm/day
        %以统一的阈值进行处理 0.1 mm/h
        Model_daily_pr_year(Model_daily_pr_year < 2.4) = 0;
        
        % 从三维转进二维
        Model_daily_pr_year_2D = reshape(Model_daily_pr_year,[],size(Model_daily_pr_year,3));
        
        % 计算基尼系数
        G_1D = ginicoeff(Model_daily_pr_year_2D,2,true);
        
        % 基尼系数转回2维
        Model_His_Gini(:,:,j) = reshape(G_1D,[size(Model_daily_pr_year,1),size(Model_daily_pr_year,2)]);
        disp([num2str(j + 1974), ' of Model ',num2str(i), ' is done!'])
        clear G_1D Model_daily_pr_year_2D Model_daily_pr_year
    end
    clear filename2
    filename2 = [model_name{i},'_1d_Gini_025_scale_1975_2014.mat'];
    save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2018-2058\7-5-His-pr-025-scale-Gini\',filename2],'Model_His_Gini','xx_025','yy_025')
    clear Model_His_Gini filename
end