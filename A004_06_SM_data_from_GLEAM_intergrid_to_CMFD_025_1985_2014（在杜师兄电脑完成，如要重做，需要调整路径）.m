%% 这个文件将提取的GLEAM数据插值到CMFD-025°的网格上

clear;clc;

% 读取CMFD-1d-025-scale的经纬度网格
load('D:\毕业论文\Data\LLT_025_scale.mat')
[xx_025,yy_025] = meshgrid(Lon_025,Lat_025);
xx_025 = xx_025';
yy_025 = yy_025';

save_path = 'D:\毕业论文\Data\GLEAM V3.8a SMsurf\SM_rev\';
filename = ['SMsurf_rev_CN_in_',num2str(2000),'.mat'];
cd(save_path)
load(filename)
clear SM_surf_year_rev
[xx_model,yy_model] = meshgrid(Lon_GLEAM,Lat_GLEAM_rev);
xx_model = xx_model';
yy_model = yy_model';
clear Lon_GLEAM Lat_GLEAM_rev

for year = 1985 :2014
    save_path = 'D:\毕业论文\Data\GLEAM V3.8a SMsurf\SM_rev\';
    filename = ['SMsurf_rev_CN_in_',num2str(year),'.mat'];
    cd(save_path)
    load(filename)

    SM_surf_025_scale_year = nan(size(xx_025,1),size(xx_025,2),size(SM_surf_year_rev,3));

    % 空间上网格对齐
    for day = 1 : size(SM_surf_year_rev,3)
        SM_surf_day = SM_surf_year_rev(:,:,day);
        SM_surf_025_scale_year(:,:,day) = griddata(xx_model,yy_model,SM_surf_day,xx_025,yy_025,'linear');
        disp([num2str(day), ' day of ',num2str(year), ' is done!'])
        clear SM_surf_day
    end

    filename2 = ['SMsurf_CN_025_scale_in_',num2str(year),'.mat'];
    save(['D:\毕业论文\Data\GLEAM-V3.8a-025-scale\SM\',filename2],'SM_surf_025_scale_year','Lon_025','Lat_025');
    clear SM_surf_year_rev filename filename2 SM_surf_025_scale_year
end

%%

clear;clc;

% 读取CMFD-1d-025-scale的经纬度网格
load('D:\毕业论文\Data\LLT_025_scale.mat')
[xx_025,yy_025] = meshgrid(Lon_025,Lat_025);
xx_025 = xx_025';
yy_025 = yy_025';

save_path = 'D:\毕业论文\Data\GLEAM V3.8a Eva\Eva_rev\';
filename = ['Eva_rev_CN_in_',num2str(2000),'.mat'];
cd(save_path)
load(filename)
clear Eva_year_rev
[xx_model,yy_model] = meshgrid(Lon_GLEAM,Lat_GLEAM_rev);
xx_model = xx_model';
yy_model = yy_model';
clear Lon_GLEAM Lat_GLEAM_rev

for year = 1985 :2014
    save_path = 'D:\毕业论文\Data\GLEAM V3.8a Eva\Eva_rev\';
    filename = ['Eva_rev_CN_in_',num2str(year),'.mat'];
    cd(save_path)
    load(filename)

    Eva_025_scale_year = nan(size(xx_025,1),size(xx_025,2),size(Eva_year_rev,3));

    % 空间上网格对齐
    for day = 1 : size(Eva_year_rev,3)
        Eva_surf_day = Eva_year_rev(:,:,day);
        Eva_025_scale_year(:,:,day) = griddata(xx_model,yy_model,Eva_surf_day,xx_025,yy_025,'linear');
        disp([num2str(day), ' day of ',num2str(year), ' is done!'])
        clear Eva_surf_day
    end

    filename2 = ['Eva_CN_025_scale_in_',num2str(year),'.mat'];
    save(['D:\毕业论文\Data\GLEAM-V3.8a-025-scale\Eva\',filename2],'Eva_025_scale_year','Lon_025','Lat_025');
    clear Eva_year_rev filename filename2 Eva_025_scale_year
end
