%% 这个文件将两种方法提取出来的阈值进行比较
%% 第一种是R95：逐年降水的95%提取出来的阈值，不同时间尺度的单位不一样：3h(mm/3h);6h(mm/6h);12h(mm/12h);1d(mm/1d)
%% 同时逐年有一个值，总的为3维数据

%% 第二种方法是30a所有的降水时段合在一起提取一个95分位数

% 没很大的必要，因为是30a，全国，你很难表示的清楚

clear;clc;

% 读取第一种方法得到的阈值
clear filename2
filename2 = 'R95p_thresold_3h_pre_rate_prerpocessing01_1985_2014.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\7-2-CMFD-R95p\',filename2])
R95p_thresold_year_3h = R95p_thresold_year;
clear R95p_thresold_year

clear filename2
filename2 = 'R95p_thresold_6h_pre_rate_prerpocessing01_1985_2014.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\7-2-CMFD-R95p\',filename2])
R95p_thresold_year_6h = R95p_thresold_year;
clear R95p_thresold_year

clear filename2
filename2 = 'R95p_thresold_12h_pre_rate_prerpocessing01_1985_2014.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\7-2-CMFD-R95p\',filename2])
R95p_thresold_year_12h = R95p_thresold_year;
clear R95p_thresold_year

clear filename2
filename2 = 'R95p_thresold_1d_pre_rate_prerpocessing01_1985_2014.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\7-2-CMFD-R95p\',filename2])
R95p_thresold_year_1d = R95p_thresold_year;
clear R95p_thresold_year

% 根据年份提取








