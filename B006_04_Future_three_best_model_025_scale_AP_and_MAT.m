%% 这个文件计算升尺度后的三个模型的年降水量和年均温情况
%% 计算多年平均降水量和多年平均温度
%% 并同时计算集合平均结果

clear;clc
path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')
model_name = {'MPI-ESM1-2-HR','NorESM2-MM','MIROC6'};
SSP_type = {'ssp126','ssp245','ssp370','ssp585'};
Data_type = {'Pr','Tas'};

save_peth_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\5-2-future-pr-and-Tas-025-scale-cell-data\';
cd(save_peth_1)

% 2031-2060
for i = 3 %: length(model_name) % 选择模式读取数据
    for j = 1 : length(SSP_type)
        for m = 1 : length(Data_type)
            filename_1 = [model_name{i},'_',SSP_type{j},'_',Data_type{m},'_CN_025_scale_2031_2060.mat'];
            load(filename_1)
            
            if m == 1
                Model_AP_025_scale_2031_2060 = nan(size(xx_025,1),size(xx_025,2),2060-2031+1);
                for year = 2031:2060
                    % 当年日降水三维矩阵
                    Model_Pre_year = CMIP6_model_Pr_025_scale_2031_2060{year-2030,1};
                    % 求年降水量
                    Model_AP_025_scale_2031_2060(:,:,year-2030) = nansum(Model_Pre_year,3);
                    clear Model_Pre_year
                end
                clear CMIP6_model_Pr_025_scale_2031_2060 filename2
                filename2 = [model_name{i},'_',SSP_type{j},'_',Data_type{m},'_025_scale_CN_2031_2060.mat'];
                save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\6-1-future-025-scale-MAT-AP\',filename2],'Model_AP_025_scale_2031_2060','xx_025','yy_025')
                clear Model_AP_025_scale_2031_2060
            else
                Model_MAT_025_scale_2031_2060 = nan(size(xx_025,1),size(xx_025,2),2060-2031+1);
                for year = 2031:2060
                    % 当年温度三维矩阵
                    Model_Tas_year = CMIP6_model_Tas_025_scale_2031_2060{year-2030,2};
                    % 求年降水量
                    Model_MAT_025_scale_2031_2060(:,:,year-2030) = nanmean(Model_Tas_year,3);
                    clear Model_Tas_year
                end
                clear CMIP6_model_Tas_025_scale_2031_2060 filename2
                filename2 = [model_name{i},'_',SSP_type{j},'_',Data_type{m},'_025_scale_CN_2031_2060.mat'];
                save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\6-1-future-025-scale-MAT-AP\',filename2],'Model_MAT_025_scale_2031_2060','xx_025','yy_025')
                clear Model_MAT_025_scale_2031_2060
            end
            disp([model_name{i},'_',SSP_type{j},'_',Data_type{m},' is complete!'])
        end
    end
end

%% 2070-2099
clear;clc
path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')
model_name = {'MPI-ESM1-2-HR','NorESM2-MM','MIROC6'};
SSP_type = {'ssp126','ssp245','ssp370','ssp585'};
Data_type = {'Pr','Tas'};

save_peth_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\5-2-future-pr-and-Tas-025-scale-cell-data\';
cd(save_peth_1)

