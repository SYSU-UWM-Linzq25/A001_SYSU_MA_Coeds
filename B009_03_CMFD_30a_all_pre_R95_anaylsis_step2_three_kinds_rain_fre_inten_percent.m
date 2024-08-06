%% 根据提取出来的数据以及阈值，计算三种雨在每一年的频率及其趋势
%% 补充提取对应的平均降水强度+不同雨型降水量占全年降水的百分占比
%% 这里改用了5%和95%的阈值 
%% 空间尺度为0.1°
%% 3h

clear;clc;
path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')

load('J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\3h\3h_pre_event_thresold_5_95_in_cell.mat')
% Fre_30a_pre_event = cell(30,length(pre_event_thresold_all));
% Intensity_pre_event = cell(30,length(pre_event_thresold_all));
Pre_amount_percentage_pre_event = cell(30,length(pre_event_thresold_all));
cd('J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\3h\')
for year = 1985 : 2014
    load(['pre for integrated of pixel in cell in ',num2str(year),'.mat'])
    Fre_30a_pre_event(year-1984,:) = cell_pre_event_frenquency_extract(pre_3h_preprocessing01_year_line_2D,pre_event_thresold_all);
    Intensity_pre_event(year-1984,:) = cell_pre_event_intensity_extract(pre_3h_preprocessing01_year_line_2D,pre_event_thresold_all);
    Pre_amount_percentage_pre_event(year-1984,:) = cell_pre_event_amount_percentage_extract(pre_3h_preprocessing01_year_line_2D,pre_event_thresold_all);
    disp([num2str(year), ' is done 3h!']);
    clear pre_3h_preprocessing01_year_line_2D
end
filename = '3h_frenquency_of_pre_event_thresold_5_95_in_cell.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\3h\',filename], 'Fre_30a_pre_event')
filename2 = '3h_Intensity_of_pre_event_thresold_5_95_in_cell.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\3h\',filename2], 'Intensity_pre_event')
filename2 = '3h_Pre_amount_percentage_of_pre_event_thresold_5_95_in_cell.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\3h\',filename2], 'Pre_amount_percentage_pre_event')
disp('3h done')

%% 6h

clear;clc;
path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')

load('J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\6h-from-Paper2\6h_pre_event_thresold_5_95_in_cell.mat')
Fre_30a_pre_event = cell(30,length(pre_event_thresold_all));
Intensity_pre_event = cell(30,length(pre_event_thresold_all));
Pre_amount_percentage_pre_event = cell(30,length(pre_event_thresold_all));
cd('J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\6h-from-paper2\')
for year = 1985 : 2014
    load(['pre for integrated of pixel in cell in ',num2str(year),'.mat'])
    Fre_30a_pre_event(year-1984,:) = cell_pre_event_frenquency_extract(pre_6h_preprocessing01_year_line_2D,pre_event_thresold_all);
    Intensity_pre_event(year-1984,:) = cell_pre_event_intensity_extract(pre_6h_preprocessing01_year_line_2D,pre_event_thresold_all);
    Pre_amount_percentage_pre_event(year-1984,:) = cell_pre_event_amount_percentage_extract(pre_6h_preprocessing01_year_line_2D,pre_event_thresold_all);
    disp([num2str(year), ' is done 6h!']);
end
filename = '6h_frenquency_of_pre_event_thresold_5_95_in_cell.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\6h-from-Paper2\',filename], 'Fre_30a_pre_event')
filename2 = '6h_Intensity_of_pre_event_thresold_5_95_in_cell.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\6h-from-Paper2\',filename2], 'Intensity_pre_event')
filename2 = '6h_Pre_amount_percentage_of_pre_event_thresold_5_95_in_cell.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\6h-from-Paper2\',filename2], 'Pre_amount_percentage_pre_event')
disp('6h done')

% 12h

clear;clc;
path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')

load('J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\12h-from-Paper2\12h_pre_event_thresold_5_95_in_cell.mat')
Fre_30a_pre_event = cell(30,length(pre_event_thresold_all));
Intensity_pre_event = cell(30,length(pre_event_thresold_all));
Pre_amount_percentage_pre_event = cell(30,length(pre_event_thresold_all));
cd('J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\12h-from-paper2\')
for year = 1985 : 2014
    load(['pre for integrated of pixel in cell in ',num2str(year),'.mat'])
    Fre_30a_pre_event(year-1984,:) = cell_pre_event_frenquency_extract(pre_12h_preprocessing01_year_line_2D,pre_event_thresold_all);
    Intensity_pre_event(year-1984,:) = cell_pre_event_intensity_extract(pre_12h_preprocessing01_year_line_2D,pre_event_thresold_all);
    Pre_amount_percentage_pre_event(year-1984,:) = cell_pre_event_amount_percentage_extract(pre_12h_preprocessing01_year_line_2D,pre_event_thresold_all);
    disp([num2str(year), ' is done 12h!']);
end
filename = '12h_frenquency_of_pre_event_thresold_5_95_in_cell.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\12h-from-Paper2\',filename], 'Fre_30a_pre_event')
filename2 = '12h_Intensity_of_pre_event_thresold_5_95_in_cell.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\12h-from-Paper2\',filename2], 'Intensity_pre_event')
filename2 = '12h_Pre_amount_percentage_of_pre_event_thresold_5_95_in_cell.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\12h-from-Paper2\',filename2], 'Pre_amount_percentage_pre_event')
disp('12h done')


%% 1-day

clear;clc;
load('J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\1d-from-Paper2\1d_pre_event_thresold_5_95_in_cell.mat')
Fre_30a_pre_event = cell(30,length(pre_event_thresold_all));
Intensity_pre_event = cell(30,length(pre_event_thresold_all));
Pre_amount_percentage_pre_event = cell(30,length(pre_event_thresold_all));
cd('J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\1d-from-paper2\')
for year = 1985 : 2014 
    load(['pre for integrated of pixel in cell in ',num2str(year),'.mat'])
    Fre_30a_pre_event(year-1984,:) = cell_pre_event_frenquency_extract(pre_1d_preprocessing01_year_line_2D,pre_event_thresold_all);
    Intensity_pre_event(year-1984,:) = cell_pre_event_intensity_extract(pre_1d_preprocessing01_year_line_2D,pre_event_thresold_all);
    Pre_amount_percentage_pre_event(year-1984,:) = cell_pre_event_amount_percentage_extract(pre_1d_preprocessing01_year_line_2D,pre_event_thresold_all);
    disp([num2str(year), ' is done 1d!']);
end
filename = '1d_frenquency_of_pre_event_thresold_5_95_in_cell.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\1d-from-Paper2\',filename], 'Fre_30a_pre_event')
filename2 = '1d_Intensity_of_pre_event_thresold_5_95_in_cell.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\1d-from-Paper2\',filename2], 'Intensity_pre_event')
disp('1d done')
filename2 = '1d_Pre_amount_percentage_of_pre_event_thresold_5_95_in_cell.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\1d-from-Paper2\',filename2], 'Pre_amount_percentage_pre_event')
disp('1d done')


%% 根据提取出来的频率和平均降水强度计算Sen趋势
%% 频率和降水量占比的单位均是%
%% 不同雨型的平均降水强度单位为mm/h

%% 3-hour
clear;clc;

filename = '3h_frenquency_of_pre_event_thresold_5_95_in_cell.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\3h\',filename])
filename2 = '3h_Intensity_of_pre_event_thresold_5_95_in_cell.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\3h\',filename2])
filename2 = '3h_Pre_amount_percentage_of_pre_event_thresold_5_95_in_cell.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\3h\',filename2])

% 三种雨型的频率趋势
[Sen_slope_fre,MK_Trend_Z_fre] = cell_pre_event_Varibles_Sentrend(Fre_30a_pre_event,1985:2014);
filename2 = 'SenTrend_fre_CMFD_3h_01_scale_thresold_5_95_in_cell.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\3h\SenTrend\',filename2], 'Sen_slope_fre','MK_Trend_Z_fre')
% 降水强度的趋势
[Sen_slope_intensity,MK_Trend_Z_intensity] = cell_pre_event_Varibles_Sentrend(Intensity_pre_event,1985:2014);
filename2 = 'SenTrend_intensity_CMFD_3h_01_scale_thresold_5_95_in_cell.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\3h\SenTrend\',filename2], 'Sen_slope_intensity','MK_Trend_Z_intensity')
% 不同雨型降水量占比的趋势
[Sen_slope_percentage,MK_Trend_Z_percentage] = cell_pre_event_Varibles_Sentrend(Pre_amount_percentage_pre_event,1985:2014);
filename2 = 'SenTrend_percentage_CMFD_3h_01_scale_thresold_5_95_in_cell.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\3h\SenTrend\',filename2], 'Sen_slope_percentage','MK_Trend_Z_percentage')
disp('3h done')

% 6-hour
clear;clc;

filename = '6h_frenquency_of_pre_event_thresold_5_95_in_cell.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\6h-from-Paper2\',filename])
filename2 = '6h_Intensity_of_pre_event_thresold_5_95_in_cell.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\6h-from-Paper2\',filename2])
filename2 = '6h_Pre_amount_percentage_of_pre_event_thresold_5_95_in_cell.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\6h-from-Paper2\',filename2])

% 三种雨型的频率趋势
[Sen_slope_fre,MK_Trend_Z_fre] = cell_pre_event_Varibles_Sentrend(Fre_30a_pre_event,1985:2014);
filename2 = 'SenTrend_fre_CMFD_6h_01_scale_thresold_5_95_in_cell.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\6h-from-Paper2\SenTrend\',filename2], 'Sen_slope_fre','MK_Trend_Z_fre')
% 降水强度的趋势
[Sen_slope_intensity,MK_Trend_Z_intensity] = cell_pre_event_Varibles_Sentrend(Intensity_pre_event,1985:2014);
filename2 = 'SenTrend_intensity_CMFD_6h_01_scale_thresold_5_95_in_cell.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\6h-from-Paper2\SenTrend\',filename2], 'Sen_slope_intensity','MK_Trend_Z_intensity')
% 不同雨型降水量占比的趋势
[Sen_slope_percentage,MK_Trend_Z_percentage] = cell_pre_event_Varibles_Sentrend(Pre_amount_percentage_pre_event,1985:2014);
filename2 = 'SenTrend_percentage_CMFD_6h_01_scale_thresold_5_95_in_cell.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\6h-from-Paper2\SenTrend\',filename2], 'Sen_slope_percentage','MK_Trend_Z_percentage')
disp('6h done')

% 12-hour
clear;clc;

filename = '12h_frenquency_of_pre_event_thresold_5_95_in_cell.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\12h-from-Paper2\',filename])
filename2 = '12h_Intensity_of_pre_event_thresold_5_95_in_cell.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\12h-from-Paper2\',filename2])
filename2 = '12h_Pre_amount_percentage_of_pre_event_thresold_5_95_in_cell.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\12h-from-Paper2\',filename2])

% 三种雨型的频率趋势
[Sen_slope_fre,MK_Trend_Z_fre] = cell_pre_event_Varibles_Sentrend(Fre_30a_pre_event,1985:2014);
filename2 = 'SenTrend_fre_CMFD_12h_01_scale_thresold_5_95_in_cell.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\12h-from-Paper2\SenTrend\',filename2], 'Sen_slope_fre','MK_Trend_Z_fre')
% 降水强度的趋势
[Sen_slope_intensity,MK_Trend_Z_intensity] = cell_pre_event_Varibles_Sentrend(Intensity_pre_event,1985:2014);
filename2 = 'SenTrend_intensity_CMFD_12h_01_scale_thresold_5_95_in_cell.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\12h-from-Paper2\SenTrend\',filename2], 'Sen_slope_intensity','MK_Trend_Z_intensity')
% 不同雨型降水量占比的趋势
[Sen_slope_percentage,MK_Trend_Z_percentage] = cell_pre_event_Varibles_Sentrend(Pre_amount_percentage_pre_event,1985:2014);
filename2 = 'SenTrend_percentage_CMFD_12h_01_scale_thresold_5_95_in_cell.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\12h-from-Paper2\SenTrend\',filename2], 'Sen_slope_percentage','MK_Trend_Z_percentage')
disp('12h done')

% 1-day
clear;clc;

filename = '1d_frenquency_of_pre_event_thresold_5_95_in_cell.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\1d-from-Paper2\',filename])
filename2 = '1d_Intensity_of_pre_event_thresold_5_95_in_cell.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\1d-from-Paper2\',filename2])
filename2 = '1d_Pre_amount_percentage_of_pre_event_thresold_5_95_in_cell.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\1d-from-Paper2\',filename2])

% 三种雨型的频率趋势
[Sen_slope_fre,MK_Trend_Z_fre] = cell_pre_event_Varibles_Sentrend(Fre_30a_pre_event,1985:2014);
filename2 = 'SenTrend_fre_CMFD_1d_01_scale_thresold_5_95_in_cell.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\1d-from-Paper2\SenTrend\',filename2], 'Sen_slope_fre','MK_Trend_Z_fre')
% 降水强度的趋势
[Sen_slope_intensity,MK_Trend_Z_intensity] = cell_pre_event_Varibles_Sentrend(Intensity_pre_event,1985:2014);
filename2 = 'SenTrend_intensity_CMFD_1d_01_scale_thresold_5_95_in_cell.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\1d-from-Paper2\SenTrend\',filename2], 'Sen_slope_intensity','MK_Trend_Z_intensity')
% 不同雨型降水量占比的趋势
[Sen_slope_percentage,MK_Trend_Z_percentage] = cell_pre_event_Varibles_Sentrend(Pre_amount_percentage_pre_event,1985:2014);
filename2 = 'SenTrend_percentage_CMFD_1d_01_scale_thresold_5_95_in_cell.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\1d-from-Paper2\SenTrend\',filename2], 'Sen_slope_percentage','MK_Trend_Z_percentage')
disp('1d done')

