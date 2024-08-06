%% 这个文件对CMFD历史时期和CMIP6-30a中的heavy rain的阈值进行比较
%% 空间尺度归到0.25度
%% 时间尺度为1-day

clear;clc;
% 未来时期，不同情境，两个时段的阈值
model_name = {'MPI-ESM1-2-HR','NorESM2-MM','BCC-CSM2-MR'};
SSP_type = {'ssp126','ssp245','ssp370','ssp585'};
time_period = {'2031_2060','2070_2099'};

filename2 = 'CMFD_1d_Gini_025_scale_01mmh_1979_2018_from_Paper2.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\0-from-paper2\',filename2]);
clear Gini_CMFD_1d_025_scale_01mmh

% 这里直接对模型进行集合平均
for j = 1 : length(SSP_type)
    for m = 1 : length(time_period)
        
        eval(['heavy_pre_thresold_all_',SSP_type{j},'_',time_period{m},'_1 = nan(length(Lon_025),length(Lat_025),length(model_name));'])
        for i = 1 : length(model_name) % 选择模式读取数据
            cd('J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2015-2100\10-1-30a-all-pre-R95\all_pre_in_cell_of_pixel\')
            filename = [model_name{i},'_',SSP_type{j},'_',time_period{m},'_025_scale_1d_pre_event_thresold_5_95_in_cell.mat'];
            load(filename)
            
            heavy_pre_thresold = nan(1,length(pre_event_thresold_all));
            for n = 1 : length(pre_event_thresold_all)
                heavy_pre_thresold(1,n) = pre_event_thresold_all{1,n}(2);
            end
            clear pre_event_thresold_all
            eval(['heavy_pre_thresold_all_',SSP_type{j},'_',time_period{m},'_1(:,:,i) = reshape(heavy_pre_thresold,[length(Lon_025),length(Lat_025)]);'])
            clear heavy_pre_thresold
        end
        eval(['heavy_pre_thresold_all_',SSP_type{j},'_',time_period{m},' = nanmean(heavy_pre_thresold_all_',SSP_type{j},'_',time_period{m},'_1,3);'])
        eval(['clear heavy_pre_thresold_all_',SSP_type{j},'_',time_period{m},'_1'])
    end
end

% CMFD 1d 025 scale
load('J:\6-硕士毕业论文\1-Data\CMFD\7-3-CMFD-30a-all-pre-R95\all_pre_in_cell_of_pixel\1d-from-paper2-025-scale\CMFD_025_scale_1d_pre_event_thresold_5_95_in_cell.mat')
pre_event_thresold_all_CMFD = pre_event_thresold_all;
clear pre_event_thresold_all

heavy_pre_thresold_CMFD = nan(1,length(pre_event_thresold_all_CMFD));
for i = 1 : length(pre_event_thresold_all_CMFD)
    heavy_pre_thresold_CMFD(1,i) = pre_event_thresold_all_CMFD{1,i}(2);
end
clear pre_event_thresold_all_CMFD
% 重新转回二维矩阵
heavy_pre_thresold_all_CMFD = reshape(heavy_pre_thresold_CMFD,[length(Lon_025),length(Lat_025)]);

Thresold_all = nan(length(Lon_025),length(Lat_025),9);
index2 = 1;
for j = 1 : length(SSP_type)
    for m = 1 : length(time_period)
        eval(['Thresold_all(:,:,index2) = heavy_pre_thresold_all_',SSP_type{j},'_',time_period{m},';'])
        index2 = index2 + 1;
    end
end
Thresold_all(:,:,index2) = heavy_pre_thresold_all_CMFD;
a1 = max(max(max(Thresold_all)));
b1 = min(min(min(Thresold_all)));


%% 尝试画图
% 画图
shp0 = shaperead('J:\4-论文备份\论文代码2021.4.14\map\bou1_4p.shp');
shp = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\基于审图号GS(2019)1822号新制作的底图\新国界_无东沙赤尾钓鱼_需和Chinaline连用.shp');
shp1 = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\基于审图号GS(2019)1822号新制作的底图\New_China_line.shp');
shp2 = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\基于审图号GS(2019)1822号新制作的底图\Dongsha_Chiwei_Diaoyu.shp');
% 读取4个气候区的线shp图，叠加在绘图上
shp_line_HR = shaperead('F:\File_of_MATLAB\关于3h尺度的CMFD降水数据研究2022.3.2\New climate seperate method from Du\湿润区\shiRunQu_Line.shp');
shp_line_TR = shaperead('F:\File_of_MATLAB\关于3h尺度的CMFD降水数据研究2022.3.2\New climate seperate method from Du\过渡区\guoDuQu_Line.shp');
shp_line_AR = shaperead('F:\File_of_MATLAB\关于3h尺度的CMFD降水数据研究2022.3.2\New climate seperate method from Du\干旱区\ganHanQu_Line.shp');
shp_line_TP = shaperead('F:\File_of_MATLAB\关于3h尺度的CMFD降水数据研究2022.3.2\New climate seperate method from Du\高寒区\qingZangGaoYuanQu_Line.shp');

path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')
subplot_name = 'CMFD 025 scale heavy rain thresold 1985 2014';
mask_CN_heavy_rain_thresold(Lon_025,Lat_025,heavy_pre_thresold_all_CMFD,shp0,shp,shp1,shp2,0,4,shp_line_HR,shp_line_TR,shp_line_AR,shp_line_TP,subplot_name)
% cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\004-02-CMFD-His-30a-heavy-rain-fre-intensity-LinearTrend-1985-2014\')
% exportgraphics(gcf,[subplot_name,'.jpg'])
