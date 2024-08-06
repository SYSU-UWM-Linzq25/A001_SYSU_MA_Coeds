%% 根据提取出来的历史时期数据以及阈值（以CMIP6历史时期的95分位数），计算三种雨在每一年的频率和平均降水强度及其趋势
%% 补充提取对应的
%% 这里改用了5%和95%的阈值

clear;clc;
path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')
model_name = {'MPI-ESM1-2-HR','NorESM2-MM','MIROC6'};
SSP_type = {'ssp126','ssp245','ssp370','ssp585'};

for i = 1 : length(model_name) % 选择模式读取数据
    for j = 1 : length(SSP_type)
        save_peth_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\10-4-30a-all-pre-R95\all_pre_in_cell_of_pixel\';
        cd(save_peth_1)
        load([model_name{i},'_025_scale_1d_pre_event_thresold_5_95_in_cell.mat'])
        Pre_amount_percentage_pre_event = cell(30,length(pre_event_thresold_all));
        Pre_intervals_pre_event = cell(30,length(pre_event_thresold_all));
        cd('J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\10-4-30a-all-pre-R95\')
        for year = 1985 : 2014
            load([model_name{i},' pre for integrated of pixel in cell in ',num2str(year),'.mat'])
            Pre_amount_percentage_pre_event(year-1984,:) = cell_pre_event_amount_percentage_extract(pre_1d_preprocessing01_year_line_2D,pre_event_thresold_all);
            Pre_intervals_pre_event(year-1984,:) = cell_pre_event_intervals_extract(pre_1d_preprocessing01_year_line_2D,pre_event_thresold_all);
            disp([num2str(year),' is done'])
        end
        filename = [model_name{i},'_',SSP_type{j},'_1985_2014_Pre_intervals_of_pre_event_thresold_5_95_in_cell.mat'];
        save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\10-4-30a-all-pre-R95\pre_amount_percentage_and_pre_intervals\',filename], 'Pre_intervals_pre_event')
        filename2 = [model_name{i},'_',SSP_type{j},'_1985_2014_Pre_amount_percentage_of_pre_event_thresold_5_95_in_cell.mat'];
        save(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\10-4-30a-all-pre-R95\pre_amount_percentage_and_pre_intervals\',filename2], 'Pre_amount_percentage_pre_event')
        disp([model_name{i},'_',SSP_type{j},' is done'])
    end
end



