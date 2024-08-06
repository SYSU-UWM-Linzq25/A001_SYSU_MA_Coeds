%% 这个文件直接通过对CMFD-3h的年均温数据进行升尺度，升到CN051的经纬度范围

clear;clc;
filename2 = 'Uper_scale_index_matrix_025.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\5-2-CMFD-025-scale-AP-and-MAT-01mmh\',filename2])

% 把图形重现，从而看索引是否能对应
% CN051经纬度网格
load('J:\6-硕士毕业论文\1-Data\CN051-TM-Pre-1979-2018\1-origin-data\CN051_Pre_1979_2018.mat')
Lon_CN051 = Lon;
Lat_CN051 = Lat;
clear Lon Lat Pre_CN051_1979_2018

% 读取年均温数据
clear filename2
filename2 = 'MAT_3h_01mmh_1979_2018.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\5-1-CMFD-01-scale-AP-and-MAT-01mmh\',filename2]);
MAT_3h_1985_2014 = MAT_3h(:,:,7:end-4);
clear MAT_3h

Search_index_and_weight_line = reshape(Search_index_and_weight,[1,size(Search_index_and_weight,1)*size(Search_index_and_weight,2)]);

MAT_3h_1985_2014_025_scale = nan(size(Search_index_and_weight,1),size(Search_index_and_weight,2),size(MAT_3h_1985_2014,3));

for year = 1 : size(MAT_3h_1985_2014,3)
    MAT_3h_year = MAT_3h_1985_2014(:,:,year);
    % 根据索引计算位置处的降水量
    for i = 1 : length(Search_index_and_weight_line)
        [x1,y1] = ind2sub([size(Search_index_and_weight,1),size(Search_index_and_weight,2)],i);
        index_matrix = Search_index_and_weight_line{i}(end,:);
        b = isnan(index_matrix(1));
        
        % 一部分边界网格存在4个以下的，会出现0值，去除0值
        index_matrix(index_matrix == 0) = [];
        
        if b == 1 % 没有对应的CMFD网格
            MAT_3h_1985_2014_025_scale(x1,y1,year) = nan;
        else
            MAT_3h_1985_2014_025_scale(x1,y1,year) = nanmean(MAT_3h_year(index_matrix));
        end
        clear x1 y1 b index_matrix
    end
    disp([num2str(year),' of ',num2str(year),' is done!'])
    clear MAT_3h_year
end

filename2 = 'CMFD_3h_MAT_025_scale_in_1985_2014.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\5-2-CMFD-025-scale-AP-and-MAT-01mmh\',filename2],'MAT_3h_1985_2014_025_scale','Lon_CN051','Lat_CN051')


%% 验证升尺度后的结果于原来的结果
clearvars -except Lat Lon MAT_3h_1985_2014_025_scale MAT_3h_1985_2014 Lon_CN051 Lat_CN051

[xx_01,yy_01] = meshgrid(Lon,Lat);
[xx_025,yy_025] = meshgrid(Lon_CN051,Lat_CN051);


figure
pcolor(xx_01,yy_01,MAT_3h_1985_2014(:,:,10)');
colorbar
title('01')


figure
pcolor(xx_025,yy_025,MAT_3h_1985_2014_025_scale(:,:,10));
colorbar
title('025')