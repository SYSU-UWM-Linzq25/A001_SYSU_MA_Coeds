%% 这个文件根据新下载的MSWEP数据，时间分辨率为3h，空间分辨率变成了和CMFD的相同
%% 从1979-2018年的结果中截取1985-2014年
%% 对数据进行处理，计算基尼系数的多年平均和线性趋势，再温度与之的相关系数

clear;clc;
cd('J:\6-硕士毕业论文\1-Data\MSWEP_Data_1979_2020\2-Gini-and-LinearTrend\')

% 6h 
load('MSWEP_6h_GI_CN_1979_2018.mat')

Gini_MSWEP_6h_1985_2014 = Gini_MSWEP_6h(:,:,7:end-4);
clear Gini_MSWEP_6h
filename2 = 'MSWEP_6h_GI_CN_1985_2014.mat';
save(['J:\6-硕士毕业论文\1-Data\MSWEP_Data_1979_2020\2-Gini-and-LinearTrend\1985-2014\',filename2],'Gini_MSWEP_6h_1985_2014','Lon','Lat');

% 3h
load('MSWEP_GI_CN_1979_2018.mat')
Gini_MSWEP_3h_1985_2014 = Gini_MSWEP(:,:,7:end-4);
clear Gini_MSWEP
filename2 = 'MSWEP_3h_GI_CN_1985_2014.mat';
save(['J:\6-硕士毕业论文\1-Data\MSWEP_Data_1979_2020\2-Gini-and-LinearTrend\1985-2014\',filename2],'Gini_MSWEP_3h_1985_2014','Lon','Lat');


% 12h
load('MSWEP_12h_GI_CN_1979_2018.mat')
Gini_MSWEP_12h_1985_2014 = Gini_MSWEP_12h(:,:,7:end-4);
clear Gini_MSWEP_12h
filename2 = 'MSWEP_12h_GI_CN_1985_2014.mat';
save(['J:\6-硕士毕业论文\1-Data\MSWEP_Data_1979_2020\2-Gini-and-LinearTrend\1985-2014\',filename2],'Gini_MSWEP_12h_1985_2014','Lon','Lat');

% 12h
load('MSWEP_1d_GI_CN_1979_2018.mat')
Gini_MSWEP_1d_1985_2014 = Gini_MSWEP_1d(:,:,7:end-4);
clear Gini_MSWEP_1d
filename2 = 'MSWEP_1d_GI_CN_1985_2014.mat';
save(['J:\6-硕士毕业论文\1-Data\MSWEP_Data_1979_2020\2-Gini-and-LinearTrend\1985-2014\',filename2],'Gini_MSWEP_1d_1985_2014','Lon','Lat');







% %%
% 
% clear;clc;
% path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')
% 
% filename = ['MSWEP_Pre_China_in_',num2str(1979),'.mat'];
% load(['J:\6-硕士毕业论文\1-Data\MSWEP_Data_1979_2020\1-origin-data-CN\',filename]);
% clear Pre_China_year
% 
% Gini_3h_MSWEP_1985_2014 = nan(length(Lon),length(Lat),2014-1985+1);
% for year = 1985 : 2014
%     filename = ['MSWEP_Pre_China_in_',num2str(year),'.mat'];
%     load(['J:\6-硕士毕业论文\1-Data\MSWEP_Data_1979_2020\1-origin-data-CN\',filename]);
%     
%     % 降水阈值处理，0.1mm/h
%     Pre_China_year(Pre_China_year < 0.3) = 0;
%     
%     % 将降水转为二维，从而使用ginicoeff计算
%     Pre_China_year_2D = reshape(Pre_China_year,[],size(Pre_China_year,3));
%     clear Pre_China_year
%     
%     Pre_China_year_2D_1 = Pre_China_year_2D(1:70000,:);
%     G_1D_1 = ginicoeff(Pre_China_year_2D_1,2,true);
%     clear Pre_China_year_2D_1
%     
%     Pre_China_year_2D_2 = Pre_China_year_2D(70001:140000,:);
%     G_1D_2 = ginicoeff(Pre_China_year_2D_2,2,true);
%     clear Pre_China_year_2D_2
%         
%     Pre_China_year_2D_3 = Pre_China_year_2D(140001:210000,:);
%     G_1D_3 = ginicoeff(Pre_China_year_2D_3,2,true);
%     clear Pre_China_year_2D_3
%         
%     Pre_China_year_2D_4 = Pre_China_year_2D(210001:end,:);
%     clear Pre_China_year_2D
%     G_1D_4 = ginicoeff(Pre_China_year_2D_4,2,true);
%     clear Pre_China_year_2D_4
%     
%     % 基尼系数计算
%     % 按照行计算
%     G_1D = [G_1D_1;G_1D_2;G_1D_3;G_1D_4];
%     clear G_1D_1 G_1D_2 G_1D_3 G_1D_4
%     
%     % 基尼系数计算
%     Gini_3h_MSWEP_1985_2014(:,:,year-1984) = reshape(G_1D,[length(Lon),length(Lat)]);
%     disp([num2str(year),' is done!'])    
%     clear G_1D filename
% end
% 
% filename2 = 'MSWEP_3h_GI_CN_1985_2014.mat';
% save(['J:\6-硕士毕业论文\1-Data\MSWEP_Data_1979_2020\2-Gini-and-LinearTrend\1985-2014\',filename2],'Gini_3h_MSWEP_1985_2014','Lon','Lat');
% 
% %% 6-hour
% %% 已经预处理过了
% clear;clc;
% path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')
% 
% filename = ['MSWEP_Pre_China_in_',num2str(1979),'.mat'];
% load(['J:\6-硕士毕业论文\1-Data\MSWEP_Data_1979_2020\1-origin-data-CN\',filename]);
% clear Pre_China_year
% 
% Gini_6h_MSWEP_1985_2014 = nan(length(Lon),length(Lat),2014-1985+1);
% for year = 1985 : 2014
%     filename = ['pre2(6h)_',num2str(year),'.mat'];
%     load(['J:\6-硕士毕业论文\1-Data\MSWEP_Data_1979_2020\1-1-different-time-scale\6-hour\',filename]);
%     
%     Pre_China_year = Pre_6h_preprocessing01_year;
%     clear Pre_6h_preprocessing01_year
%     
%     % 将降水转为二维，从而使用ginicoeff计算
%     Pre_China_year_2D = reshape(Pre_China_year,[],size(Pre_China_year,3));
%     clear Pre_China_year
%        
%     % 基尼系数计算
%     % 按照行计算
%     G_1D = ginicoeff(Pre_China_year_2D,2,true);
%     clear Pre_China_year_2D
%     
%     % 基尼系数计算
%     Gini_6h_MSWEP_1985_2014(:,:,year-1984) = reshape(G_1D,[length(Lon),length(Lat)]);
%     disp([num2str(year),' is done!'])    
%     clear G_1D filename
% end
% 
% filename2 = 'MSWEP_6h_GI_CN_1985_2014.mat';
% save(['J:\6-硕士毕业论文\1-Data\MSWEP_Data_1979_2020\2-Gini-and-LinearTrend\',filename2],'Gini_6h_MSWEP_1985_2014','Lon','Lat');
% 
% % 12-hour
% clear;clc;
% path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')
% 
% filename = ['MSWEP_Pre_China_in_',num2str(1979),'.mat'];
% load(['J:\6-硕士毕业论文\1-Data\MSWEP_Data_1979_2020\1-origin-data-CN\',filename]);
% clear Pre_China_year
% 
% Gini_12h_MSWEP_1985_2014 = nan(length(Lon),length(Lat),2014-1985+1);
% for year = 1985 : 2014
%     filename = ['pre3(12h)_',num2str(year),'.mat'];
%     load(['J:\6-硕士毕业论文\1-Data\MSWEP_Data_1979_2020\1-1-different-time-scale\12-hour\',filename]);
%     
%     Pre_China_year = pre_12h_preprocessing01_year;
%     clear pre_12h_preprocessing01_year
%     
%     % 将降水转为二维，从而使用ginicoeff计算
%     Pre_China_year_2D = reshape(Pre_China_year,[],size(Pre_China_year,3));
%     clear Pre_China_year
%        
%     % 基尼系数计算
%     % 按照行计算
%     G_1D = ginicoeff(Pre_China_year_2D,2,true);
%     clear Pre_China_year_2D
%     
%     % 基尼系数计算
%     Gini_12h_MSWEP_1985_2014(:,:,year-1984) = reshape(G_1D,[length(Lon),length(Lat)]);
%     disp([num2str(year),' is done!'])    
%     clear G_1D filename
% end
% 
% filename2 = 'MSWEP_12h_GI_CN_1985_2014.mat';
% save(['J:\6-硕士毕业论文\1-Data\MSWEP_Data_1979_2020\2-Gini-and-LinearTrend\',filename2],'Gini_12h_MSWEP_1985_2014','Lon','Lat');
% 
% % 1-day
% 
% clear;clc;
% path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')
% 
% filename = ['MSWEP_Pre_China_in_',num2str(1979),'.mat'];
% load(['J:\6-硕士毕业论文\1-Data\MSWEP_Data_1979_2020\1-origin-data-CN\',filename]);
% clear Pre_China_year
% 
% Gini_1d_MSWEP_1985_2014 = nan(length(Lon),length(Lat),2014-1985+1);
% for year = 1985 : 2014
%     filename = ['pre4(1d)_',num2str(year),'.mat'];
%     load(['J:\6-硕士毕业论文\1-Data\MSWEP_Data_1979_2020\1-1-different-time-scale\1-day\',filename]);
%     
%     Pre_China_year = pre_1d_preprocessing01_year;
%     clear pre_1d_preprocessing01_year
%     
%     % 将降水转为二维，从而使用ginicoeff计算
%     Pre_China_year_2D = reshape(Pre_China_year,[],size(Pre_China_year,3));
%     clear Pre_China_year
%        
%     % 基尼系数计算
%     % 按照行计算
%     G_1D = ginicoeff(Pre_China_year_2D,2,true);
%     clear Pre_China_year_2D
%     
%     % 基尼系数计算
%     Gini_1d_MSWEP_1985_2014(:,:,year-1984) = reshape(G_1D,[length(Lon),length(Lat)]);
%     disp([num2str(year),' is done!'])    
%     clear G_1D filename
% end
% 
% filename2 = 'MSWEP_1d_GI_CN_1985_2014.mat';
% save(['J:\6-硕士毕业论文\1-Data\MSWEP_Data_1979_2020\2-Gini-and-LinearTrend\',filename2],'Gini_1d_MSWEP_1985_2014','Lon','Lat');
% 
% 
% 
% 
% 
% 
