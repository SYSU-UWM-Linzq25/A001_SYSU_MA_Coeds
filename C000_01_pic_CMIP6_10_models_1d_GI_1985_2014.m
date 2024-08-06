%% 根据10个CMIP6模型画历史时期的基尼系数多年平均图
%% 原始尺度和升尺度结果
%% 比较的时间段为1985-2014

%% 原始尺度

clear;clc;

model_name = {'MPI-ESM1-2-HR','IITM-ESM','NorESM2-LM','NorESM2-MM','MIROC6','TaiESM1','MPI-ESM1-2-LR','BCC-CSM2-MR','MRI-ESM2-0','CanESM5'};
save_path_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2018-2058\7-5-His-pr-origin-scale-Gini\';
cd(save_path_1)

for i = 1 : length(model_name) % 选择模式读取数据
    filename = [model_name{i},'_1d_Gini_1975_2014.mat'];
    load(filename)
    clear filename
    
    % 只保留1985-2014
    Model_His_Gini = Model_His_Gini(:,:,11:end);
    eval(['Model_His_Gini_mean_',num2str(i),' = nanmean(Model_His_Gini,3);'])
    clear Model_His_Gini
end

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

clear i 
Var_name = cell(length(model_name),1);
for i = 1 : length(model_name) % 选择模式读取数据
    Var_name{i} = ['Model_His_Gini_mean_',num2str(i)];
end

Var_name2 = {'MPI-ESM1-2-HR-origin-scale-1985-2014','IITM-ESM-origin-scale-1985-2014','NorESM2-LM-origin-scale-1985-2014',...
    'NorESM2-MM-origin-scale-1985-2014','MIROC6-origin-scale-1985-2014','TaiESM1-origin-scale-1985-2014','MPI-ESM1-2-LR-origin-scale-1985-2014',...
    'BCC-CSM2-MR-origin-scale-1985-2014','MRI-ESM2-0-origin-scale-1985-2014','CanESM5-origin-scale-1985-2014'};

clear i
index_2 = 1;
for i = 1 : length(Var_name)
    cd(save_path_1)
    filename = [model_name{i},'_1d_Gini_1975_2014.mat'];
    load(filename)
    clear filename Model_His_Gini   
    
    subplot_name = ['(',char(96+index_2),') ',Var_name2{i}];
    eval(['mask_CN_Gini(Lon_CN,Lat_CN,',Var_name{i},',shp0,shp,shp1,shp2,0.7,1,shp_line_HR,shp_line_TR,shp_line_AR,shp_line_TP,subplot_name)'])
    
    cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\000-00-CMIP6-10-models-His-GI\origin-scale\')
    exportgraphics(gcf,['(',num2str(i),') ',Var_name2{i},'.jpg'])
    index_2 = index_2 + 1;
    clear Lon_CN Lat_CN subplot_name
end
close all

%% 升尺度（实际为降尺度到0.25°）
clear;clc;

model_name = {'MPI-ESM1-2-HR','IITM-ESM','NorESM2-LM','NorESM2-MM','MIROC6','TaiESM1','MPI-ESM1-2-LR','BCC-CSM2-MR','MRI-ESM2-0','CanESM5'};
save_path_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2018-2058\7-5-His-pr-025-scale-Gini\';
cd(save_path_1)

for i = 1 : length(model_name) % 选择模式读取数据
    filename = [model_name{i},'_1d_Gini_025_scale_1975_2014.mat'];
    load(filename)
    clear filename
    
    % 只保留1985-2014
    Model_His_Gini = Model_His_Gini(:,:,11:end);
    eval(['Model_His_Gini_mean_',num2str(i),' = nanmean(Model_His_Gini,3);'])
    clear Model_His_Gini
end

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

clear i 
Var_name = cell(length(model_name),1);
for i = 1 : length(model_name) % 选择模式读取数据
    Var_name{i} = ['Model_His_Gini_mean_',num2str(i)];
end

Var_name2 = {'MPI-ESM1-2-HR-025-scale-1985-2014','IITM-ESM-025-scale-1985-2014','NorESM2-LM-025-scale-1985-2014',...
    'NorESM2-MM-025-scale-1985-2014','MIROC6-025-scale-1985-2014','TaiESM1-025-scale-1985-2014','MPI-ESM1-2-LR-025-scale-1985-2014',...
    'BCC-CSM2-MR-025-scale-1985-2014','MRI-ESM2-0-025-scale-1985-2014','CanESM5-025-scale-1985-2014'};

Lon_CN = xx_025(:,1);
Lat_CN = yy_025(1,:);

clear i
index_2 = 1;
for i = 1 : length(Var_name)

    subplot_name = ['(',char(96+index_2),') ',Var_name2{i}];
    eval(['mask_CN_Gini(Lon_CN,Lat_CN,',Var_name{i},',shp0,shp,shp1,shp2,0.7,1,shp_line_HR,shp_line_TR,shp_line_AR,shp_line_TP,subplot_name)'])
    
    cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\000-00-CMIP6-10-models-His-GI\025-scale\')
    exportgraphics(gcf,['(',num2str(i),') ',Var_name2{i},'.jpg'])
    index_2 = index_2 + 1;
    clear subplot_name
end
close all