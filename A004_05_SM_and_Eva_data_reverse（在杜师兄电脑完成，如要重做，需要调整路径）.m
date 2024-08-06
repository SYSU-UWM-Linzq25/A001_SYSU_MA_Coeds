%% 这个文件将提取的GLEAM数据插值到CMFD-025°的网格上
%% 但是首先要转置矩阵的形式，因为GLEAM的纬度跟CMFD的不一样
clear;clc;

% % 读取CMFD-1d-025-scale的经纬度网格
% load('D:\毕业论文\Data\LLT_025_scale.mat')

% 读取原始GLEAM的经纬度情况
load('D:\毕业论文\Data\GLEAM V3.8a SMsurf\GlEAM_data_origin_scale_in_CN.mat')

Lat_GLEAM_rev = flip(Lat_GLEAM);


for year = 1985 :2014
    save_path = 'D:\毕业论文\Data\GLEAM V3.8a SMsurf\';
    filename = ['SMsurf_CN_in_',num2str(year),'.mat'];
    cd(save_path)
    load(filename)


    SM_surf_year_rev = nan(size(SM_surf_year,1),size(SM_surf_year,2),size(SM_surf_year,3));
    for i = 1 : length(Lat_GLEAM)
        SM_surf_year_rev(:,length(Lat_GLEAM)+1-i,:) = SM_surf_year(:,i,:);
    end

%     % 尝试验证(正确)
%     figure
%     [xx_origin,yy_origin] = meshgrid(Lon_GLEAM,Lat_GLEAM);
%     pcolor(xx_origin,yy_origin,nanmean(SM_surf_year,3)')
%     colorbar
%     title('原始分辨率','fontname','宋体')
% 
%     figure
%     [xx_rev,yy_rev] = meshgrid(Lon_GLEAM,Lat_GLEAM_rev);
%     pcolor(xx_rev,yy_rev,nanmean(SM_surf_year_rev,3)')
%     colorbar
%     title('纬度翻转','fontname','宋体')    


    filename2 = ['SMsurf_rev_CN_in_',num2str(year),'.mat'];
    save(['D:\毕业论文\Data\GLEAM V3.8a SMsurf\SM_rev\',filename2],'SM_surf_year_rev','Lon_GLEAM','Lat_GLEAM_rev');
    disp([num2str(year),' is done!'])

    clear SM_surf_year_rev SM_surf_year filename
end

%%
clearvars -except Lat_GLEAM Lon_GLEAM Lat_GLEAM_rev

for year = 1985 :2014
    save_path = 'D:\毕业论文\Data\GLEAM V3.8a Eva\';
    filename = ['Eva_CN_in_',num2str(year),'.mat'];
    cd(save_path)
    load(filename)


    Eva_year_rev = nan(size(Eva_surf_year,1),size(Eva_surf_year,2),size(Eva_surf_year,3));
    for i = 1 : length(Lat_GLEAM)
        Eva_year_rev(:,length(Lat_GLEAM)+1-i,:) = Eva_surf_year(:,i,:);
    end
% 
%     % 尝试验证(正确)
%     figure
%     [xx_origin,yy_origin] = meshgrid(Lon_GLEAM,Lat_GLEAM);
%     pcolor(xx_origin,yy_origin,nanmean(Eva_surf_year,3)')
%     colorbar
%     title('原始分辨率','fontname','宋体')
% 
%     figure
%     [xx_rev,yy_rev] = meshgrid(Lon_GLEAM,Lat_GLEAM_rev);
%     pcolor(xx_rev,yy_rev,nanmean(Eva_surf_year_rev,3)')
%     colorbar
%     title('纬度翻转','fontname','宋体')    


    filename2 = ['Eva_rev_CN_in_',num2str(year),'.mat'];
    save(['D:\毕业论文\Data\GLEAM V3.8a Eva\Eva_rev\',filename2],'Eva_year_rev','Lon_GLEAM','Lat_GLEAM_rev');
    disp([num2str(year),' is done!'])

    clear Eva_surf_year_rev Eva_surf_year filename
end
