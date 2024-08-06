%% 这个文件计算三个最优模式中原始分辨率下的基尼系数的Sen斜率
%% 与后续升尺度后(降尺度)的结果对比从而说明结果可信度
%% 计算对应的Sen趋势

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
        
        Gini_Sen_slope_1d = nan(size(G_all,1),size(G_all,2));
        Gini_MK_1d = nan(size(G_all,1),size(G_all,2));
        % 计算Sen趋势
        for m = 1 : size(G_all,1)
            for n = 1 : size(G_all,2)
                a = reshape(G_all(m,n,:),[1,size(G_all,3)]);
                Gini_Sen_slope_1d(m,n) = Theil_Sen_Regress((1985:2014)',a');
                Gini_MK_1d(m,n) = MK(a');
                clear a
            end
        end

        filename2 = [model_name{i},'_',SSP_type{j},'_Gini_SenTrend_CN_2031_2060.mat'];
        save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\8-3-future-Gini-SenTrend-origin-scale\',filename2],'Gini_Sen_slope_1d','Gini_MK_1d','Lon_CN','Lat_CN')
        disp([model_name{i},'_',SSP_type{j},' is complete!'])
        clear Lon_CN Lat_CN filename2 filename_1 Gini_Sen_slope_1d Gini_MK_1d G_all
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
        
        Gini_Sen_slope_1d = nan(size(G_all,1),size(G_all,2));
        Gini_MK_1d = nan(size(G_all,1),size(G_all,2));
        % 计算Sen趋势
        for m = 1 : size(G_all,1)
            for n = 1 : size(G_all,2)
                a = reshape(G_all(m,n,:),[1,size(G_all,3)]);
                Gini_Sen_slope_1d(m,n) = Theil_Sen_Regress((1985:2014)',a');
                Gini_MK_1d(m,n) = MK(a');
                clear a
            end
        end
        
        filename2 = [model_name{i},'_',SSP_type{j},'_Gini_SenTrend_CN_2070_2099.mat'];
        save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\8-3-future-Gini-SenTrend-origin-scale\',filename2],'Gini_Sen_slope_1d','Gini_MK_1d','Lon_CN','Lat_CN')
        disp([model_name{i},'_',SSP_type{j},' is complete!'])
        clear Lon_CN Lat_CN filename2 filename_1 Gini_Sen_slope_1d Gini_MK_1d G_all
    end
end
