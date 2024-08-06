%% 这个文件根据选择出来的三个最优模式的历史时期基尼系数
%% 历史时期为1985-2014
%% 计算各自的线性趋势以及集合平均的线性趋势
%% 三种CMIP6 模型

clear;clc;

model_name = {'MPI-ESM1-2-HR','NorESM2-MM','MIROC6'};
save_path_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2018-2058\7-5-His-pr-025-scale-Gini\';
cd(save_path_1)

for i = 1 : length(model_name) % 选择模式读取数据
    filename = [model_name{i},'_1d_Gini_025_scale_1975_2014.mat'];
    load(filename)
    clear filename
    
    % 只保留1985-2014
    G_all = Model_His_Gini(:,:,11:end);
    clear Model_His_Gini
    
    % 这里只是将前两维展开为1维，这样第三维还是表征的基尼系数
    G_all_2D = reshape(G_all,[],size(G_all,3));
    G_Linear_Trend_2D = nan(size(G_all_2D,1),1);
    p_value_2D = nan(size(G_all_2D,1),1);
    time_2D = 1985:1:2014;
    for m = 1 : size(G_all_2D,1)
        [G_Linear_Trend_2D(m,1),~,p_value_2D(m,1),~] = Line_Trend_time_1D(G_all_2D(m,:)',time_2D);
    end
    G_Linear_Trend = reshape(G_Linear_Trend_2D,[size(G_all,1),size(G_all,2)]);
    p_value = reshape(p_value_2D,[size(G_all,1),size(G_all,2)]);
    
    clear filename2
    filename2 = [model_name{i},'_025_scale_Gini_LinearTrend_CN_1985_2014.mat'];
    save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\5-1-His-pr-025-scale-Gini\',filename2],'G_Linear_Trend','p_value','xx_025','yy_025')
    clear G_Linear_Trend p_value xx_025 yy_025 filename2 G_Linear_Trend_2D p_value_2D G_all
end

%% 计算集合平均下的基尼系数线性趋势

clear;clc;

filename2 = 'Three_Model_ensemble_average_025_scale_Gini_CN_1985_2014.mat';
load(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\5-1-His-pr-025-scale-Gini\asemble\',filename2])

% 这里只是将前两维展开为1维，这样第三维还是表征的基尼系数
G_all_2D = reshape(Model_GI_ensemble_average_year,[],size(Model_GI_ensemble_average_year,3));
G_Linear_Trend_2D = nan(size(G_all_2D,1),1);
p_value_2D = nan(size(G_all_2D,1),1);
time_2D = 1985:1:2014;
for m = 1 : size(G_all_2D,1)
    [G_Linear_Trend_2D(m,1),~,p_value_2D(m,1),~] = Line_Trend_time_1D(G_all_2D(m,:)',time_2D);
end
G_Linear_Trend = reshape(G_Linear_Trend_2D,[size(Model_GI_ensemble_average_year,1),size(Model_GI_ensemble_average_year,2)]);
p_value = reshape(p_value_2D,[size(Model_GI_ensemble_average_year,1),size(Model_GI_ensemble_average_year,2)]);

clear filename2
filename2 = 'Three_Model_ensemble_average_025_scale_Gini_LinearTrend_CN_1985_2014.mat';
save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\5-1-His-pr-025-scale-Gini\asemble\',filename2],'G_Linear_Trend','p_value','xx_025','yy_025')
