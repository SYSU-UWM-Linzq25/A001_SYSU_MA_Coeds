%% 这个文件根据选择出来的三个最优模式的历史时期基尼系数
%% 历史时期为1985-2014
%% 它们各自的Sen趋势和集合平均的Sen趋势

%% 三种CMIP6 模型各自的Sen趋势
clear;clc;

model_name = {'MPI-ESM1-2-HR','NorESM2-MM','MIROC6'};
save_path_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2018-2058\7-5-His-pr-025-scale-Gini\';
cd(save_path_1)

for m = 1 : length(model_name) % 选择模式读取数据
    filename = [model_name{m},'_1d_Gini_025_scale_1975_2014.mat'];
    load(filename)
    clear filename
    
    % 只保留1985-2014
    G_all = Model_His_Gini(:,:,11:end);
    clear Model_His_Gini
    
    Gini_Sen_slope_1d = nan(size(G_all,1),size(G_all,2));
    Gini_MK_1d = nan(size(G_all,1),size(G_all,2));
    % 计算Sen趋势
    for i = 1 : size(G_all,1)
        for j = 1 : size(G_all,2)
            a = reshape(G_all(i,j,:),[1,size(G_all,3)]);
            Gini_Sen_slope_1d(i,j) = Theil_Sen_Regress((1985:2014)',a');
            Gini_MK_1d(i,j) = MK(a');
            clear a
        end
    end
    
    clear filename2
    filename2 = [model_name{m},'_025_scale_Gini_SenTrend_CN_1985_2014.mat'];
    save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\5-1-His-pr-025-scale-Gini\',filename2],'Gini_Sen_slope_1d','Gini_MK_1d','xx_025','yy_025')
    clear Gini_Sen_slope_1d Gini_MK_1d p_value xx_025 yy_025 filename2 G_all
end

%% 计算集合平均下的基尼系数线性趋势

clear;clc;

filename2 = 'Three_Model_ensemble_average_025_scale_Gini_CN_1985_2014.mat';
load(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\5-1-His-pr-025-scale-Gini\asemble\',filename2])

% 这里只是将前两维展开为1维，这样第三维还是表征的基尼系数
Gini_Sen_slope_1d = nan(size(Model_GI_ensemble_average_year,1),size(Model_GI_ensemble_average_year,2));
Gini_MK_1d = nan(size(Model_GI_ensemble_average_year,1),size(Model_GI_ensemble_average_year,2));
% 计算Sen趋势
for i = 1 : size(Model_GI_ensemble_average_year,1)
    for j = 1 : size(Model_GI_ensemble_average_year,2)
        a = reshape(Model_GI_ensemble_average_year(i,j,:),[1,size(Model_GI_ensemble_average_year,3)]);
        Gini_Sen_slope_1d(i,j) = Theil_Sen_Regress((1985:2014)',a');
        Gini_MK_1d(i,j) = MK(a');
        clear a
    end
end

clear filename2
filename2 = 'Three_Model_ensemble_average_025_scale_Gini_SenTrend_CN_1985_2014.mat';
save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\5-1-His-pr-025-scale-Gini\asemble\',filename2],'Gini_Sen_slope_1d','Gini_MK_1d','xx_025','yy_025')