% 2031-2060
for i = 3 %: length(model_name) % 选择模式读取数据
    for j = 1 : length(SSP_type)
        for m = 1 : length(Data_type)
            filename_1 = [model_name{i},'_',SSP_type{j},'_',Data_type{m},'_CN_025_scale_2070_2099.mat'];
            load(filename_1)
            
            if m == 1
                Model_AP_025_scale_2070_2099 = nan(size(xx_025,1),size(xx_025,2),2099-2070+1);
                for year = 2070:2099
                    % 当年日降水三维矩阵
                    Model_Pre_year = CMIP6_model_Pr_025_scale_2070_2099{year-2069,1};
                    % 求年降水量
                    Model_AP_025_scale_2070_2099(:,:,year-2069) = nansum(Model_Pre_year,3);
                    clear Model_Pre_year
                end
                clear CMIP6_model_Pr_025_scale_2070_2099 filename2
                filename2 = [model_name{i},'_',SSP_type{j},'_',Data_type{m},'_025_scale_CN_2070_2099.mat'];
                save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\6-1-future-025-scale-MAT-AP\',filename2],'Model_AP_025_scale_2070_2099','xx_025','yy_025')
                clear Model_AP_025_scale_2070_2099
            else
                Model_MAT_025_scale_2070_2099 = nan(size(xx_025,1),size(xx_025,2),2099-2070+1);
                for year = 2070:2099
                    % 当年温度三维矩阵
                    Model_Tas_year = CMIP6_model_Tas_025_scale_2070_2099{year-2069,2};
                    % 求年降水量
                    Model_MAT_025_scale_2070_2099(:,:,year-2069) = nanmean(Model_Tas_year,3);
                    clear Model_Tas_year
                end
                clear CMIP6_model_Tas_025_scale_2070_2099 filename2
                filename2 = [model_name{i},'_',SSP_type{j},'_',Data_type{m},'_025_scale_CN_2070_2099.mat'];
                save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\6-1-future-025-scale-MAT-AP\',filename2],'Model_MAT_025_scale_2070_2099','xx_025','yy_025')
                clear Model_MAT_025_scale_2070_2099
            end
            disp([model_name{i},'_',SSP_type{j},'_',Data_type{m},' is complete!'])
        end
    end
end

%% 注意这里的集合平均应该是多年平均结果的集合平均
%% CMIP6是一个气候模型，在未来时期的一年结果是没有意义的，应该考虑的是气候态的情况
%% 计算多年平均的MAT和AP集合平均的结果
%% 多年平均MAT
% 2031-2060

clear;clc;
path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')
model_name = {'MPI-ESM1-2-HR','NorESM2-MM','MIROC6'};
SSP_type = {'ssp126','ssp245','ssp370','ssp585'};

save_peth_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\6-1-future-025-scale-MAT-AP\';
cd(save_peth_1)

% 读取经纬度坐标信息
filename_1 = ['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\6-2-future-025-scale-ensemble-climatic-MAT-AP\Geography Inform.mat'];
load(filename_1)

for j = 1 : length(SSP_type)
    % 读取CMIP6三个模型下这种情景计算出来的30年年均温的气候态
    Model_MAT_3_model_multiyear_mean = nan(size(xx_025,1),size(xx_025,2),3);
    for i = 1 : length(model_name) % 选择模式读取数据
        filename_1 = [model_name{i},'_',SSP_type{j},'_Tas_025_scale_CN_2031_2060.mat'];
        load(filename_1)
        Model_MAT_3_model_multiyear_mean(:,:,i) = nanmean(Model_MAT_025_scale_2031_2060,3);
        clear filename_1 Model_MAT_025_scale_2031_2060
    end
    Model_MAT_ensemble_climatic_MAT = nanmean(Model_MAT_3_model_multiyear_mean,3);
    clear Model_MAT_3_model_multiyear_mean
    filename2 = [SSP_type{j},'_3_Model_ensemble_climatic_MAT_025_scale_CN_2031_2060.mat'];
    save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\6-2-future-025-scale-ensemble-climatic-MAT-AP\',filename2],'Model_MAT_ensemble_climatic_MAT','xx_025','yy_025')
    disp([SSP_type{j},' is complete!'])
    clear Model_MAT_ensemble_climatic_MAT
end 

% 2070-2099
clear;clc;
path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')
model_name = {'MPI-ESM1-2-HR','NorESM2-MM','MIROC6'};
SSP_type = {'ssp126','ssp245','ssp370','ssp585'};

save_peth_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\6-1-future-025-scale-MAT-AP\';
cd(save_peth_1)
% 读取经纬度坐标信息
filename_1 = ['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\6-2-future-025-scale-ensemble-climatic-MAT-AP\Geography Inform.mat'];
load(filename_1)

for j = 1 : length(SSP_type)
    % 读取CMIP6三个模型下这种情景计算出来的30年年均温的气候态
    Model_MAT_3_model_multiyear_mean = nan(size(xx_025,1),size(xx_025,2),3);
    for i = 1 : length(model_name) % 选择模式读取数据
        filename_1 = [model_name{i},'_',SSP_type{j},'_Tas_025_scale_CN_2070_2099.mat'];
        load(filename_1)
        Model_MAT_3_model_multiyear_mean(:,:,i) = nanmean(Model_MAT_025_scale_2070_2099,3);
        clear filename_1 Model_MAT_025_scale_2070_2099
    end
    Model_MAT_ensemble_climatic_MAT = nanmean(Model_MAT_3_model_multiyear_mean,3);
    clear Model_MAT_3_model_multiyear_mean
    filename2 = [SSP_type{j},'_3_Model_ensemble_climatic_MAT_025_scale_CN_2070_2099.mat'];
    save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\6-2-future-025-scale-ensemble-climatic-MAT-AP\',filename2],'Model_MAT_ensemble_climatic_MAT','xx_025','yy_025')
    disp([SSP_type{j},' is complete!'])
    clear Model_MAT_ensemble_climatic_MAT
