%% 用于不同时间尺度基尼系数的比较
%% 尝试基尼系数发生变换
%% 可以根据降水数据，讲实验条件设置尽可能接近真实的降水情况

clear;clc;

% 读取实际的降水数据，30a中找到日降水量最大的最小（0.1*24）
% 同时计算降水日数的最大最小值

processing01_index = nan(2014-1985+1,1);
Max_day_rain_year = nan(2014-1985+1,1);
rainy_day_year = nan(2014-1985+1,366);

for year = 1985:2014
    cd('J:\6-硕士毕业论文\1-Data\CMFD\0-from-paper2\1d\pre\')
    load(['pre4(1d)_',num2str(year),'.mat']) %单位为mm/h,预处理了0.1mm/h
    
    pre_1d_preprocessing01_mm = pre_1d_preprocessing01_year * 24;
    clear pre_1d_preprocessing01_year
    
    % 最大日降水量
    Max_day_rain_year(year-1984) = max(max(max(pre_1d_preprocessing01_mm)));
    
    % 转为二维找最大和最小的降水日数
    pre_1d_preprocessing01_mm_2D = reshape(pre_1d_preprocessing01_mm,[],size(pre_1d_preprocessing01_mm,3));
    clear pre_1d_preprocessing01_mm
    
    for i = 1 : size(pre_1d_preprocessing01_mm_2D,1)
        kk_index_1 = find(~isnan(pre_1d_preprocessing01_mm_2D(i,:)));
        kk_index_2 = find(pre_1d_preprocessing01_mm_2D(i,:) > 0);
        if isempty(kk_index_1)
            rainy_day_year(year-1984,i) = nan;
        elseif isempty(kk_index_2)
            rainy_day_year(year-1984,i) = 0;
        elseif ~isempty(kk_index_2)
            rainy_day_year(year-1984,i) = length(kk_index_2);
        end
        clear kk_index_1 kk_index_2
    end
    disp([num2str(year),' is done!'])
    clear k1 pre_1d_preprocessing01_mm_2D
end

max_raniy_day = max(max(rainy_day_year));
min_raniy_day = min(min(rainy_day_year));
Max_day_rain = max(Max_day_rain_year);
filename2 = 'Range_of_daily_pre_and_rainy_day_30a_1985_2014.mat';
save(['J:\6-硕士毕业论文\1-Data\CMFD\0-from-paper2\1d\pre\',filename2],'max_raniy_day','min_raniy_day','Max_day_rain')


%% 设计实验，条件接近降水的情况
%% 包括降水日数，日降水量（最大最小值）

clear;clc;
filename2 = 'Range_of_daily_pre_and_rainy_day_30a_1985_2014.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\0-from-paper2\1d\pre\',filename2])

for n = 29 : 30
    % 第一种情况，日内超平均
    for i = 1 : 10000
        a = 0+(Max_day_rain-0)*rand(1,365); % 根据日降水数据的最大值，确定范围进行随机
        
        % 年内有随机日不下雨，并且不下雨的天是随机分布的（根据降水日数的最大最小值确定）
        unrainy_day_amount = randi([min_raniy_day,max_raniy_day]);
        
        unrainy_day_location = randi([1,365],1,unrainy_day_amount) ; % 在年内随机分布这些不下雨的天
        
        a(unrainy_day_location) = 0;
        
        b = zeros(1,2920);
        % 第一种情况，有雨的天数超平均分布，其余均填0
        for j = 1:length(a)
            if a(j) == 0
                b((j-1)*8 + 1 : j*8 ) = zeros(1,8);
            else
                pre_dreadfull_even = zeros(1,8);
                pre_dreadfull_even = pre_dreadfull_even + a(j)/8;
                b((j-1)*8 + 1 : j*8 ) = pre_dreadfull_even;
                clear pre_dreadfull_even
            end
        end
        GI_a_day(i) = ginicoeff(a,2,true);
        GI1(i) = ginicoeff(b,2,true);
        
        % 第二种情况，超集中
        
        b2 = zeros(1,2920);
        b2(1:365) = a;
        GI2(i) = ginicoeff(b2,2,true);
        clear a b b2
    end
    
    
    % figure
    % plot(1:length(GI1),GI1,'.b')
    % hold on
    % plot(1:length(GI1),GI2,'^r')
    % 画图
    GI_diff = GI2 - GI1;
    figure
    plot(GI_a_day,GI_diff,'.b')
    
    % 拟合这条直线
    Y = GI_diff';
    X = [ones(length(GI_a_day),1),GI_a_day'];
    [bbb2,~,~,~,stats] = regress(Y,X,0.05);
    text('string',['y = ',num2str(bbb2(2)),'x + ',num2str(bbb2(1))],'Units','normalized','position',[0.6,0.95],  'FontSize',14,'FontWeight','Bold','FontName','Times New Roman')
    text('string',['R^2 = ',num2str(stats(1))],'Units','normalized','position',[0.75,0.88],  'FontSize',14,'FontWeight','Bold','FontName','Times New Roman')
    text('string',['P = ',num2str(stats(3))],'Units','normalized','position',[0.75,0.81],  'FontSize',14,'FontWeight','Bold','FontName','Times New Roman')
    title([num2str(n),' 次实验'],'fontname','宋体')
    clear GI_diff GI2 GI1 GI_a_day X Y bbb2 stats
    cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\999-01-try-different-time-scale-compare\')
    exportgraphics(gcf,[num2str(n),' 次实验.jpg'])
    close all
end


%% 使用真实的日降水数据计算
%% 3h && 1d

clear;clc;

% GI_a_day = nan(2014-1985+1,280000);
% GI1 = nan(2014-1985+1,280000);
% GI2 = nan(2014-1985+1,280000);
% 
% for year = 1985 : 2014
%     cd('J:\6-硕士毕业论文\1-Data\CMFD\0-from-paper2\1d\pre\')
%     load(['pre4(1d)_',num2str(year),'.mat']) %单位为mm/h,预处理了0.1mm/h
%     
%     pre_1d_preprocessing01_mm = pre_1d_preprocessing01_year * 24;
%     clear pre_1d_preprocessing01_year
%     
%     % 转为二维
%     pre_1d_preprocessing01_mm_2D = reshape(pre_1d_preprocessing01_mm,[],size(pre_1d_preprocessing01_mm,3));
%     clear pre_1d_preprocessing01_mm
%     
%     % 探讨两种情况下，日降水转换为3-hour降水的情况
%     for i = 1 : size(pre_1d_preprocessing01_mm_2D,1)
%         a = pre_1d_preprocessing01_mm_2D(i,:); % 根据日降水数据,一整年
%         
%         if all(isnan(a)) % 全部为nan
%             continue;
%         else
%             b = zeros(1,size(pre_1d_preprocessing01_mm_2D,2)*8);
%             % 第一种情况，有雨的天数超平均分布，其余均填0
%             for j = 1:length(a)
%                 if a(j) == 0
%                     b((j-1)*8 + 1 : j*8 ) = zeros(1,8);
%                 else
%                     pre_dreadfull_even = zeros(1,8);
%                     pre_dreadfull_even = pre_dreadfull_even + a(j)/8;
%                     b((j-1)*8 + 1 : j*8 ) = pre_dreadfull_even;
%                     clear pre_dreadfull_even
%                 end
%             end
%             GI_a_day(year-1984,i) = ginicoeff(a,2,true);
%             GI1(year-1984,i) = ginicoeff(b,2,true);
%             
%             % 第二种情况，超集中
%             
%             b2 = zeros(1,size(pre_1d_preprocessing01_mm_2D,2)*8);
%             b2(1:size(pre_1d_preprocessing01_mm_2D,2)) = a;
%             GI2(year-1984,i) = ginicoeff(b2,2,true);
%             clear a b b2
%         end
%     end
%     clear pre_1d_preprocessing01_mm_2D
%     
%     % figure
%     % plot(1:length(GI1),GI1,'.b')
%     % hold on
%     % plot(1:length(GI1),GI2,'^r')
%     % 画图
%     GI_diff = GI2(year-1984,:) - GI1(year-1984,:);
%     figure
%     plot(GI_a_day(year-1984,:),GI_diff,'.b')
%     
%     % 拟合这条直线
%     Y = GI_diff';
%     X = [ones(length(GI_a_day(year-1984,:)),1),GI_a_day(year-1984,:)'];
%     [bbb2,~,~,~,stats] = regress(Y,X,0.05);
%     text('string',['y = ',num2str(bbb2(2)),'x + ',num2str(bbb2(1))],'Units','normalized','position',[0.55,0.95],  'FontSize',14,'FontWeight','Bold','FontName','Times New Roman')
%     text('string',['R^2 = ',num2str(stats(1))],'Units','normalized','position',[0.75,0.88],  'FontSize',14,'FontWeight','Bold','FontName','Times New Roman')
%     text('string',['P = ',num2str(stats(3))],'Units','normalized','position',[0.75,0.81],  'FontSize',14,'FontWeight','Bold','FontName','Times New Roman')
%     title([num2str(year),' 年日降水数据'],'fontname','宋体')
%     ylabel(['转换后的3小时尺度降水集中度差值'],'fontname','宋体')
%     xlabel(['日尺度的降水集中度'],'fontname','宋体')
%     clear GI_diff X Y bbb2 stats
%     cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\999-01-try-different-time-scale-compare\实际日降水数据实验\3h&1d\')
%     exportgraphics(gcf,[num2str(year),' 年日降水数据.jpg'])
%     close all
% end
% filename2 = '1d_GI_and_method_base_translation_3h_GI_two_situation.mat';
% save(['J:\6-硕士毕业论文\1-Data\Temporal_resolution_translation\',filename2],'GI1','GI2','GI_a_day')

filename2 = '1d_GI_and_method_base_translation_3h_GI_two_situation.mat';
load(['J:\6-硕士毕业论文\1-Data\Temporal_resolution_translation\',filename2],'GI1','GI2','GI_a_day')


% 30a合起来画
GI1_all = reshape(GI1,[1,size(GI1,1)*size(GI1,2)]);
GI2_all = reshape(GI2,[1,size(GI2,1)*size(GI2,2)]);
GI_a_day_all = reshape(GI_a_day,[1,size(GI_a_day,1)*size(GI_a_day,2)]);

clearvars -except GI1_all GI2_all GI_a_day_all

GI_diff = GI2_all - GI1_all;
figure
plot(GI_a_day_all,GI_diff,'.b')

% 拟合这条直线
Y = GI_diff';
X = [ones(length(GI_a_day_all),1),GI_a_day_all'];
[bbb2,~,~,~,stats] = regress(Y,X,0.05);
text('string',['y = ',num2str(bbb2(2)),'x + ',num2str(bbb2(1))],'Units','normalized','position',[0.55,0.95],  'FontSize',14,'FontWeight','Bold','FontName','Times New Roman')
text('string',['R^2 = ',num2str(stats(1))],'Units','normalized','position',[0.75,0.88],  'FontSize',14,'FontWeight','Bold','FontName','Times New Roman')
text('string',['P = ',num2str(stats(3))],'Units','normalized','position',[0.75,0.81],  'FontSize',14,'FontWeight','Bold','FontName','Times New Roman')
title([' 30a日降水数据'],'fontname','宋体')
ylabel(['转换后的3小时尺度降水集中度差值'],'fontname','宋体')
xlabel(['日尺度的降水集中度'],'fontname','宋体')
cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\999-01-try-different-time-scale-compare\实际日降水数据实验\3h&1d\')
exportgraphics(gcf,'30a日降水数据.jpg')

% filename2 = '30a_scatter_1d_GI_translation_3h_GI.mat';
% save(['J:\6-硕士毕业论文\1-Data\Temporal_resolution_translation\',filename2],'GI_diff','GI_a_day_all')


filename2 = '1d_GI_translation_3h_GI_two_situation_paramter.mat';
save(['J:\6-硕士毕业论文\1-Data\Temporal_resolution_translation\',filename2],'bbb2')


% 6h && 1d

clear;clc;

% GI_a_day = nan(2014-1985+1,280000);
% GI1_6h = nan(2014-1985+1,280000);
% GI2_6h = nan(2014-1985+1,280000);
% 
% for year = 1985 : 2014
%     cd('J:\6-硕士毕业论文\1-Data\CMFD\0-from-paper2\1d\pre\')
%     load(['pre4(1d)_',num2str(year),'.mat']) %单位为mm/h,预处理了0.1mm/h
%     
%     pre_1d_preprocessing01_mm = pre_1d_preprocessing01_year * 24;
%     clear pre_1d_preprocessing01_year
%     
%     % 转为二维
%     pre_1d_preprocessing01_mm_2D = reshape(pre_1d_preprocessing01_mm,[],size(pre_1d_preprocessing01_mm,3));
%     clear pre_1d_preprocessing01_mm
%     
%     % 探讨两种情况下，日降水转换为6-hour降水的情况
%     for i = 1 : size(pre_1d_preprocessing01_mm_2D,1)
%         a = pre_1d_preprocessing01_mm_2D(i,:); % 根据日降水数据,一整年
%         
%         if all(isnan(a)) % 全部为nan
%             continue;
%         else
%             b = zeros(1,size(pre_1d_preprocessing01_mm_2D,2)*4);
%             % 第一种情况，有雨的天数超平均分布，其余均填0
%             for j = 1:length(a)
%                 if a(j) == 0
%                     b((j-1)*4 + 1 : j*4 ) = zeros(1,4);
%                 else
%                     pre_dreadfull_even = zeros(1,4);
%                     pre_dreadfull_even = pre_dreadfull_even + a(j)/4;
%                     b((j-1)*4 + 1 : j*4 ) = pre_dreadfull_even;
%                     clear pre_dreadfull_even
%                 end
%             end
%             GI_a_day(year-1984,i) = ginicoeff(a,2,true);
%             GI1_6h(year-1984,i) = ginicoeff(b,2,true);
%             
%             % 第二种情况，超集中
%             
%             b2 = zeros(1,size(pre_1d_preprocessing01_mm_2D,2)*4);
%             b2(1:size(pre_1d_preprocessing01_mm_2D,2)) = a;
%             GI2_6h(year-1984,i) = ginicoeff(b2,2,true);
%             clear a b b2
%         end
%     end
%     clear pre_1d_preprocessing01_mm_2D
%     
%     % figure
%     % plot(1:length(GI1),GI1,'.b')
%     % hold on
%     % plot(1:length(GI1),GI2,'^r')
%     % 画图
%     GI_diff = GI2_6h(year-1984,:) - GI1_6h(year-1984,:);
%     figure
%     plot(GI_a_day(year-1984,:),GI_diff,'.b')
%     
%     % 拟合这条直线
%     Y = GI_diff';
%     X = [ones(length(GI_a_day(year-1984,:)),1),GI_a_day(year-1984,:)'];
%     [bbb2,~,~,~,stats] = regress(Y,X,0.05);
%     text('string',['y = ',num2str(bbb2(2)),'x + ',num2str(bbb2(1))],'Units','normalized','position',[0.55,0.95],  'FontSize',14,'FontWeight','Bold','FontName','Times New Roman')
%     text('string',['R^2 = ',num2str(stats(1))],'Units','normalized','position',[0.75,0.88],  'FontSize',14,'FontWeight','Bold','FontName','Times New Roman')
%     text('string',['P = ',num2str(stats(3))],'Units','normalized','position',[0.75,0.81],  'FontSize',14,'FontWeight','Bold','FontName','Times New Roman')
%     title([num2str(year),' 年日降水数据'],'fontname','宋体')
%     ylabel(['转换后的6小时尺度降水集中度差值'],'fontname','宋体')
%     xlabel(['日尺度的降水集中度'],'fontname','宋体')
%     clear GI_diff X Y bbb2 stats
%     cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\999-01-try-different-time-scale-compare\实际日降水数据实验\6h&1d\')
%     exportgraphics(gcf,[num2str(year),' 年日降水数据.jpg'])
%     close all
% end
% filename2 = '1d_GI_and_method_base_translation_6h_GI_two_situation.mat';
% save(['J:\6-硕士毕业论文\1-Data\Temporal_resolution_translation\',filename2],'GI1_6h','GI2_6h','GI_a_day')

filename2 = '1d_GI_and_method_base_translation_6h_GI_two_situation.mat';
load(['J:\6-硕士毕业论文\1-Data\Temporal_resolution_translation\',filename2],'GI1_6h','GI2_6h','GI_a_day')


% 30a合起来画
GI1_all = reshape(GI1_6h,[1,size(GI1_6h,1)*size(GI1_6h,2)]);
GI2_all = reshape(GI2_6h,[1,size(GI2_6h,1)*size(GI2_6h,2)]);
GI_a_day_all = reshape(GI_a_day,[1,size(GI_a_day,1)*size(GI_a_day,2)]);

clearvars -except GI1_all GI2_all GI_a_day_all

GI_diff = GI2_all - GI1_all;
figure
plot(GI_a_day_all,GI_diff,'.b')

% 拟合这条直线
Y = GI_diff';
X = [ones(length(GI_a_day_all),1),GI_a_day_all'];
[bbb2,~,~,~,stats] = regress(Y,X,0.05);
text('string',['y = ',num2str(bbb2(2)),'x + ',num2str(bbb2(1))],'Units','normalized','position',[0.55,0.95],  'FontSize',14,'FontWeight','Bold','FontName','Times New Roman')
text('string',['R^2 = ',num2str(stats(1))],'Units','normalized','position',[0.75,0.88],  'FontSize',14,'FontWeight','Bold','FontName','Times New Roman')
text('string',['P = ',num2str(stats(3))],'Units','normalized','position',[0.75,0.81],  'FontSize',14,'FontWeight','Bold','FontName','Times New Roman')
title([' 30a日降水数据'],'fontname','宋体')
ylabel(['转换后的6小时尺度降水集中度差值'],'fontname','宋体')
xlabel(['日尺度的降水集中度'],'fontname','宋体')
cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\999-01-try-different-time-scale-compare\实际日降水数据实验\6h&1d\')
exportgraphics(gcf,'30a日降水数据.jpg')

% filename2 = '30a_scatter_1d_GI_translation_6h_GI.mat';
% save(['J:\6-硕士毕业论文\1-Data\Temporal_resolution_translation\',filename2],'GI_diff','GI_a_day_all')

filename2 = '1d_GI_translation_6h_GI_two_situation_paramter.mat';
save(['J:\6-硕士毕业论文\1-Data\Temporal_resolution_translation\',filename2],'bbb2')


% 12h && 1d

clear;clc;

% GI_a_day = nan(2014-1985+1,280000);
% GI1_12h = nan(2014-1985+1,280000);
% GI2_12h = nan(2014-1985+1,280000);
% 
% for year = 1985 : 2014
%     cd('J:\6-硕士毕业论文\1-Data\CMFD\0-from-paper2\1d\pre\')
%     load(['pre4(1d)_',num2str(year),'.mat']) %单位为mm/h,预处理了0.1mm/h
%     
%     pre_1d_preprocessing01_mm = pre_1d_preprocessing01_year * 24;
%     clear pre_1d_preprocessing01_year
%     
%     % 转为二维
%     pre_1d_preprocessing01_mm_2D = reshape(pre_1d_preprocessing01_mm,[],size(pre_1d_preprocessing01_mm,3));
%     clear pre_1d_preprocessing01_mm
%     
%     % 探讨两种情况下，日降水转换为6-hour降水的情况
%     for i = 1 : size(pre_1d_preprocessing01_mm_2D,1)
%         a = pre_1d_preprocessing01_mm_2D(i,:); % 根据日降水数据,一整年
%         
%         if all(isnan(a)) % 全部为nan
%             continue;
%         else
%             b = zeros(1,size(pre_1d_preprocessing01_mm_2D,2)*2);
%             % 第一种情况，有雨的天数超平均分布，其余均填0
%             for j = 1:length(a)
%                 if a(j) == 0
%                     b((j-1)*2 + 1 : j*2 ) = zeros(1,2);
%                 else
%                     pre_dreadfull_even = zeros(1,2);
%                     pre_dreadfull_even = pre_dreadfull_even + a(j)/2;
%                     b((j-1)*2 + 1 : j*2 ) = pre_dreadfull_even;
%                     clear pre_dreadfull_even
%                 end
%             end
%             GI_a_day(year-1984,i) = ginicoeff(a,2,true);
%             GI1_12h(year-1984,i) = ginicoeff(b,2,true);
%             
%             % 第二种情况，超集中
%             
%             b2 = zeros(1,size(pre_1d_preprocessing01_mm_2D,2)*2);
%             b2(1:size(pre_1d_preprocessing01_mm_2D,2)) = a;
%             GI2_12h(year-1984,i) = ginicoeff(b2,2,true);
%             clear a b b2
%         end
%     end
%     clear pre_1d_preprocessing01_mm_2D
%     
%     % figure
%     % plot(1:length(GI1),GI1,'.b')
%     % hold on
%     % plot(1:length(GI1),GI2,'^r')
%     % 画图
%     GI_diff = GI2_12h(year-1984,:) - GI1_12h(year-1984,:);
%     figure
%     plot(GI_a_day(year-1984,:),GI_diff,'.b')
%     
%     % 拟合这条直线
%     Y = GI_diff';
%     X = [ones(length(GI_a_day(year-1984,:)),1),GI_a_day(year-1984,:)'];
%     [bbb2,~,~,~,stats] = regress(Y,X,0.05);
%     text('string',['y = ',num2str(bbb2(2)),'x + ',num2str(bbb2(1))],'Units','normalized','position',[0.55,0.95],  'FontSize',14,'FontWeight','Bold','FontName','Times New Roman')
%     text('string',['R^2 = ',num2str(stats(1))],'Units','normalized','position',[0.75,0.88],  'FontSize',14,'FontWeight','Bold','FontName','Times New Roman')
%     text('string',['P = ',num2str(stats(3))],'Units','normalized','position',[0.75,0.81],  'FontSize',14,'FontWeight','Bold','FontName','Times New Roman')
%     title([num2str(year),' 年日降水数据'],'fontname','宋体')
%     ylabel(['转换后的12小时尺度降水集中度差值'],'fontname','宋体')
%     xlabel(['日尺度的降水集中度'],'fontname','宋体')
%     clear GI_diff X Y bbb2 stats
%     cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\999-01-try-different-time-scale-compare\实际日降水数据实验\12h&1d\')
%     exportgraphics(gcf,[num2str(year),' 年日降水数据.jpg'])
%     close all
% end
% filename2 = '1d_GI_and_method_base_translation_12h_GI_two_situation.mat';
% save(['J:\6-硕士毕业论文\1-Data\Temporal_resolution_translation\',filename2],'GI1_12h','GI2_12h','GI_a_day')
% 

filename2 = '1d_GI_and_method_base_translation_12h_GI_two_situation.mat';
load(['J:\6-硕士毕业论文\1-Data\Temporal_resolution_translation\',filename2],'GI1_12h','GI2_12h','GI_a_day')


% 30a合起来画
GI1_all = reshape(GI1_12h,[1,size(GI1_12h,1)*size(GI1_12h,2)]);
GI2_all = reshape(GI2_12h,[1,size(GI2_12h,1)*size(GI2_12h,2)]);
GI_a_day_all = reshape(GI_a_day,[1,size(GI_a_day,1)*size(GI_a_day,2)]);

clearvars -except GI1_all GI2_all GI_a_day_all

GI_diff = GI2_all - GI1_all;
figure
plot(GI_a_day_all,GI_diff,'.b')

% 拟合这条直线
Y = GI_diff';
X = [ones(length(GI_a_day_all),1),GI_a_day_all'];
[bbb2,~,~,~,stats] = regress(Y,X,0.05);
text('string',['y = ',num2str(bbb2(2)),'x + ',num2str(bbb2(1))],'Units','normalized','position',[0.55,0.95],  'FontSize',14,'FontWeight','Bold','FontName','Times New Roman')
text('string',['R^2 = ',num2str(stats(1))],'Units','normalized','position',[0.75,0.88],  'FontSize',14,'FontWeight','Bold','FontName','Times New Roman')
text('string',['P = ',num2str(stats(3))],'Units','normalized','position',[0.75,0.81],  'FontSize',14,'FontWeight','Bold','FontName','Times New Roman')
title([' 30a日降水数据'],'fontname','宋体')
ylabel(['转换后的12小时尺度降水集中度差值'],'fontname','宋体')
xlabel(['日尺度的降水集中度'],'fontname','宋体')
cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\999-01-try-different-time-scale-compare\实际日降水数据实验\12h&1d\')
exportgraphics(gcf,'30a日降水数据.jpg')

% filename2 = '30a_scatter_1d_GI_translation_12h_GI.mat';
% save(['J:\6-硕士毕业论文\1-Data\Temporal_resolution_translation\',filename2],'GI_diff','GI_a_day_all')
% 

filename2 = '1d_GI_translation_12h_GI_two_situation_paramter.mat';
save(['J:\6-硕士毕业论文\1-Data\Temporal_resolution_translation\',filename2],'bbb2')



%% 3个30a的合起来画
clear;clc

% 3h → 1d
filename2 = '1d_GI_and_method_base_translation_3h_GI_two_situation.mat';
load(['J:\6-硕士毕业论文\1-Data\Temporal_resolution_translation\',filename2],'GI1','GI2','GI_a_day')

% 30a合起来画
GI1_all_3h = reshape(GI1,[1,size(GI1,1)*size(GI1,2)]);
GI2_all_3h = reshape(GI2,[1,size(GI2,1)*size(GI2,2)]);
GI_a_day_all_3h = reshape(GI_a_day,[1,size(GI_a_day,1)*size(GI_a_day,2)]);

clear GI1 GI2 GI_a_day

GI_diff_3h = GI2_all_3h - GI1_all_3h;

% 6h → 1d
filename2 = '1d_GI_and_method_base_translation_6h_GI_two_situation.mat';
load(['J:\6-硕士毕业论文\1-Data\Temporal_resolution_translation\',filename2],'GI1_6h','GI2_6h','GI_a_day')

% 30a合起来画
GI1_all_6h = reshape(GI1_6h,[1,size(GI1_6h,1)*size(GI1_6h,2)]);
GI2_all_6h = reshape(GI2_6h,[1,size(GI2_6h,1)*size(GI2_6h,2)]);
GI_a_day_all_6h = reshape(GI_a_day,[1,size(GI_a_day,1)*size(GI_a_day,2)]);

clear GI1 GI2 GI_a_day

GI_diff_6h = GI2_all_6h - GI1_all_6h;

% 12h → 1d
filename2 = '1d_GI_and_method_base_translation_12h_GI_two_situation.mat';
load(['J:\6-硕士毕业论文\1-Data\Temporal_resolution_translation\',filename2],'GI1_12h','GI2_12h','GI_a_day')

% 30a合起来画
GI1_all_12h = reshape(GI1_12h,[1,size(GI1_12h,1)*size(GI1_12h,2)]);
GI2_all_12h = reshape(GI2_12h,[1,size(GI2_12h,1)*size(GI2_12h,2)]);
GI_a_day_all_12h = reshape(GI_a_day,[1,size(GI_a_day,1)*size(GI_a_day,2)]);
clear GI1 GI2 GI_a_day

GI_diff_12h = GI2_all_12h - GI1_all_12h;

% 拟合这条直线
Y_3h = GI_diff_3h';
X_3h = [ones(length(GI_a_day_all_3h),1),GI_a_day_all_3h'];
[bbb2_3h,~,~,~,stats_3h] = regress(Y_3h,X_3h,0.05);
a_3h  =min(GI_a_day_all_3h);
b_3h  =max(GI_a_day_all_3h);

X_3h_2  = 0.5 : 0.01 : 1;
Y_3h_2 = bbb2_3h(1) + bbb2_3h(2) * X_3h_2;

Y_6h = GI_diff_6h';
X_6h = [ones(length(GI_a_day_all_6h),1),GI_a_day_all_6h'];
[bbb2_6h,~,~,~,stats_6h] = regress(Y_6h,X_6h,0.05);
a_6h  =min(GI_a_day_all_6h);
b_6h  =max(GI_a_day_all_6h);

X_6h_2  = 0.5 : 0.01 : 1;
Y_6h_2 = bbb2_6h(1) + bbb2_6h(2) * X_6h_2;


Y_12h = GI_diff_12h';
X_12h = [ones(length(GI_a_day_all_12h),1),GI_a_day_all_12h'];
[bbb2_12h,~,~,~,stats_12h] = regress(Y_12h,X_12h,0.05);
a_12h  =min(GI_a_day_all_12h);
b_12h  =max(GI_a_day_all_12h);

X_12h_2  = 0.5 : 0.01 : 1;
Y_12h_2 = bbb2_12h(1) + bbb2_12h(2) * X_12h_2;

%% 画图
figure1 = figure('Position', [1, 1, 1300, 1000],'paperpositionmode','auto');

ax1 = axes('pos',[0.08 0.3 0.28 0.38]);
line1 = plot(X_3h_2,Y_3h_2,'b--','linewidth',2);
hold on 
plot(GI_a_day_all_3h,GI_diff_3h,'k.')
hold off
set(gca,'ylim',[0 0.4])
set(gca,'xlim',[0.5 1])

legend(line1,['y = ',num2str(bbb2_3h(2)),'x + ',num2str(bbb2_3h(1)),newline,['            R^2 = ',num2str(floor(stats_3h(1)*100)/100)]],'FontSize',15,'FontName','Times New Roman')

% 强制保留小数位数
cb_tick = get(ax1,'ytick');
Tick_label = cell(1,length(cb_tick));
for j = 1 : length(cb_tick)
    Tick_label{1,j} = num2str(roundn(cb_tick(j),-2),'%4.2f');
end
set(ax1,'yticklabel',Tick_label)

cb_tick = get(ax1,'xtick');
Tick_label = cell(1,length(cb_tick));
for j = 1 : length(cb_tick)
    Tick_label{1,j} = num2str(roundn(cb_tick(j),-1),'%4.1f');
end
set(ax1,'xticklabel',Tick_label)

ylabel(['转换后的降水集中度差值'],'fontname','宋体','fontsize',20)

ax2 = axes('pos',[0.39 0.3 0.28 0.38]);
line2 = plot(X_6h_2,Y_6h_2,'b--','linewidth',2);
hold on 
plot(GI_a_day_all_6h,GI_diff_6h,'k.')
hold off
set(gca,'ylim',[0 0.4])
set(gca,'xlim',[0.5 1])

legend(line2,['y = ',num2str(bbb2_6h(2)),'x + ',num2str(bbb2_6h(1)),newline,['            R^2 = ',num2str(floor(stats_6h(1)*100)/100)]],'FontSize',15,'FontName','Times New Roman')

% 强制保留小数位数
cb_tick = get(ax2,'ytick');
Tick_label = cell(1,length(cb_tick));
for j = 1 : length(cb_tick)
    Tick_label{1,j} = num2str(roundn(cb_tick(j),-2),'%4.2f');
end
set(ax2,'yticklabel',[])

cb_tick = get(ax2,'xtick');
Tick_label = cell(1,length(cb_tick));
for j = 1 : length(cb_tick)
    Tick_label{1,j} = num2str(roundn(cb_tick(j),-1),'%4.1f');
end
set(ax2,'xticklabel',Tick_label)

xlabel(['日尺度的降水集中度'],'fontname','宋体','fontsize',20)

ax3 = axes('pos',[0.7 0.3 0.28 0.38]);
line3 = plot(X_12h_2,Y_12h_2,'b--','linewidth',2);
hold on 
plot(GI_a_day_all_12h,GI_diff_12h,'k.')
hold off
set(gca,'ylim',[0 0.4])
set(gca,'xlim',[0.5 1])

legend(line3,['y = ',num2str(bbb2_12h(2)),'x + ',num2str(bbb2_12h(1)),newline,['            R^2 = ',num2str(floor(stats_12h(1)*100)/100)]],'FontSize',15,'FontName','Times New Roman')

% 强制保留小数位数
cb_tick = get(ax3,'ytick');
Tick_label = cell(1,length(cb_tick));
for j = 1 : length(cb_tick)
    Tick_label{1,j} = num2str(roundn(cb_tick(j),-2),'%4.2f');
end
set(ax3,'yticklabel',[])

cb_tick = get(ax3,'xtick');
Tick_label = cell(1,length(cb_tick));
for j = 1 : length(cb_tick)
    Tick_label{1,j} = num2str(roundn(cb_tick(j),-1),'%4.1f');
end
set(ax3,'xticklabel',Tick_label)

set(ax2,'fontsize',15)
set(ax1,'fontsize',15)
set(ax3,'fontsize',15)
set(ax2,'linewidth',1.5)
set(ax1,'linewidth',1.5)
set(ax3,'linewidth',1.5)



axes('visible','off');
text('string','(a)','Units','normalized','position',[-0.04,0.28],'fontsize',20,'FontName','times new roman')
text('string','(b)','Units','normalized','position',[0.36,0.28],'fontsize',20,'FontName','times new roman')
text('string','(c)','Units','normalized','position',[0.76,0.28],'fontsize',20,'FontName','times new roman')

cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\999-01-try-different-time-scale-compare\实际日降水数据实验\')
exportgraphics(gcf,'多个时间尺度转换关系图.jpg')

% %% 尝试从降水数据出发
% %% 提取升尺度得到的日尺度年降水序列
% %% 填充到3-hour尺度，两种情况，一种全部填0，则是每一天都是最集中的情况（集中在日内的第一个3h）
% %% 第二种情况是将降水日数乘8，然后用全年3h时段数减掉，剩下的填0，而每一日的降水平均分成8份
% %% 两种情况都非常极端，实际情况应该是非常多样的
%
%
% clear;clc;
%
% % 1d 时间尺度
% cd('J:\6-硕士毕业论文\1-Data\CMFD\0-from-paper2\1d\pre\')
% load('pre4(1d)_2000.mat') %单位为mm/h,预处理了0.1mm/h
% % % 验证单位
% a1 = sum(pre_1d_preprocessing01_year,3);
% % [xx,yy] = meshgrid(Lon,Lat);
% % figure
% % pcolor(xx,yy,a1'*24)
% % colorbar
%
% % 3h 时间尺度
% cd('J:\6-硕士毕业论文\1-Data\CMFD\1-origin-data-3h\Pre')
% load('pre1_3h_no_preprocessing_2000.mat')
% pre_3h_noprocessing(pre_3h_noprocessing < 0.1) = 0;
% pre_3h_01processing = pre_3h_noprocessing;
% clear pre_3h_noprocessing
%
% %%
% kk = find(~isnan(a1));
% GI_1 = nan(length(kk),1);
% GI_3 = nan(length(kk),1);
% Zeros_add_1 = nan(length(kk),1);
% Zeros_add_2 = nan(length(kk),1);
% for m = 1 : length(kk)
%     [I,J] = ind2sub([size(a1,1),size(a1,2)],kk(m));
%     pre_day_test = reshape(pre_1d_preprocessing01_year(I,J,:),[1,size(pre_1d_preprocessing01_year,3)]);
%     % 转单位为mm
%     pre_day_test = pre_day_test*24;
% %     figure
% %     plot(1:length(pre_day_test),pre_day_test)
%
%     pre_day_turn_3h_test = nan(1,size(pre_3h_01processing,3));
%     % 第一种情况，有雨的天数超平均分布，其余均填0
%     for i = 1:length(pre_day_test)
%         if pre_day_test(i) == 0
%             pre_day_turn_3h_test((i-1)*8 + 1 : i*8 ) = zeros(1,8);
%         else
%             pre_dreadfull_even = zeros(1,8);
%             pre_dreadfull_even = pre_dreadfull_even + pre_day_test(i)/8;
%             pre_day_turn_3h_test((i-1)*8 + 1 : i*8 ) = pre_dreadfull_even;
%             clear pre_dreadfull_even
%         end
%     end
%
%     % figure
%     % plot(1:length(pre_day_turn_3h_test),pre_day_turn_3h_test)
%
%     % 第二种情况，有雨的天数超集中分布
%     % pre_day_turn_3h_test_2 = nan(1,size(pre_3h_01processing,3));
%     %
%     % for i = 1:length(pre_day_test)
%     %     if pre_day_test(i) == 0
%     %         pre_day_turn_3h_test_2((i-1)*8 + 1 : i*8 ) = zeros(1,8);
%     %     else
%     %         pre_day_turn_3h_test_2((i-1)*8 + 1) = pre_day_test(i);
%     %         pre_day_turn_3h_test_2((i-1)*8 + 2 : i*8) = 0;
%     %     end
%     % end
%     % figure
%     % plot(1:length(pre_day_turn_3h_test_2),pre_day_turn_3h_test_2)
%
%     % 这里证明在哪里加0，最后都不影响基尼系数计算
%     pre_day_turn_3h_test_3 = zeros(1,size(pre_3h_01processing,3));
%     pre_day_turn_3h_test_3(1:length(pre_day_test)) = pre_day_test;
%
%     GI_1(m) = ginicoeff(pre_day_turn_3h_test,2,true);
%     GI_3(m) = ginicoeff(pre_day_turn_3h_test_3,2,true);
%
%     % 第一种情况加0的数量 = 全年3h时段数 - 降水天数*8
%     aa = find(pre_day_test > 0);
%     Zeros_add_1(m) = size(pre_3h_01processing,3) - length(aa) * 8;
%
%     % 第二种情况加0的数量 = 全年3h时段数 - 降水天数
%     Zeros_add_2(m) = size(pre_3h_01processing,3) - length(aa);
%
%
%     clear I J pre_day_test pre_day_turn_3h_test pre_day_turn_3h_test_3 aa
%
% end
%
%
%
% figure
% plot(Zeros_add_1,GI_1,'.')
% figure
% plot(Zeros_add_2,GI_3,'.')
%
% % 计算两者的差值
%
% Zeros_add_diff = Zeros_add_2 - Zeros_add_1;
% GI_diff = GI_3 - GI_1;
% figure
% plot(Zeros_add_diff,GI_diff,'.')
%
%
% %% 对应的3h数据情况
% pre_3h_test = reshape(pre_3h_01processing(I,J,:),[1,size(pre_3h_01processing,3)]);
% figure
% plot(1:length(pre_3h_test),pre_3h_test*3)
%
%
% %% 不同情况的基尼系数
%
% GI_2 = ginicoeff(pre_day_turn_3h_test_2,2,true);
%
% GI_3h =ginicoeff(pre_3h_test*3,2,true);
