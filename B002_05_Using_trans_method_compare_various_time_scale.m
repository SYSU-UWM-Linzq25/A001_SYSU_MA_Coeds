%% 对不同时间尺度基尼系数的比较
%% 将sub-daily的基尼系数变换为日尺度

clear;clc;

% 3h→日尺度的参数
filename2 = '1d_GI_translation_3h_GI_two_situation_paramter.mat';
load(['J:\6-硕士毕业论文\1-Data\Temporal_resolution_translation\',filename2])
bbb_3h = bbb2;
clear bbb2

% 极端集中情况
filename2 = '1d_GI_and_method_base_translation_3h_GI_two_situation.mat';
load(['J:\6-硕士毕业论文\1-Data\Temporal_resolution_translation\',filename2])

clear GI1
GI2_3h = GI2;
GI_a_day_3h = GI_a_day;
clear GI1 GI_a_day

% 6h→日尺度的参数
filename2 = '1d_GI_translation_6h_GI_two_situation_paramter.mat';
load(['J:\6-硕士毕业论文\1-Data\Temporal_resolution_translation\',filename2])
bbb_6h = bbb2;
clear bbb2

% 极端集中情况
filename2 = '1d_GI_and_method_base_translation_6h_GI_two_situation.mat';
load(['J:\6-硕士毕业论文\1-Data\Temporal_resolution_translation\',filename2])

clear GI1
GI2_6h = GI2;
GI_a_day_6h = GI_a_day;
clear GI1 GI_a_day

% 12h→日尺度的参数
filename2 = '1d_GI_translation_12h_GI_two_situation_paramter.mat';
load(['J:\6-硕士毕业论文\1-Data\Temporal_resolution_translation\',filename2])
bbb_12h = bbb2;
clear bbb2

% 极端集中情况
filename2 = '1d_GI_and_method_base_translation_12h_GI_two_situation.mat';
load(['J:\6-硕士毕业论文\1-Data\Temporal_resolution_translation\',filename2])

clear GI1
GI2_12h = GI2;
GI_a_day_12h = GI_a_day;
clear GI1 GI_a_day


%% 读取3h基尼系数
filename2 = 'CMFD_3h_Gini_1979_2018_01mmh.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\3-1-Gini&LinearTrend\',filename2])
% 统一选取年份范围为1985-2014
Gini_CMFD_3h_1985_2014 = Gini_CMFD_3h(:,:,7:end-4);
clear Gini_CMFD_3h

% 转换数据形式
Gini_CMFD_3h_1985_2014_2D = reshape(Gini_CMFD_3h_1985_2014,[],size(Gini_CMFD_3h_1985_2014,3));
Gini_CMFD_3h_1985_2014_2D = Gini_CMFD_3h_1985_2014_2D';
clear Gini_CMFD_3h_1985_2014

% 计算转换的日尺度基尼系数
GI_1d_transform_from_3h = nan(size(Gini_CMFD_3h_1985_2014_2D));
for i = 1 : size(Gini_CMFD_3h_1985_2014_2D,1)
    Gini_CMFD_3h_year = Gini_CMFD_3h_1985_2014_2D(i,:);
    GI2_3h_year = GI2_3h(i,:);
    GI_diff_year = GI2_3h_year - Gini_CMFD_3h_year;
    GI_1d_transform_from_3h(i,:) = (GI_diff_year - bbb_3h(1))/bbb_3h(2);
end
differ_3h = GI_1d_transform_from_3h - GI_a_day_3h;
kkk1 = find(differ_3h<0);
filename2 = '1d_GI_transformed_from_3h_GI.mat';
save(['J:\6-硕士毕业论文\1-Data\Temporal_resolution_translation\',filename2],'GI_1d_transform_from_3h','GI_a_day_3h','differ_3h')

%% 读取6h基尼系数
filename2 = 'Full Gini index 6h.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\0-from-paper2\6h\full Gini\',filename2])
% 统一选取年份范围为1985-2014
Gini_CMFD_6h_1985_2014 = Full_Gini_6h_all(:,:,7:end-4);
clear Full_Gini_6h_all

% 转换数据形式
Gini_CMFD_6h_1985_2014_2D = reshape(Gini_CMFD_6h_1985_2014,[],size(Gini_CMFD_6h_1985_2014,3));
Gini_CMFD_6h_1985_2014_2D = Gini_CMFD_6h_1985_2014_2D';
clear Gini_CMFD_6h_1985_2014

% 计算转换的日尺度基尼系数
GI_1d_transform_from_6h = nan(size(Gini_CMFD_6h_1985_2014_2D));
for i = 1 : size(Gini_CMFD_6h_1985_2014_2D,1)
    Gini_CMFD_6h_year = Gini_CMFD_6h_1985_2014_2D(i,:);
    GI2_6h_year = GI2_6h(i,:);
    GI_diff_year = GI2_6h_year - Gini_CMFD_6h_year;
    GI_1d_transform_from_6h(i,:) = (GI_diff_year - bbb_6h(1))/bbb_6h(2);
end
differ_6h = GI_1d_transform_from_6h - GI_a_day_6h;
kkk2 = find(differ_6h<0);
filename2 = '1d_GI_transformed_from_6h_GI.mat';
save(['J:\6-硕士毕业论文\1-Data\Temporal_resolution_translation\',filename2],'GI_1d_transform_from_6h','GI_a_day_6h','differ_6h')

%% 读取12h基尼系数
clear filename2
filename2 = 'Full Gini index 12h.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\0-from-paper2\12h\full Gini\',filename2])
% 统一选取年份范围为1985-2014
Gini_CMFD_12h_1985_2014 = Full_Gini_12h_all(:,:,7:end-4);
clear Full_Gini_12h_all

% 转换数据形式
Gini_CMFD_12h_1985_2014_2D = reshape(Gini_CMFD_12h_1985_2014,[],size(Gini_CMFD_12h_1985_2014,3));
Gini_CMFD_12h_1985_2014_2D = Gini_CMFD_12h_1985_2014_2D';
clear Gini_CMFD_12h_1985_2014

% 计算转换的日尺度基尼系数
GI_1d_transform_from_12h = nan(size(Gini_CMFD_12h_1985_2014_2D));
for i = 1 : size(Gini_CMFD_12h_1985_2014_2D,1)
    Gini_CMFD_12h_year = Gini_CMFD_12h_1985_2014_2D(i,:);
    GI2_12h_year = GI2_12h(i,:);
    GI_diff_year = GI2_12h_year - Gini_CMFD_12h_year;
    GI_1d_transform_from_12h(i,:) = (GI_diff_year - bbb_12h(1))/bbb_12h(2);
end
differ_12h = GI_1d_transform_from_12h - GI_a_day_12h;
kkk3 = find(differ_12h<0);
filename2 = '1d_GI_transformed_from_12h_GI.mat';
save(['J:\6-硕士毕业论文\1-Data\Temporal_resolution_translation\',filename2],'GI_1d_transform_from_12h','GI_a_day_12h','differ_12h')