end 


%% 多年平均AP
% 2031-2060

clear;clc;
path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')
model_name = {'MPI-ESM1-2-HR','NorESM2-MM','MIROC6'};
SSP_type = {'ssp126','ssp245','ssp370','ssp585'};

save_peth_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\6-1-future-025-scale-MAT-AP\';
cd(save_peth_1)

% 读取经纬度坐标信息
filename_1 = ['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\6-2-future-025-scale-ensemble-climatic-MAT-AP\Geography Inform.mat'];
load(filename_1)

for j = 1 : length(SSP_type)
    % 读取CMIP6三个模型下这种情景计算出来的30年年均温的气候态
    Model_AP_3_model_multiyear_mean = nan(size(xx_025,1),size(xx_025,2),3);
    for i = 1 : length(model_name) % 选择模式读取数据
        filename_1 = [model_name{i},'_',SSP_type{j},'_Pr_025_scale_CN_2031_2060.mat'];
        load(filename_1)
        Model_AP_3_model_multiyear_mean(:,:,i) = nanmean(Model_AP_025_scale_2031_2060,3);
        clear filename_1 Model_AP_025_scale_2031_2060
    end
    Model_AP_ensemble_climatic_AP = nanmean(Model_AP_3_model_multiyear_mean,3);
    clear Model_AP_3_model_multiyear_mean
    filename2 = [SSP_type{j},'_3_Model_ensemble_climatic_AP_025_scale_CN_2031_2060.mat'];
    save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\6-2-future-025-scale-ensemble-climatic-MAT-AP\',filename2],'Model_AP_ensemble_climatic_AP','xx_025','yy_025')
    disp([SSP_type{j},' is complete!'])
    clear Model_AP_ensemble_climatic_AP
end 

%% 2070-2099
clear;clc;
path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')
model_name = {'MPI-ESM1-2-HR','NorESM2-MM','MIROC6'};
SSP_type = {'ssp126','ssp245','ssp370','ssp585'};

save_peth_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\6-1-future-025-scale-MAT-AP\';
cd(save_peth_1)

% 读取经纬度坐标信息
filename_1 = ['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\6-2-future-025-scale-ensemble-climatic-MAT-AP\Geography Inform.mat'];
load(filename_1)

for j = 1 : length(SSP_type)
    % 读取CMIP6三个模型下这种情景计算出来的30年年均温的气候态
    Model_AP_3_model_multiyear_mean = nan(size(xx_025,1),size(xx_025,2),3);
    for i = 1 : length(model_name) % 选择模式读取数据
        filename_1 = [model_name{i},'_',SSP_type{j},'_Pr_025_scale_CN_2070_2099.mat'];
        load(filename_1)
        Model_AP_3_model_multiyear_mean(:,:,i) = nanmean(Model_AP_025_scale_2070_2099,3);
        clear filename_1 Model_AP_025_scale_2070_2099
    end
    Model_AP_ensemble_climatic_AP = nanmean(Model_AP_3_model_multiyear_mean,3);
    clear Model_AP_3_model_multiyear_mean
    filename2 = [SSP_type{j},'_3_Model_ensemble_climatic_AP_025_scale_CN_2070_2099.mat'];
    save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\6-2-future-025-scale-ensemble-climatic-MAT-AP\',filename2],'Model_AP_ensemble_climatic_AP','xx_025','yy_025')
    disp([SSP_type{j},' is complete!'])
    clear Model_AP_ensemble_climatic_AP
end 


