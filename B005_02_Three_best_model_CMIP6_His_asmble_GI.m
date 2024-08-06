%% 这个文件根据选择出来的三个最优模式的历史时期基尼系数的集合平均
%% 历史时期为1985-2014
%% 计算集合平均

clear;clc;
path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')
model_name = {'MPI-ESM1-2-HR','NorESM2-MM','MIROC6'};

save_path_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2018-2058\7-5-His-pr-025-scale-Gini\';
cd(save_path_1)

for i = 1 : length(model_name) % 选择模式读取数据
    filename = [model_name{i},'_1d_Gini_025_scale_1975_2014.mat'];
    load(filename)
    clear filename
    % 只保留1985-2014
    Model_His_Gini = Model_His_Gini(:,:,11:end);
    eval(['Model_GI_',num2str(i),' = Model_His_Gini;'])
    clear Model_His_Gini
end

% 计算三个模型的基尼系数的集合平均
Model_GI_ensemble_average_year = nan(size(Model_GI_1));
for m = 1 : size(Model_GI_1,3)
    Model_GI_three_model_year = nan(size(Model_GI_1,1),size(Model_GI_1,2),3);
    Model_GI_three_model_year(:,:,1) = Model_GI_1(:,:,m);
    Model_GI_three_model_year(:,:,2) = Model_GI_2(:,:,m);
    Model_GI_three_model_year(:,:,3) = Model_GI_3(:,:,m);
    Model_GI_ensemble_average_year(:,:,m) = nanmean(Model_GI_three_model_year,3);
    clear Model_GI_three_model_year
end
filename2 = 'Three_Model_ensemble_average_025_scale_Gini_CN_1985_2014.mat';
save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\5-1-His-pr-025-scale-Gini\asemble\',filename2],'Model_GI_ensemble_average_year','xx_025','yy_025')

