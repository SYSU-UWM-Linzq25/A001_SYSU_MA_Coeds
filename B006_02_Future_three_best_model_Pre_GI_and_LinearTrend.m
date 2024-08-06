%% 这个文件计算三个最优模式中原始分辨率下的基尼系数情况
%% 与后续升尺度后(降尺度)的结果对比从而说明结果可信度

% 2031-2060
clear;clc;
path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')
model_name = {'MPI-ESM1-2-HR','NorESM2-MM','MIROC6'};
SSP_type = {'ssp126','ssp245','ssp370','ssp585'};

% 非升尺度的
save_peth_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\3-process-cell-data\';
cd(save_peth_1)

for i = 1 : length(model_name) % 选择模式读取数据
    for j = 1 : length(SSP_type)
        filename_1 = [model_name{i},'_',SSP_type{j},'_CN_2031_2060.mat'];
        load(filename_1)
        clear filename_1
        Model_pre_G_2031_2060 = cell(2060-2031+1,1);
        for year = 2031:2060
            % 当年降水
            Model_Pre_year = CMIP6_model_Pr_Tas_2031_2060{year-2030,1};
            % 预处理
            Model_Pre_year(Model_Pre_year < 2.4) = 0;
            % 这里只是将前两维展开为1维，这样第三维还是表征一年的降水序列
            Model_Pre_year_2D = reshape(Model_Pre_year,[],size(Model_Pre_year,3));
            % 计算基尼系数
            % 按照行计算
            G_1D = ginicoeff(Model_Pre_year_2D,2,true);
            % 重新转换成二维
            Model_pre_G_2031_2060{year-2030,1} = reshape(G_1D,[size(Model_Pre_year,1),size(Model_Pre_year,2)]);
            clear Model_Pre_year Model_Pre_year_2D G_1D
        end
        filename2 = [model_name{i},'_',SSP_type{j},'_Gini_CN_2031_2060.mat'];
        save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\7-1-future-Gini-origin-scale\',filename2],'Model_pre_G_2031_2060','Lon_CN','Lat_CN')
        disp([model_name{i},'_',SSP_type{j},' is complete!'])
        clear Model_pre_G_2031_2060 xx_025 yy_025 filename2 filename_1 CMIP6_model_Pr_Tas_2031_2060
    end
end

%% 2070-2099
clear;clc;
path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')
model_name = {'MPI-ESM1-2-HR','NorESM2-MM','MIROC6'};
SSP_type = {'ssp126','ssp245','ssp370','ssp585'};

% 非升尺度的
save_peth_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\3-process-cell-data\';
cd(save_peth_1)

for i = 1 : length(model_name) % 选择模式读取数据
    for j = 1 : length(SSP_type)
        filename_1 = [model_name{i},'_',SSP_type{j},'_CN_2070_2099.mat'];
        load(filename_1)
        clear filename_1
        Model_pre_G_2070_2099 = cell(2099-2070+1,1);
        for year = 2070:2099
            % 当年降水
            Model_Pre_year = CMIP6_model_Pr_Tas_2070_2099{year-2069,1};
            % 预处理
            Model_Pre_year(Model_Pre_year < 2.4) = 0;
            % 这里只是将前两维展开为1维，这样第三维还是表征一年的降水序列
            Model_Pre_year_2D = reshape(Model_Pre_year,[],size(Model_Pre_year,3));
            % 计算基尼系数
            % 按照行计算
            G_1D = ginicoeff(Model_Pre_year_2D,2,true);
            % 重新转换成二维
            Model_pre_G_2070_2099{year-2069,1} = reshape(G_1D,[size(Model_Pre_year,1),size(Model_Pre_year,2)]);
            clear Model_Pre_year Model_Pre_year_2D G_1D
        end
        filename2 = [model_name{i},'_',SSP_type{j},'_Gini_CN_2070_2099.mat'];
        save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\7-1-future-Gini-origin-scale\',filename2],'Model_pre_G_2070_2099','Lon_CN','Lat_CN')
        disp([model_name{i},'_',SSP_type{j},' is complete!'])
        clear Model_pre_G_2070_2099 xx_025 yy_025 filename2 filename_1 CMIP6_model_Pr_Tas_2070_2099
    end
