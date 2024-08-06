%% 根据提取出来的数据以及阈值，补充三种雨型的总降水量，总降水时段数
%% 这里主要服务与年降水量的影响，主要考虑小雨降水时段数的增加
%% 注意这里的数据直接从4个时间尺度的原始降水数据直接而来，因此单位统一是mm/h

clear;clc;
path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')

load('J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\3h\3h_pre_event_thresold_5_95_in_cell.mat')
Pre_intervals_pre_event = cell(30,length(pre_event_thresold_all));
Pre_amount_pre_event = cell(30,length(pre_event_thresold_all));
cd('J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\3h\')
for year = 1985 : 2014
    load(['pre for integrated of pixel in cell in ',num2str(year),'.mat'])
    Pre_intervals_pre_event(year-1984,:) = cell_pre_event_intervals_extract(pre_3h_preprocessing01_year_line_2D,pre_event_thresold_all);
    Pre_amount_pre_event(year-1984,:) = cell_pre_event_amount_extract(pre_3h_preprocessing01_year_line_2D,pre_event_thresold_all);
    disp([num2str(year), ' is done 3h!']);
    clear pre_3h_preprocessing01_year_line_2D
end
filename = '3h_Pre_intervals_of_pre_event_thresold_5_95_in_cell.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\3h\',filename], 'Pre_intervals_pre_event')
filename2 = '3h_Pre_amount_of_pre_event_thresold_5_95_in_cell.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\3h\',filename2], 'Pre_amount_pre_event')
disp('3h done')

% 6h

clear;clc;
path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')

load('J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\6h-from-Paper2\6h_pre_event_thresold_5_95_in_cell.mat')
Pre_intervals_pre_event = cell(30,length(pre_event_thresold_all));
Pre_amount_pre_event = cell(30,length(pre_event_thresold_all));
cd('J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\6h-from-paper2\')
for year = 1985 : 2014
    load(['pre for integrated of pixel in cell in ',num2str(year),'.mat'])
    Pre_intervals_pre_event(year-1984,:) = cell_pre_event_intervals_extract(pre_6h_preprocessing01_year_line_2D,pre_event_thresold_all);
    Pre_amount_pre_event(year-1984,:) = cell_pre_event_amount_extract(pre_6h_preprocessing01_year_line_2D,pre_event_thresold_all);
    disp([num2str(year), ' is done 6h!']);
end
filename = '6h_Pre_intervals_of_pre_event_thresold_5_95_in_cell.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\6h-from-Paper2\',filename], 'Pre_intervals_pre_event')
filename2 = '6h_Pre_amount_of_pre_event_thresold_5_95_in_cell.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\6h-from-Paper2\',filename2], 'Pre_amount_pre_event')
disp('6h done')

% 12h

clear;clc;
path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')

load('J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\12h-from-Paper2\12h_pre_event_thresold_5_95_in_cell.mat')
Pre_intervals_pre_event = cell(30,length(pre_event_thresold_all));
Pre_amount_pre_event = cell(30,length(pre_event_thresold_all));
cd('J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\12h-from-paper2\')
for year = 1985 : 2014
    load(['pre for integrated of pixel in cell in ',num2str(year),'.mat'])
    Pre_intervals_pre_event(year-1984,:) = cell_pre_event_intervals_extract(pre_12h_preprocessing01_year_line_2D,pre_event_thresold_all);
    Pre_amount_pre_event(year-1984,:) = cell_pre_event_amount_extract(pre_12h_preprocessing01_year_line_2D,pre_event_thresold_all);
    disp([num2str(year), ' is done 12h!']);
end
filename = '12h_Pre_intervals_of_pre_event_thresold_5_95_in_cell.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\12h-from-Paper2\',filename], 'Pre_intervals_pre_event')
filename2 = '12h_Pre_amount_of_pre_event_thresold_5_95_in_cell.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\12h-from-Paper2\',filename2], 'Pre_amount_pre_event')
disp('12h done')


% 1-day

clear;clc;
load('J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\1d-from-Paper2\1d_pre_event_thresold_5_95_in_cell.mat')
Pre_intervals_pre_event = cell(30,length(pre_event_thresold_all));
Pre_amount_pre_event = cell(30,length(pre_event_thresold_all));
cd('J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\1d-from-paper2\')
for year = 1985 : 2014 
    load(['pre for integrated of pixel in cell in ',num2str(year),'.mat'])
    Pre_intervals_pre_event(year-1984,:) = cell_pre_event_intervals_extract(pre_1d_preprocessing01_year_line_2D,pre_event_thresold_all);
    Pre_amount_pre_event(year-1984,:) = cell_pre_event_amount_extract(pre_1d_preprocessing01_year_line_2D,pre_event_thresold_all);
    disp([num2str(year), ' is done 1d!']);
end
filename = '1d_Pre_intervals_of_pre_event_thresold_5_95_in_cell.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\1d-from-Paper2\',filename], 'Pre_intervals_pre_event')
filename2 = '1d_Pre_amount_of_pre_event_thresold_5_95_in_cell.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\1d-from-Paper2\',filename2], 'Pre_amount_pre_event')
disp('1d done')


%% 根据提取出来的降水时段数和降水量计算Sen趋势
%% 降水时段数没有单位，代表多少个时段数
%% 降水量的单位为mm/h
%% 降水量的考虑乘以时段总数将单位转为mm

%% 3-hour
clear;clc;

filename = '3h_Pre_intervals_of_pre_event_thresold_5_95_in_cell.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\3h\',filename])
filename2 = '3h_Pre_amount_of_pre_event_thresold_5_95_in_cell.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\3h\',filename2])

Pre_amount_pre_event_mm = cell(size(Pre_amount_pre_event,1),size(Pre_amount_pre_event,2));
% 将不同雨型降水量的单位转成mm
for i = 1 : size(Pre_amount_pre_event,1)
    for j = 1 : size(Pre_amount_pre_event,2)
        Pre_amount_1 = Pre_amount_pre_event{i,j};
        Pre_amount_pre_event_mm{i,j} = Pre_amount_1 * 3;
        clear Pre_amount_1
    end
end

% 三种雨型的时段数的趋势
[Sen_slope_Pre_intervals,MK_Trend_Z_Pre_intervals] = cell_pre_event_Varibles_Sentrend(Pre_intervals_pre_event,1985:2014);
filename2 = 'SenTrend_Pre_intervals_CMFD_3h_01_scale_thresold_5_95_in_cell.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\3h\SenTrend\',filename2], 'Sen_slope_Pre_intervals','MK_Trend_Z_Pre_intervals')
% 不同雨型降水量的趋势(单位变成mm了)
[Sen_slope_Pre_amount_mm,MK_Trend_Z_Pre_amount_mm] = cell_pre_event_Varibles_Sentrend(Pre_amount_pre_event_mm,1985:2014);
filename2 = 'SenTrend_Pre_amount_CMFD_3h_01_scale_thresold_5_95_in_cell.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\3h\SenTrend\',filename2], 'Sen_slope_Pre_amount_mm','MK_Trend_Z_Pre_amount_mm')
disp('3h done')

% 6-hour
clear;clc;

filename = '6h_Pre_intervals_of_pre_event_thresold_5_95_in_cell.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\6h-from-Paper2\',filename])
filename2 = '6h_Pre_amount_of_pre_event_thresold_5_95_in_cell.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\6h-from-Paper2\',filename2])

Pre_amount_pre_event_mm = cell(size(Pre_amount_pre_event,1),size(Pre_amount_pre_event,2));
% 将不同雨型降水量的单位转成mm
for i = 1 : size(Pre_amount_pre_event,1)
    for j = 1 : size(Pre_amount_pre_event,2)
        Pre_amount_1 = Pre_amount_pre_event{i,j};
        Pre_amount_pre_event_mm{i,j} = Pre_amount_1 * 6;
        clear Pre_amount_1
    end
end

% 三种雨型的时段数趋势
[Sen_slope_Pre_intervals,MK_Trend_Z_Pre_intervals] = cell_pre_event_Varibles_Sentrend(Pre_intervals_pre_event,1985:2014);
filename2 = 'SenTrend_Pre_intervals_CMFD_6h_01_scale_thresold_5_95_in_cell.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\6h-from-Paper2\SenTrend\',filename2], 'Sen_slope_Pre_intervals','MK_Trend_Z_Pre_intervals')
% 不同雨型降水量的趋势
[Sen_slope_Pre_amount_mm,MK_Trend_Z_Pre_amount_mm] = cell_pre_event_Varibles_Sentrend(Pre_amount_pre_event_mm,1985:2014);
filename2 = 'SenTrend_Pre_amount_CMFD_6h_01_scale_thresold_5_95_in_cell.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\6h-from-Paper2\SenTrend\',filename2], 'Sen_slope_Pre_amount_mm','MK_Trend_Z_Pre_amount_mm')
disp('6h done')

% 12-hour
clear;clc;

filename = '12h_Pre_intervals_of_pre_event_thresold_5_95_in_cell.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\12h-from-Paper2\',filename])
filename2 = '12h_Pre_amount_of_pre_event_thresold_5_95_in_cell.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\12h-from-Paper2\',filename2])

Pre_amount_pre_event_mm = cell(size(Pre_amount_pre_event,1),size(Pre_amount_pre_event,2));
% 将不同雨型降水量的单位转成mm
for i = 1 : size(Pre_amount_pre_event,1)
    for j = 1 : size(Pre_amount_pre_event,2)
        Pre_amount_1 = Pre_amount_pre_event{i,j};
        Pre_amount_pre_event_mm{i,j} = Pre_amount_1 * 12;
        clear Pre_amount_1
    end
end

% 三种雨型的时段数趋势
[Sen_slope_Pre_intervals,MK_Trend_Z_Pre_intervals] = cell_pre_event_Varibles_Sentrend(Pre_intervals_pre_event,1985:2014);
filename2 = 'SenTrend_Pre_intervals_CMFD_12h_01_scale_thresold_5_95_in_cell.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\12h-from-Paper2\SenTrend\',filename2], 'Sen_slope_Pre_intervals','MK_Trend_Z_Pre_intervals')
% 不同雨型降水量的趋势
[Sen_slope_Pre_amount_mm,MK_Trend_Z_Pre_amount_mm] = cell_pre_event_Varibles_Sentrend(Pre_amount_pre_event_mm,1985:2014);
filename2 = 'SenTrend_Pre_amount_CMFD_12h_01_scale_thresold_5_95_in_cell.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\12h-from-Paper2\SenTrend\',filename2], 'Sen_slope_Pre_amount_mm','MK_Trend_Z_Pre_amount_mm')
disp('12h done')

% 1-day
clear;clc;

filename = '1d_Pre_intervals_of_pre_event_thresold_5_95_in_cell.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\1d-from-Paper2\',filename])
filename2 = '1d_Pre_amount_of_pre_event_thresold_5_95_in_cell.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\1d-from-Paper2\',filename2])

Pre_amount_pre_event_mm = cell(size(Pre_amount_pre_event,1),size(Pre_amount_pre_event,2));
% 将不同雨型降水量的单位转成mm
for i = 1 : size(Pre_amount_pre_event,1)
    for j = 1 : size(Pre_amount_pre_event,2)
        Pre_amount_1 = Pre_amount_pre_event{i,j};
        Pre_amount_pre_event_mm{i,j} = Pre_amount_1 * 24;
        clear Pre_amount_1
    end
end


% 三种雨型的时段数趋势
[Sen_slope_Pre_intervals,MK_Trend_Z_Pre_intervals] = cell_pre_event_Varibles_Sentrend(Pre_intervals_pre_event,1985:2014);
filename2 = 'SenTrend_Pre_intervals_CMFD_1d_01_scale_thresold_5_95_in_cell.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\1d-from-Paper2\SenTrend\',filename2], 'Sen_slope_Pre_intervals','MK_Trend_Z_Pre_intervals')
% 不同雨型降水量的趋势
[Sen_slope_Pre_amount_mm,MK_Trend_Z_Pre_amount_mm] = cell_pre_event_Varibles_Sentrend(Pre_amount_pre_event_mm,1985:2014);
filename2 = 'SenTrend_Pre_amount_CMFD_3h_01_scale_thresold_5_95_in_cell.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\1d-from-Paper2\SenTrend\',filename2], 'Sen_slope_Pre_amount_mm','MK_Trend_Z_Pre_amount_mm')
disp('1d done')

