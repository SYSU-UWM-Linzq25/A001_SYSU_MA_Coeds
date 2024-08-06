%% 补充对从3-hour升尺度而得到的1-day数据进行空间升尺度
%% 在两种阈值处理下计算得到基尼系数
%% 与CN051的结果进行比较
%% 由于降水阈值的原因，出现沙漠地区人工的全年未下雨，这种情况，应该将其赋值为nan，因为是不真实的

% % 0.1 mm/day（暂时缺少，要重新从3-hour没有处理的升尺度到日尺度）
% clear;clc;
% path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')
% cd('J:\6-硕士毕业论文\1-Data\CMFD\5-CMFD-uper-scale-025\')
% 
% load('CMFD_1d_pre_025_scale_in_2000.mat')
% clear CMFD_025_scale_pre_1d_noprocessing_year
% 
% Lon_025 = Lon_CN051;
% Lat_025 = Lat_CN051;
% 
% Gini_CMFD_1d_025_scale_01mmday = nan(length(Lat_025),length(Lon_025),2018-1979+1);
% for year = 1979 : 2018
%     filename = ['CMFD_1d_pre_025_scale_in_',num2str(year)];
%     load(filename)
% 
%     % 单位转换(转为mm/day)
%     CMFD_025_scale_pre_1d_noprocessing_year = CMFD_025_scale_pre_1d_noprocessing_year.*24;
%     
%     % 降水阈值处理
%     CMFD_025_scale_pre_1d_noprocessing_year(CMFD_025_scale_pre_1d_noprocessing_year < 0.1) = 0;
%     
%     % 为了加快计算速度，先将三维转二维，然后利用ginicoef函数计算
%     CMFD_pre_year_2D = reshape(CMFD_025_scale_pre_1d_noprocessing_year,[],size(CMFD_025_scale_pre_1d_noprocessing_year,3));
%     
%     % 基尼系数计算
%     % 按照行计算
%     G_1D = ginicoeff(CMFD_pre_year_2D,2,true);
%     
%     Gini_CMFD_1d_025_scale_01mmday(:,:,year-1978) = reshape(G_1D,[size(CMFD_025_scale_pre_1d_noprocessing_year,1),size(CMFD_025_scale_pre_1d_noprocessing_year,2)]);
%     
%     clear CMFD_025_scale_pre_1d_noprocessing_year CMFD_pre_year_2D G_1D filename
%     disp([num2str(year),' is done!'])
% end
% 
% filename2 = 'CMFD_1d_Gini_025_scale_01mmday_1979_2018.mat';
% save(['J:\6-硕士毕业论文\1-Data\CMFD\6-CMFD-025-scale-Gini&LinearTend\',filename2],'Gini_CMFD_1d_025_scale_01mmday','Lon_025','Lat_025')


%% 0.1 mm/h
clear;clc;
path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')
cd('J:\6-硕士毕业论文\1-Data\CMFD\0-from-paper2\1d-025-scale\')

load('CMFD_1d_pre_025_scale_in_2000.mat')
clear CMFD_025_scale_pre_1d_preprocessing01_year

Lon_025 = Lon_CN051;
Lat_025 = Lat_CN051;

Gini_CMFD_1d_025_scale_01mmh = nan(length(Lat_025),length(Lon_025),2018-1979+1);
for year = 1979 : 2018
    filename = ['CMFD_1d_pre_025_scale_in_',num2str(year)];
    load(filename)

%         % 转置前两维用于检查
%         CMFD_025_scale_pre_1d_noprocessing_year_rev = nan(length(Lon_CN051),length(Lat_CN051),size(CMFD_025_scale_pre_1d_noprocessing_year,3));
%         for m = 1 : size(CMFD_025_scale_pre_1d_noprocessing_year,3)
%             a = CMFD_025_scale_pre_1d_noprocessing_year(:,:,m);
%             CMFD_025_scale_pre_1d_noprocessing_year_rev(:,:,m) = a';
%             clear a 
%         end
%         
%         CMFD_025_scale_pre_1d_noprocessing_year_rev_2D = reshape(CMFD_025_scale_pre_1d_noprocessing_year_rev,[],size(CMFD_025_scale_pre_1d_noprocessing_year_rev,3));
%         cc = CMFD_025_scale_pre_1d_noprocessing_year_rev_2D(k(80),:);
%         
%         ginicoeff(cc,2,true)
        
    % 为了加快计算速度，先将三维转二维，然后利用ginicoef函数计算
    CMFD_pre_year_2D = reshape(CMFD_025_scale_pre_1d_preprocessing01_year,[],size(CMFD_025_scale_pre_1d_preprocessing01_year,3));
    
    % 基尼系数计算
    % 按照行计算
    G_1D = ginicoeff(CMFD_pre_year_2D,2,true);
    
    Gini_CMFD_1d_025_scale_01mmh(:,:,year-1978) = reshape(G_1D,[size(CMFD_025_scale_pre_1d_preprocessing01_year,1),size(CMFD_025_scale_pre_1d_preprocessing01_year,2)]);
    
    clear CMFD_025_scale_pre_1d_preprocessing01_year CMFD_pre_year_2D G_1D filename
    disp([num2str(year),' is done!'])
end

filename2 = 'CMFD_1d_Gini_025_scale_01mmh_1979_2018_from_Paper2.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\0-from-paper2\',filename2],'Gini_CMFD_1d_025_scale_01mmh','Lon_025','Lat_025')


