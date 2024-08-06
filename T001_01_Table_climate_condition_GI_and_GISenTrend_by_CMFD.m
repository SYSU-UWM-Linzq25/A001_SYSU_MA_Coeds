%% 这个文件得到统计表，基于CMFD数据，统计四个气候区下的水热条件，降水集中度和其Sen趋势
%% 空间尺度都是0.1°，没有升尺度

clear;clc;

% 读取已经统计好的数据
load('J:\6-硕士毕业论文\1-Data\CMFD\8-1-Dataset-for-Table\His_CMFD_MAT_AP_GI_and_SenTrend_and_Trend_significant_climate_zone_Table_Data.mat')

% 数据的行表征时间尺度，列表征四个气候区，顺序如下所示
% 数据是气候区内的区域平均
Temporal_scale_name = {'3h','6h','12h','1d'};
climate_zone_name = {'HR','TR','AR','TP'};


Table = cell(14,4);

% 首两行是MAT和AP
Table(1,1:4) = num2cell(MAT_01mmh_Areamean);
% 温度保留一位小数
for i = 1 : 4
    aa = Table{1,i};
    Table{1,i} = num2str(roundn(aa,-1),'%4.1f');
    clear aa
end

Table(2,1:4) = num2cell(AP_01mmh_Areamean);
% 年降水量保留整数
for i = 1 : 4
    aa = Table{2,i};
    Table{2,i} = num2str(roundn(aa,0),'%4.0f');
    clear aa
end

% 紧接着是3个时间尺度的基尼系数
Table(3:6,1:4) = num2cell(GI_Areamean);
% 基尼系数保留两位小数
for i = 1 : 4
    for j = 3:6
    aa = Table{j,i};
    Table{j,i} = num2str(roundn(aa,-2),'%4.2f');
    clear aa
    end
end


% 紧接着是3个时间尺度的基尼系数Sen斜率
Table(7:10,1:4) = num2cell(GI_Sen_slope_Areamean);
for i = 1 : 4
    for j = 7:10
    aa = Table{j,i};
    Table{j,i} = sprintf('%e',aa);
    clear aa
    end
end


% 紧接着是3个时间尺度的基尼系数显著趋势占比
Table(11:end,1:4) = num2cell(Percentage_significant_all);
for i = 1 : 4
    for j = 11:14
    aa = Table{j,i};
    Table{j,i} = [num2str(roundn(aa,-2),'%4.2f'),'%'];
    clear aa
    end
end



cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\010-01-Table-CMFD-MAT-AP-GI-and-Trend-1985-2014\')
filename = 'Table-4.1.4.xls';
xlswrite(filename, Table);