%% 这下面是逐年三个模型的平均，应该是不合理的
% %% MAT
% % 2031-2060
% 
% clear;clc;
% path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')
% model_name = {'MPI-ESM1-2-HR','NorESM2-MM','MIROC6'};
% SSP_type = {'ssp126','ssp245','ssp370','ssp585'};
% 
% save_peth_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\6-1-future-025-scale-MAT-AP\';
% cd(save_peth_1)
% 
% for j = 1 : length(SSP_type)
%     % 读取CMIP6三个模型下这种情景计算出来的30年年均温
%     for i = 1 : length(model_name) % 选择模式读取数据
%         filename_1 = [model_name{i},'_',SSP_type{j},'_Tas_025_scale_CN_2031_2060.mat'];
%         load(filename_1)
%         eval(['Model_MAT_',num2str(i),' = Model_MAT_025_scale_2031_2060;'])
%         clear filename_1 Model_MAT_025_scale_2031_2060
%     end
%     
%     % 计算三个模型的年均温的集合平均
%     Model_MAT_ensemble_average_year = nan(size(Model_MAT_1,1),size(Model_MAT_1,2),size(Model_MAT_1,3));
%     for m = 1 : size(Model_MAT_1,3)
%         Model_MAT_three_model_year = nan(size(Model_MAT_1,1),size(Model_MAT_1,2),3);
%         Model_MAT_three_model_year(:,:,1) = Model_MAT_1(:,:,m);
%         Model_MAT_three_model_year(:,:,2) = Model_MAT_2(:,:,m);
%         Model_MAT_three_model_year(:,:,3) = Model_MAT_3(:,:,m);
%         Model_MAT_ensemble_average_year(:,:,m) = nanmean(Model_MAT_three_model_year,3);
%         clear Model_MAT_three_model_year
%     end
%     filename2 = [SSP_type{j},'_Three_Model_ensemble_average_025_scale_MAT_CN_2031_2060.mat'];
%     save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\6-1-future-025-scale-ensemble-MAT-AP\',filename2],'Model_MAT_ensemble_average_year','xx_025','yy_025')
%     disp([SSP_type{j},' is complete!'])
%     clear Model_MAT_ensemble_average_year Model_MAT_1 Model_MAT_2 Model_MAT_3 xx_025 yy_025
% end 
% 
% % 2070-2099
% 
% clear;clc;
% path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')
% model_name = {'MPI-ESM1-2-HR','NorESM2-MM','BCC-CSM2-MR'};
% SSP_type = {'ssp126','ssp245','ssp370','ssp585'};
% 
% save_peth_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\6-future-025-scale-MAT-AP\';
% cd(save_peth_1)
% 
% for j = 1 : length(SSP_type)
%     % 读取CMIP6三个模型下这种情景计算出来的30年年均温
%     for i = 1 : length(model_name) % 选择模式读取数据
%         filename_1 = [model_name{i},'_',SSP_type{j},'_Tas_025_scale_CN_2070_2099.mat'];
%         load(filename_1)
%         eval(['Model_MAT_',num2str(i),' = Model_MAT_025_scale_2070_2099;'])
%         clear filename_1 Model_MAT_025_scale_2070_2099
%     end
%     
%     % 计算三个模型的年均温的集合平均
%     Model_MAT_ensemble_average_year = nan(size(Model_MAT_1,1),size(Model_MAT_1,2),size(Model_MAT_1,3));
%     for m = 1 : size(Model_MAT_1,3)
%         Model_MAT_three_model_year = nan(size(Model_MAT_1,1),size(Model_MAT_1,2),3);
%         Model_MAT_three_model_year(:,:,1) = Model_MAT_1(:,:,m);
%         Model_MAT_three_model_year(:,:,2) = Model_MAT_2(:,:,m);
%         Model_MAT_three_model_year(:,:,3) = Model_MAT_3(:,:,m);
%         Model_MAT_ensemble_average_year(:,:,m) = nanmean(Model_MAT_three_model_year,3);
%         clear Model_MAT_three_model_year
%     end
%     filename2 = [SSP_type{j},'_Three_Model_ensemble_average_025_scale_MAT_CN_2070_2099.mat'];
%     save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\6-1-future-025-scale-ensemble-MAT-AP\',filename2],'Model_MAT_ensemble_average_year','xx_025','yy_025')
%     disp([SSP_type{j},' is complete!'])
%     clear Model_MAT_ensemble_average_year Model_MAT_1 Model_MAT_2 Model_MAT_3 xx_025 yy_025
% end 
% 
% %% AP
% % 2031-2060
% 
% clear;clc;
% path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')
% model_name = {'MPI-ESM1-2-HR','NorESM2-MM','BCC-CSM2-MR'};
% SSP_type = {'ssp126','ssp245','ssp370','ssp585'};
% 
% save_peth_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\6-future-025-scale-MAT-AP\';
% cd(save_peth_1)
% 
% for j = 1 : length(SSP_type)
%     % 读取CMIP6三个模型下这种情景计算出来的30年年降水量
%     for i = 1 : length(model_name) % 选择模式读取数据
%         filename_1 = [model_name{i},'_',SSP_type{j},'_Pr_025_scale_CN_2031_2060.mat'];
%         load(filename_1)
%         eval(['Model_AP_',num2str(i),' = Model_AP_025_scale_2031_2060;'])
%         clear filename_1 Model_AP_025_scale_2031_2060
%     end
%     
%     % 计算三个模型的年均温的集合平均
%     Model_AP_ensemble_average_year = nan(size(Model_AP_1,1),size(Model_AP_1,2),size(Model_AP_1,3));
%     for m = 1 : size(Model_AP_1,3)
%         Model_AP_three_model_year = nan(size(Model_AP_1,1),size(Model_AP_1,2),3);
%         Model_AP_three_model_year(:,:,1) = Model_AP_1(:,:,m);
%         Model_AP_three_model_year(:,:,2) = Model_AP_2(:,:,m);
%         Model_AP_three_model_year(:,:,3) = Model_AP_3(:,:,m);
%         Model_AP_ensemble_average_year(:,:,m) = nanmean(Model_AP_three_model_year,3);
%         clear Model_AP_three_model_year
%     end
%     filename2 = [SSP_type{j},'_Three_Model_ensemble_average_025_scale_AP_CN_2031_2060.mat'];
%     save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\6-1-future-025-scale-ensemble-MAT-AP\',filename2],'Model_AP_ensemble_average_year','xx_025','yy_025')
%     disp([SSP_type{j},' is complete!'])
%     clear Model_AP_ensemble_average_year Model_AP_1 Model_AP_2 Model_AP_3 xx_025 yy_025
% end 
% 
% % 2070-2099
% 
% clear;clc;
% path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')
% model_name = {'MPI-ESM1-2-HR','NorESM2-MM','BCC-CSM2-MR'};
% SSP_type = {'ssp126','ssp245','ssp370','ssp585'};
% 
% save_peth_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\6-future-025-scale-MAT-AP\';
% cd(save_peth_1)
% 
% for j = 1 : length(SSP_type)
%     % 读取CMIP6三个模型下这种情景计算出来的30年年均温
%     for i = 1 : length(model_name) % 选择模式读取数据
%         filename_1 = [model_name{i},'_',SSP_type{j},'_Pr_025_scale_CN_2070_2099.mat'];
%         load(filename_1)
%         eval(['Model_AP_',num2str(i),' = Model_AP_025_scale_2070_2099;'])
%         clear filename_1 Model_AP_025_scale_2070_2099
%     end
%     
%     % 计算三个模型的年均温的集合平均
%     Model_AP_ensemble_average_year = nan(size(Model_AP_1,1),size(Model_AP_1,2),size(Model_AP_1,3));
%     for m = 1 : size(Model_AP_1,3)
%         Model_AP_three_model_year = nan(size(Model_AP_1,1),size(Model_AP_1,2),3);
%         Model_AP_three_model_year(:,:,1) = Model_AP_1(:,:,m);
%         Model_AP_three_model_year(:,:,2) = Model_AP_2(:,:,m);
%         Model_AP_three_model_year(:,:,3) = Model_AP_3(:,:,m);
%         Model_AP_ensemble_average_year(:,:,m) = nanmean(Model_AP_three_model_year,3);
%         clear Model_AP_three_model_year
%     end
%     filename2 = [SSP_type{j},'_Three_Model_ensemble_average_025_scale_AP_CN_2070_2099.mat'];
%     save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\6-1-future-025-scale-ensemble-MAT-AP\',filename2],'Model_AP_ensemble_average_year','xx_025','yy_025')
%     disp([SSP_type{j},' is complete!'])
%     clear Model_AP_ensemble_average_year Model_AP_1 Model_AP_2 Model_AP_3 xx_025 yy_025
% end 


