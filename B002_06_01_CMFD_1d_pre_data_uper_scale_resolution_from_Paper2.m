%% 这个文件直接通过对CMFD结果进行升尺度，升到CN051的经纬度范围
%% 通过计算升尺度后的RMSE，比较两种阈值的好坏
%% 还可以通过计算纬度地带性，反映基尼系数随纬度变化情况

% 日尺度CMFD降水数据
clear;clc;

path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')
cd('J:\6-硕士毕业论文\1-Data\CMFD\2-origin-data-1d\')

load('pre4_1d_no_preprocessing_2000.mat')
Lon_CMFD = Lon;
Lat_CMFD = Lat;
clear pre_1d_noprocessing Lon Lat

% CN051经纬度网格
load('J:\6-硕士毕业论文\1-Data\CN051-TM-Pre-1979-2018\1-origin-data\CN051_Pre_1979_2018.mat')
Lon_CN051 = Lon;
Lat_CN051 = Lat;
clear Lon Lat Pre_CN051_1979_2018

[xx_CN051,yy_CN051] = meshgrid(Lon_CN051,Lat_CN051);
[xx_CMFD,yy_CMFD] = meshgrid(Lon_CMFD,Lat_CMFD);

xx_CMFD = xx_CMFD';
yy_CMFD = yy_CMFD';

CN051_Grid_Lon_Gap = abs(xx_CN051(1,2) - xx_CN051(1,1))/2;
CN051_Grid_Lat_Gap = abs(yy_CN051(1,1) - yy_CN051(2,1))/2;

% 使用CN051去建立搜索框
Search_index_and_weight = cell(size(xx_CN051,1),size(xx_CN051,2));

% 以CN051网格为搜索原点，建立搜索四格点
for i = 1 : size(xx_CN051,1)
    for j = 1 : size(xx_CN051,2)
        
        Center_Grid_Lon = xx_CN051(i,j);
        Center_Grid_Lat = yy_CN051(i,j);
        
        % 左上角点的经纬度
        Top_Left_Lon = Center_Grid_Lon - CN051_Grid_Lon_Gap;
        Top_Left_Lat = Center_Grid_Lat + CN051_Grid_Lat_Gap;
        % 右上角点的经纬度
        Top_Right_Lon = Center_Grid_Lon + CN051_Grid_Lon_Gap;
        Top_Right_Lat = Center_Grid_Lat + CN051_Grid_Lat_Gap;
        % 左下角点的经纬度
        Down_Left_Lon = Center_Grid_Lon - CN051_Grid_Lon_Gap;
        Down_Left_Lat = Center_Grid_Lat - CN051_Grid_Lat_Gap;
        % 右下角点的经纬度
        Down_Right_Lon = Center_Grid_Lon + CN051_Grid_Lon_Gap;
        Down_Right_Lat = Center_Grid_Lat - CN051_Grid_Lat_Gap;
        
        % 搜索在四个点范围内的CMFD网格
        % 但是可能存在一些情况
        % 情况一，框的四个角正好是CMFD网格中心
        k1 = find(xx_CMFD == Top_Left_Lon & yy_CMFD == Top_Left_Lat);
        k2 = find(xx_CMFD == Top_Right_Lon & yy_CMFD == Top_Right_Lat);
        k3 = find(xx_CMFD == Down_Left_Lon & yy_CMFD == Down_Left_Lat);
        k4 = find(xx_CMFD == Down_Right_Lon & yy_CMFD == Down_Right_Lat);
        
        % 情况二，不在四个角，但是在四条边上
        % 左边
        kk1 = find(xx_CMFD == Top_Left_Lon & yy_CMFD > Down_Left_Lat & yy_CMFD < Top_Left_Lat);
        % 右边
        kk2 = find(xx_CMFD == Top_Right_Lon & yy_CMFD > Down_Right_Lat & yy_CMFD < Top_Right_Lat);
        % 上边
        kk3 = find(yy_CMFD == Top_Right_Lat & xx_CMFD > Top_Left_Lon & xx_CMFD < Top_Right_Lon);
        % 下边
        kk4 = find(yy_CMFD == Down_Right_Lat & xx_CMFD > Top_Left_Lon & xx_CMFD < Top_Right_Lon);
        
        % 情况三，不在边角上
        kkk = find(xx_CMFD > Top_Left_Lon & xx_CMFD < Top_Right_Lon & yy_CMFD > Down_Left_Lat & yy_CMFD < Top_Left_Lat);
        
        % 存储四个角的搜索索引
        for m = 1 : 4
            eval(['aa = isempty(k',num2str(m),');'])
            if aa ~= 1
                eval(['Search_matrix(1,',num2str(m),') = k',num2str(m),';'])
            else
                eval(['Search_matrix(1,',num2str(m),') = nan;'])
            end
            clear aa
        end
        
        % 搜索四条边的索引
        clear m
        for m = 1 : 4
            eval(['aa = isempty(kk',num2str(m),');'])
            if aa ~= 1
                eval(['Search_matrix(',num2str(m+1),',1:length(kk',num2str(m),')) = kk',num2str(m),';'])
            else
                eval(['Search_matrix(',num2str(m+1),',1) = nan;'])
            end
            clear aa
        end
        
        % 搜索不在边角上的索引
        clear m aa
        aa = isempty(kkk);
        if aa ~= 1
            Search_matrix(6,1:length(kkk)) = kkk;
        else
            Search_matrix(6,1) = nan;
        end
        
        Search_index_and_weight{i,j} = Search_matrix;
        clear Search_matrix Center_Grid_Lon Center_Grid_Lat
        clear Top_Left_Lon Top_Left_Lat Top_Right_Lon Top_Right_Lat Down_Left_Lon Down_Left_Lat Down_Right_Lon Down_Right_Lat
        clear k1 k2 k3 k4
        clear kk1 kk2 kk3 kk4
        clear kkk
        disp([num2str(j),' of ',num2str(size(xx_CN051,2)),' is done!'])
    end
    disp([num2str(i),' of ',num2str(size(xx_CN051,1)),' is done!'])
end


filename2 = 'Uper_scale_index_matrix_025.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\5-CMFD-uper-scale-025\',filename2],'Search_index_and_weight','Lon_CMFD','Lat_CMFD','xx_CMFD','yy_CMFD')

%% 对整个索引矩阵进行搜索，看下是否存在边角情况
clear;clc;
filename2 = 'Uper_scale_index_matrix_025.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\5-CMFD-uper-scale-025\',filename2],'Search_index_and_weight','Lon_CMFD','Lat_CMFD','xx_CMFD','yy_CMFD')

Search_index_and_weight_line = reshape(Search_index_and_weight,[1,size(Search_index_and_weight,1)*size(Search_index_and_weight,2)]);
% Search_index_and_weight_2 = reshape(Search_index_and_weight_line,[size(Search_index_and_weight,1),size(Search_index_and_weight,2)]);

Coner_and_line_situation = nan(size(Search_index_and_weight_line));
for i = 1 : length(Search_index_and_weight_line)
    index_matrix = Search_index_and_weight_line{i};
    a = all(isnan(index_matrix(1,1:4)));
    b = all(isnan(index_matrix(2:5,1)));
    if a == 1 && b == 1 % 边角都不存在
        Coner_and_line_situation(i) = 0;
    elseif a == 1 && b ~= 1 % 存在边的情况
        Coner_and_line_situation(i) = 1;
    elseif a ~= 1 && b == 1 % 存在角的情况
        Coner_and_line_situation(i) = 2;
    elseif a ~= 1 && b ~= 1 % 边角情况都存在
        Coner_and_line_situation(i) = 4;
    end
    clear a b index_matrix
end
Coner_and_line_situation = reshape(Coner_and_line_situation,[size(Search_index_and_weight,1),size(Search_index_and_weight,2)]);
k1 = find(Coner_and_line_situation == 0);
k2 = find(Coner_and_line_situation == 1);
k3 = find(Coner_and_line_situation == 2);
k4 = find(Coner_and_line_situation == 4);

% 不存在边角情况


%% 这一部分舍弃，因为改用了paper2的日降水数据，因此这里就不用了
% %% 根据索引随CMFD降水数据进行升尺度操作(日尺度)
% 
% clear;clc;
% filename2 = 'Uper_scale_index_matrix_025.mat';
% load(['J:\6-硕士毕业论文\1-Data\CMFD\5-CMFD-uper-scale-025\',filename2],'Search_index_and_weight','Lon_CMFD','Lat_CMFD','xx_CMFD','yy_CMFD')
% 
% % 把图形重现，从而看索引是否能对应
% % CN051经纬度网格
% load('J:\6-硕士毕业论文\1-Data\CN051-TM-Pre-1979-2018\1-origin-data\CN051_Pre_1979_2018.mat')
% Lon_CN051 = Lon;
% Lat_CN051 = Lat;
% clear Lon Lat Pre_CN051_1979_2018
% % 
% % [xx_CN051,yy_CN051] = meshgrid(Lon_CN051,Lat_CN051);
% % test_matrix = ones(size(xx_CN051,1),size(xx_CN051,2));
% % 
% % figure('Position', [1, 1, 1300, 1000],'paperpositionmode','auto');
% % m_proj('miller','lon',[70,140],'lat',[10,57]);%选择投影方式
% % h = m_pcolor(xx_CN051,yy_CN051,test_matrix);
% % set(h,'facecolor',[1 1 1],'linestyle','-','EdgeColor',[0 0 0]);
% % hold on
% % m_plot(xx_CMFD,yy_CMFD,'b.')
% % hold off
% % m_grid('fontsize',20,'tickdir','out','linestyle','none') % 在grid这里调整网格以及坐标模式，xtick可以直接改变坐标轴所需要的刻度多少
% % m_ruler([0.03 0.2],0.05,2,'linewid',4,'ticklen',0.01,'fontsize',15); % 设置'tickdir','out'会导致图colorbar强制改变
% 
% Search_index_and_weight_line = reshape(Search_index_and_weight,[1,size(Search_index_and_weight,1)*size(Search_index_and_weight,2)]);
% for year = 1980 : 2018
%     % 读取CMFD日尺度降水数据
%     filename = ['pre4_1d_no_preprocessing_',num2str(year),'.mat'];
%     load(['J:\6-硕士毕业论文\1-Data\CMFD\2-origin-data-1d\',filename])
%     
%     CMFD_025_scale_pre_1d_noprocessing_year = nan(size(Search_index_and_weight,1),size(Search_index_and_weight,2),size(pre_1d_noprocessing,3));
%     
%     for day = 1 : size(pre_1d_noprocessing,3)
%         pre_1d_noprocessing_day = pre_1d_noprocessing(:,:,day);
%         % 根据索引计算位置处的降水量
%         for i = 1 : length(Search_index_and_weight_line)
%             [x1,y1] = ind2sub([size(Search_index_and_weight,1),size(Search_index_and_weight,2)],i);
%             index_matrix = Search_index_and_weight_line{i}(end,:);
%             b = isnan(index_matrix(1));
%             
%             % 一部分边界网格存在4个以下的，会出现0值，去除0值
%             index_matrix(index_matrix == 0) = [];
%             
%             if b == 1 % 没有对应的CMFD网格
%                 CMFD_025_scale_pre_1d_noprocessing_year(x1,y1,day) = nan;
%             else
%                 CMFD_025_scale_pre_1d_noprocessing_year(x1,y1,day) = nanmean(pre_1d_noprocessing_day(index_matrix));
%             end
%             clear x1 y1 b index_matrix
%         end
%         disp([num2str(day),' of ',num2str(year),' is done!'])
%         clear pre_1d_noprocessing_day
%     end
%     
%     filename2 = ['CMFD_1d_pre_025_scale_in_',num2str(year),'.mat'];
%     save(['J:\6-硕士毕业论文\1-Data\CMFD\5-CMFD-uper-scale-025\',filename2],'CMFD_025_scale_pre_1d_noprocessing_year','Lon_CN051','Lat_CN051')
%     clear CMFD_025_scale_pre_1d_noprocessing_year filename filename2
% end
% 
% %% 验证升尺度后的结果
% % 年内某一天
% clear;clc;
% 
% year = 2000;
% filename = ['pre4_1d_no_preprocessing_',num2str(year),'.mat'];
% load(['J:\6-硕士毕业论文\1-Data\CMFD\2-origin-data-1d\',filename])
% 
% load(['J:\6-硕士毕业论文\1-Data\CMFD\5-CMFD-uper-scale-025\CMFD_1d_pre_025_scale_in_',num2str(year),'.mat'])
% 
% day = 100;
% [xx1,yy1] = meshgrid(Lon,Lat);
% [xx2,yy2] = meshgrid(Lon_CN051,Lat_CN051);
% 
% figure('Position', [1, 1, 1300, 1000],'paperpositionmode','auto');
% m_proj('miller','lon',[70,140],'lat',[10,57]);%选择投影方式
% h = m_pcolor(xx1,yy1,pre_1d_noprocessing(:,:,day)');
% m_grid('fontsize',20,'tickdir','out','linestyle','none') % 在grid这里调整网格以及坐标模式，xtick可以直接改变坐标轴所需要的刻度多少
% m_ruler([0.03 0.2],0.05,2,'linewid',4,'ticklen',0.01,'fontsize',15); % 设置'tickdir','out'会导致图colorbar强制改变
% 
% figure('Position', [1, 1, 1300, 1000],'paperpositionmode','auto');
% m_proj('miller','lon',[70,140],'lat',[10,57]);%选择投影方式
% h = m_pcolor(xx2,yy2,CMFD_025_scale_pre_1d_noprocessing_year(:,:,day));
% m_grid('fontsize',20,'tickdir','out','linestyle','none') % 在grid这里调整网格以及坐标模式，xtick可以直接改变坐标轴所需要的刻度多少
% m_ruler([0.03 0.2],0.05,2,'linewid',4,'ticklen',0.01,'fontsize',15); % 设置'tickdir','out'会导致图colorbar强制改变



%% 补充对从3-hour升尺度而得到的1-day数据进行空间升尺度
%% 这一部分是后面升尺度的基础，用的paper2的降水✔

clear;clc;
filename2 = 'Uper_scale_index_matrix_025.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\5-CMFD-uper-scale-025\',filename2],'Search_index_and_weight','Lon_CMFD','Lat_CMFD','xx_CMFD','yy_CMFD')

% 把图形重现，从而看索引是否能对应
% CN051经纬度网格
load('J:\6-硕士毕业论文\1-Data\CN051-TM-Pre-1979-2018\1-origin-data\CN051_Pre_1979_2018.mat')
Lon_CN051 = Lon;
Lat_CN051 = Lat;
clear Lon Lat Pre_CN051_1979_2018
% 
% [xx_CN051,yy_CN051] = meshgrid(Lon_CN051,Lat_CN051);
% test_matrix = ones(size(xx_CN051,1),size(xx_CN051,2));
% 
% figure('Position', [1, 1, 1300, 1000],'paperpositionmode','auto');
% m_proj('miller','lon',[70,140],'lat',[10,57]);%选择投影方式
% h = m_pcolor(xx_CN051,yy_CN051,test_matrix);
% set(h,'facecolor',[1 1 1],'linestyle','-','EdgeColor',[0 0 0]);
% hold on
% m_plot(xx_CMFD,yy_CMFD,'b.')
% hold off
% m_grid('fontsize',20,'tickdir','out','linestyle','none') % 在grid这里调整网格以及坐标模式，xtick可以直接改变坐标轴所需要的刻度多少
% m_ruler([0.03 0.2],0.05,2,'linewid',4,'ticklen',0.01,'fontsize',15); % 设置'tickdir','out'会导致图colorbar强制改变

Search_index_and_weight_line = reshape(Search_index_and_weight,[1,size(Search_index_and_weight,1)*size(Search_index_and_weight,2)]);
for year = 1979 : 2018
    % 读取CMFD日尺度降水数据
    filename = ['pre4(1d)_',num2str(year),'.mat'];
    load(['J:\6-硕士毕业论文\1-Data\CMFD\0-from-paper2\1d\pre\',filename])
    
    CMFD_025_scale_pre_1d_preprocessing01_year = nan(size(Search_index_and_weight,1),size(Search_index_and_weight,2),size(pre_1d_preprocessing01_year,3));
    
    for day = 1 : size(pre_1d_preprocessing01_year,3)
        pre_1d_preprocessing01_day = pre_1d_preprocessing01_year(:,:,day);
        % 根据索引计算位置处的降水量
        for i = 1 : length(Search_index_and_weight_line)
            [x1,y1] = ind2sub([size(Search_index_and_weight,1),size(Search_index_and_weight,2)],i);
            index_matrix = Search_index_and_weight_line{i}(end,:);
            b = isnan(index_matrix(1));
            
            % 一部分边界网格存在4个以下的，会出现0值，去除0值
            index_matrix(index_matrix == 0) = [];
            
            if b == 1 % 没有对应的CMFD网格
                CMFD_025_scale_pre_1d_preprocessing01_year(x1,y1,day) = nan;
            else
                CMFD_025_scale_pre_1d_preprocessing01_year(x1,y1,day) = nanmean(pre_1d_preprocessing01_day(index_matrix));
            end
            clear x1 y1 b index_matrix
        end
        disp([num2str(day),' of ',num2str(year),' is done!'])
        clear pre_1d_preprocessing01_day
    end
    
    filename2 = ['CMFD_1d_pre_025_scale_in_',num2str(year),'.mat'];
    save(['J:\6-硕士毕业论文\1-Data\CMFD\0-from-paper2\1d-025-scale\',filename2],'CMFD_025_scale_pre_1d_preprocessing01_year','Lon_CN051','Lat_CN051')
    clear CMFD_025_scale_pre_1d_preprocessing01_year pre_1d_preprocessing01_year filename filename2
end

%% 这里补充一个温度的升尺度
%% 用的是原始CMFD-3h-0.1°的温度数据

clear;clc;
filename2 = 'Uper_scale_index_matrix_025.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\5-CMFD-uper-scale-025\',filename2],'Search_index_and_weight','Lon_CMFD','Lat_CMFD','xx_CMFD','yy_CMFD')

% 把图形重现，从而看索引是否能对应
% CN051经纬度网格
load('J:\6-硕士毕业论文\1-Data\CN051-TM-Pre-1979-2018\1-origin-data\CN051_Pre_1979_2018.mat')
Lon_CN051 = Lon;
Lat_CN051 = Lat;
clear Lon Lat Pre_CN051_1979_2018

Search_index_and_weight_line = reshape(Search_index_and_weight,[1,size(Search_index_and_weight,1)*size(Search_index_and_weight,2)]);
for year = 1979 : 2018
    % 读取CMFD温度数据
    filename = ['pre4(1d)_',num2str(year),'.mat'];
    load(['J:\6-硕士毕业论文\1-Data\CMFD\0-from-paper2\1d\pre\',filename])
    
    CMFD_025_scale_pre_1d_preprocessing01_year = nan(size(Search_index_and_weight,1),size(Search_index_and_weight,2),size(pre_1d_preprocessing01_year,3));
    
    for day = 1 : size(pre_1d_preprocessing01_year,3)
        pre_1d_preprocessing01_day = pre_1d_preprocessing01_year(:,:,day);
        % 根据索引计算位置处的降水量
        for i = 1 : length(Search_index_and_weight_line)
            [x1,y1] = ind2sub([size(Search_index_and_weight,1),size(Search_index_and_weight,2)],i);
            index_matrix = Search_index_and_weight_line{i}(end,:);
            b = isnan(index_matrix(1));
            
            % 一部分边界网格存在4个以下的，会出现0值，去除0值
            index_matrix(index_matrix == 0) = [];
            
            if b == 1 % 没有对应的CMFD网格
                CMFD_025_scale_pre_1d_preprocessing01_year(x1,y1,day) = nan;
            else
                CMFD_025_scale_pre_1d_preprocessing01_year(x1,y1,day) = nanmean(pre_1d_preprocessing01_day(index_matrix));
            end
            clear x1 y1 b index_matrix
        end
        disp([num2str(day),' of ',num2str(year),' is done!'])
        clear pre_1d_preprocessing01_day
    end
    
    filename2 = ['CMFD_1d_pre_025_scale_in_',num2str(year),'.mat'];
    save(['J:\6-硕士毕业论文\1-Data\CMFD\0-from-paper2\1d-025-scale\',filename2],'CMFD_025_scale_pre_1d_preprocessing01_year','Lon_CN051','Lat_CN051')
    clear CMFD_025_scale_pre_1d_preprocessing01_year pre_1d_preprocessing01_year filename filename2
end

