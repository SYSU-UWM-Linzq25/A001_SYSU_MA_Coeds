%% 这个文件根据升尺度后的CMFD和CMIP6历史时期数据计算得到的基尼系数
%% 开展对比，比较选出最好的三个CMIP6模型
%% 指标为RMSE

clear;clc;

% 读取CMFD整合到0.25°上的经纬度坐标
filename2 = 'CMFD_1d_Gini_025_scale_01mmh_1979_2018_from_Paper2.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\0-from-paper2\',filename2])
[xx_025,yy_025] = meshgrid(Lon_025,Lat_025);
xx_025 = xx_025';
yy_025 = yy_025';

% 研究时段为1985-2014
Gini_CMFD_1d_025_scale_01mmh_1985_2014 = Gini_CMFD_1d_025_scale_01mmh(:,:,7:end-4);
clear Gini_CMFD_1d_025_scale_01mmh

% 两种数据源的结果组织格式不太一样，计算RMSE需要先转置
Gini_CMFD_1d_025_scale_01mmh_rev = nan(length(Lon_025),length(Lat_025),size(Gini_CMFD_1d_025_scale_01mmh_1985_2014,3));

for year = 1 : size(Gini_CMFD_1d_025_scale_01mmh_1985_2014,3)
    b = Gini_CMFD_1d_025_scale_01mmh_1985_2014(:,:,year); 
    Gini_CMFD_1d_025_scale_01mmh_rev(:,:,year) = b';
    clear  b
end
clear Gini_CMFD_1d_025_scale_01mmh_1985_2014


model_name = {'MPI-ESM1-2-HR','IITM-ESM','NorESM2-LM','NorESM2-MM','MIROC6','TaiESM1','MPI-ESM1-2-LR','BCC-CSM2-MR','MRI-ESM2-0','CanESM5'};
save_path_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2018-2058\7-5-His-pr-025-scale-Gini\';
cd(save_path_1)

% 先循环创建空的RMSE变量
for i = 1 : length(model_name)
    eval(['RMSE_01mmh_025_scale_',num2str(i),' = nan(size(Gini_CMFD_1d_025_scale_01mmh_rev,1),size(Gini_CMFD_1d_025_scale_01mmh_rev,2));'])
end
clear i
for i = 1 : length(model_name) % 选择模式读取数据
    filename = [model_name{i},'_1d_Gini_025_scale_1975_2014.mat'];
    load(filename)
    clear filename
    
    % 只保留1985-2014
    Model_His_Gini = Model_His_Gini(:,:,11:end);
    
    for j = 1 : size(Gini_CMFD_1d_025_scale_01mmh_rev,1)
        for m = 1 : size(Gini_CMFD_1d_025_scale_01mmh_rev,2)
            G_CMFD_1 = Gini_CMFD_1d_025_scale_01mmh_rev(j,m,:);
            G_Model_1 = Model_His_Gini(j,m,:);
            
            k1 = find(isnan(G_CMFD_1));
            k2 = find(isnan(G_Model_1));
            if ~isempty(k1) && ~isempty(k2)
                k3 = unique([k1;k2]);
                G_CMFD_1(k3) = [];
                G_Model_1(k3) = [];
            elseif isempty(k1) && ~isempty(k2)
                G_CMFD_1(k2) = [];
                G_Model_1(k2) = [];
            elseif ~isempty(k1) && isempty(k2)
                G_CMFD_1(k1) = [];
                G_Model_1(k1) = [];
            end
            
            % 计算RMSE
            eval(['RMSE_01mmh_025_scale_',num2str(i),'(j,m) = sqrt(mean((G_Model_1-G_CMFD_1).^2));'])
            
            clear G_CMFD_1 G_Model_1 k1 k2 k3
        end
    end
    clear Model_His_Gini
end
filename2 = 'RMSE_CMFD_and_CMIP6_model_GI_025_scale.mat';
save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2018-2058\',filename2],'RMSE_01mmh_025_scale_1','RMSE_01mmh_025_scale_2','RMSE_01mmh_025_scale_3',...
    'RMSE_01mmh_025_scale_4','RMSE_01mmh_025_scale_5','RMSE_01mmh_025_scale_6','RMSE_01mmh_025_scale_7','RMSE_01mmh_025_scale_8',...
    'RMSE_01mmh_025_scale_9','RMSE_01mmh_025_scale_10')

for i = 1: length(model_name) % 选择模式读取数据
eval(['RMSE_01mmh_025_scale_',num2str(i),'_mean = nanmean(nanmean(RMSE_01mmh_025_scale_',num2str(i),',1));'])
end