end

%% 计算对应的线性趋势

% 2031-2060
clear;clc;

path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')
model_name = {'MPI-ESM1-2-HR','NorESM2-MM','MIROC6'};
SSP_type = {'ssp126','ssp245','ssp370','ssp585'};

for i = 1 : length(model_name) % 选择模式读取数据
    for j = 1 : length(SSP_type)
        save_peth_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\7-1-future-Gini-origin-scale\';
        cd(save_peth_1)
        filename_1 = [model_name{i},'_',SSP_type{j},'_Gini_CN_2031_2060.mat'];
        load(filename_1)
        G_all = nan(length(Lon_CN),length(Lat_CN),2060-2031+1);
        
        for m = 1 : length(Model_pre_G_2031_2060)
            G_all(:,:,m) = Model_pre_G_2031_2060{m,1};
        end
        % 这里只是将前两维展开为1维，这样第三维还是表征的基尼系数
        G_all_2D = reshape(G_all,[],size(G_all,3));
        G_Linear_Trend_2D = nan(size(G_all_2D,1),1);
        p_value_2D = nan(size(G_all_2D,1),1);
        time_2D = 2031:1:2060;
        for m = 1 : size(G_all_2D,1)
            [G_Linear_Trend_2D(m,1),~,p_value_2D(m,1),~] = Line_Trend_time_1D(G_all_2D(m,:)',time_2D);
        end
        
        G_Linear_Trend = reshape(G_Linear_Trend_2D,[size(G_all,1),size(G_all,2)]);
        p_value = reshape(p_value_2D,[size(G_all,1),size(G_all,2)]);
        filename2 = [model_name{i},'_',SSP_type{j},'_Gini_Linear_Trend_CN_2031_2060.mat'];
        save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\8-1-future-Gini-LinearTrend-origin-scale\',filename2],'G_Linear_Trend','p_value','Lon_CN','Lat_CN')
        disp([model_name{i},'_',SSP_type{j},' is complete!'])
        clear G_Linear_Trend p_value Lon_CN Lat_CN filename2 filename_1 G_Linear_Trend_2D p_value_2D G_all
    end
end

% 2070-2099
clear;clc;

path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')
model_name = {'MPI-ESM1-2-HR','NorESM2-MM','MIROC6'};
SSP_type = {'ssp126','ssp245','ssp370','ssp585'};

for i = 1 : length(model_name) % 选择模式读取数据
    for j = 1 : length(SSP_type)
        save_peth_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\7-1-future-Gini-origin-scale\';
        cd(save_peth_1)
        filename_1 = [model_name{i},'_',SSP_type{j},'_Gini_CN_2070_2099.mat'];
        load(filename_1)
        G_all = nan(length(Lon_CN),length(Lat_CN),2099-2070+1);
        
        for m = 1 : length(Model_pre_G_2070_2099)
            G_all(:,:,m) = Model_pre_G_2070_2099{m,1};
        end
        % 这里只是将前两维展开为1维，这样第三维还是表征的基尼系数
        G_all_2D = reshape(G_all,[],size(G_all,3));
        G_Linear_Trend_2D = nan(size(G_all_2D,1),1);
        p_value_2D = nan(size(G_all_2D,1),1);
        time_2D = 2070:1:2099;
        for m = 1 : size(G_all_2D,1)
            [G_Linear_Trend_2D(m,1),~,p_value_2D(m,1),~] = Line_Trend_time_1D(G_all_2D(m,:)',time_2D);
        end
        
        G_Linear_Trend = reshape(G_Linear_Trend_2D,[size(G_all,1),size(G_all,2)]);
        p_value = reshape(p_value_2D,[size(G_all,1),size(G_all,2)]);
        filename2 = [model_name{i},'_',SSP_type{j},'_Gini_Linear_Trend_CN_2070_2099.mat'];
        save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\8-1-future-Gini-LinearTrend-origin-scale\',filename2],'G_Linear_Trend','p_value','Lon_CN','Lat_CN')
        disp([model_name{i},'_',SSP_type{j},' is complete!'])
        clear G_Linear_Trend p_value Lon_CN Lat_CN filename2 filename_1 G_Linear_Trend_2D p_value_2D G_all
    end
end
