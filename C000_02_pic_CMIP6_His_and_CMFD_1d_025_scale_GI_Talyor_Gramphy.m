%% 这个文件根据历史时期模型计算得到的基尼系数与CMFD的基尼系数
%% 计算多年平均值
%% 研究时段为1985-2014
%% 画泰勒图
%% 用来描述空间上模拟效果的优秀性，所以使用多年平均（与杜师兄的做法一致）

clear;clc;

% 读取CMFD整合到0.25°上的经纬度坐标
filename2 = 'CMFD_1d_Gini_025_scale_01mmh_1979_2018_from_Paper2.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\0-from-paper2\',filename2])
[xx_025,yy_025] = meshgrid(Lon_025,Lat_025);
xx_025 = xx_025';
yy_025 = yy_025';

% 研究时段为1985-2014
Gini_CMFD_1d_025_scale_01mmh_1985_2014 = Gini_CMFD_1d_025_scale_01mmh(:,:,7:end-4);
clear Gini_CMFD_1d_025_scale_01mmh

% 两种数据源的结果组织格式不太一样，计算RMSE需要先转置
Gini_CMFD_1d_025_scale_01mmh_rev = nan(length(Lon_025),length(Lat_025),size(Gini_CMFD_1d_025_scale_01mmh_1985_2014,3));

for year = 1 : size(Gini_CMFD_1d_025_scale_01mmh_1985_2014,3)
    b = Gini_CMFD_1d_025_scale_01mmh_1985_2014(:,:,year);
    Gini_CMFD_1d_025_scale_01mmh_rev(:,:,year) = b';
    clear  b
end
clear Gini_CMFD_1d_025_scale_01mmh_1985_2014

% % 为时间序列准备的，在空间上求平均
% Gini_CMFD_1d_025_scale_01mmh_rev_2D = reshape(Gini_CMFD_1d_025_scale_01mmh_rev,[],size(Gini_CMFD_1d_025_scale_01mmh_rev,3));
% Gini_CMFD_1d_025_scale_01mmh_rev_timeseries = nanmean(Gini_CMFD_1d_025_scale_01mmh_rev_2D,1);
% clear Gini_CMFD_1d_025_scale_01mmh_rev_2D

% 为泰勒图准备的，在时间上求平均
Gini_CMFD_1d_025_scale_01mmh_rev_mean = nanmean(Gini_CMFD_1d_025_scale_01mmh_rev,3);
clear Gini_CMFD_1d_025_scale_01mmh_rev
Gini_CMFD_1d_025_scale_01mmh_rev_Latmean = nanmean(Gini_CMFD_1d_025_scale_01mmh_rev_mean,1);
Gini_CMFD_1d_025_scale_01mmh_rev_mean_line = reshape(Gini_CMFD_1d_025_scale_01mmh_rev_mean,[1,size(Gini_CMFD_1d_025_scale_01mmh_rev_mean,1)*size(Gini_CMFD_1d_025_scale_01mmh_rev_mean,2)]);
clear Gini_CMFD_1d_025_scale_01mmh_rev_mean

% 读取模型数据
model_name = {'MPI-ESM1-2-HR','IITM-ESM','NorESM2-LM','NorESM2-MM','MIROC6','TaiESM1','MPI-ESM1-2-LR','BCC-CSM2-MR','MRI-ESM2-0','CanESM5'};
save_path_1 = 'J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2018-2058\7-5-His-pr-025-scale-Gini\';
cd(save_path_1)

for i = 1 : length(model_name) % 选择模式读取数据
    filename = [model_name{i},'_1d_Gini_025_scale_1975_2014.mat'];
    load(filename)
    clear filename
    
    % 只保留1985-2014
    Model_His_Gini = Model_His_Gini(:,:,11:end);
    
    % 为时间序列准备
    %     Model_His_Gini_2D = reshape(Model_His_Gini,[],size(Model_His_Gini,3));
    %     eval(['Model_His_Gini_Timeseries',num2str(i),' = nanmean(Model_His_Gini_2D,1);'])
    %     clear Model_His_Gini_2D
    Model_His_Gini_mean = nanmean(Model_His_Gini,3);
    eval(['Model_His_Gini_mean_Latmean',num2str(i),' = nanmean(Model_His_Gini_mean,1);'])
    eval(['Model_His_Gini_mean_line_',num2str(i),' = reshape(Model_His_Gini_mean,[1,size(Model_His_Gini_mean,1)*size(Model_His_Gini_mean,2)]);'])
    clear Model_His_Gini Model_His_Gini_mean
end

cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\000-01-CMIP6-His-and-CMFD-GI-RMSE\')
% % exportgraphics(gcf,'RMSE_boxchart.jpg')
% exportgraphics(gcf,'RMSE_boxchart_without_name.jpg')

% 泰勒图的数据准备，必须去除里面所有的nan
data2 = nan(11,length(Gini_CMFD_1d_025_scale_01mmh_rev_mean_line));
data2(1,:) = Gini_CMFD_1d_025_scale_01mmh_rev_mean_line;
for i = 2 : size(data2,1)
    eval(['data2(i,:) = Model_His_Gini_mean_line_',num2str(i-1),';'])
end
kk = nan(size(data2));
clear i
for i = 1 : size(data2,1)
    aa = find(isnan(data2(i,:)));
    kk(i,1:length(aa)) = aa;
    clear aa
end
kk_2 = kk;
kk_2(isnan(kk)) = [];
index_nan = unique(kk_2);

clear i
Data = nan(size(data2,1),size(data2,2)- length(index_nan));
for i = 1 : size(data2,1)
    aa = data2(i,:);
    aa(index_nan) = [];
    Data(i,:) = aa;
    clear aa
end
Data = Data';
% clear i
% for i = 1 : size(data2,1)
%     aa = BUOY(i,:);
%
%     Standard_Division(i,1) = std(aa);
% end
% % 标准差范围为 0 - 0.12
%

%% 画图
% 这里改成时间上的平均RMSE
clear filename2
filename2 = 'RMSE_CMFD_and_CMIP6_model_GI_025_scale.mat';
load(['J:\6-硕士毕业论文\1-Data\CMIP6-Tas-Pr-2018-2058\',filename2])

% 求每个模型的平均值
RMSE_01mmh_025_scale_mean_all = nan(5,10);
for i = 1: length(model_name) % 选择模式读取数据
eval(['RMSE_01mmh_025_scale_mean_all(1,i) = nanmean(nanmean(RMSE_01mmh_025_scale_',num2str(i),',1));'])
end

% 引入气候区
clear i
load('J:\6-硕士毕业论文\1-Data\Climate_zone_index\Four_Climite_zone_index_025_scale.mat')
for m = 1 : 4
    k1 = find(Four_climate_zone_index_025 == m); % 查找气候区索引
    for i = 1 : length(model_name)
        eval(['RMSE_climate = RMSE_01mmh_025_scale_',num2str(i),'(k1);'])
        RMSE_01mmh_025_scale_mean_all(m+1,i) = nanmean(nanmean(RMSE_climate,1));
        clear RMSE_climate
    end
end




% % 时间序列相关系数的蛛网图
% Latmean_PCCs = nan(1,10);
% for i = 1 : size(Latmean_PCCs,2)
%     a = Gini_CMFD_1d_025_scale_01mmh_rev_Latmean;
%     eval(['b = Model_His_Gini_mean_Latmean',num2str(i),';']) 
%     % 互相去掉nan
%     k1 = find(isnan(a));
%     k2 = find(isnan(b));
%     
%     k = [k1,k2];
%     a(k) = [];
%     b(k) = [];
%     
%     aa = corrcoef(a,b);
%     Latmean_PCCs(1,i) = aa(2);
%     clear aa a b k k1 k2
% end


% 画时间维度方面的RMSE的蛛网图 
figure('Position', [1, 1, 1000, 1000],'paperpositionmode','auto');
P = RMSE_01mmh_025_scale_mean_all*10000;    
% Spider plot
spider_plot(P,...
    'AxesLimits', [ones(1,10)*240; ones(1,10)*1060],...
    'AxesLabels',model_name ,...
    'AxesInterval', 4,...
    'AxesDisplay', 'one',...
    'FillOption', 'on',...
    'AxesRadial', 'on',...
    'AxesLabelsOffset', 0.1,...
    'AxesDataOffset', 0.1,...
    'AxesWebType', 'circular',...
    'AxesFontColor', 'b');
text('string','(a)','Units','normalized','position',[0,1],  'FontSize',25,'FontName','Times New Roman')
legend('中国区域', '湿润区', '过渡区', '干旱区', '高寒区', 'Location', 'northeastoutside','Fontname','宋体','Fontsize',20);
%%
cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\000-01-CMIP6-His-and-CMFD-GI-RMSE\')
exportgraphics(gcf,'Spider_plot_of_Lat_Cor.jpg')


%% 参考 https://www.yii666.com/blog/480029.html

% Calculate STD RMSD and COR(计算标准差、中心均方根误差、相关系数)
STATS = zeros(4,size(Data,2));
for i = 1:size(Data,2)
    STATS(:,i) = SStats(Data(:,1),Data(:,i));
end
STATS(1,:) = [];

% Create taylor axes(生成泰勒图坐标区域)
figure('Position', [1, 1, 900, 900],'paperpositionmode','auto');
TD = STaylorDiag(STATS);

RGB = cbrewer('div','Spectral',size(Data,2),'linear');
% colorList = [0.3569    0.0784    0.0784
%     0.6784    0.4471    0.1725
%     0.1020    0.3882    0.5176
%     0.1725    0.4196    0.4392
%     0.2824    0.2275    0.2902
%     0.2824    0.2275    0.2902];
MarkerType={'o','^','*','x','s','.','p','h','+','d','>','<'};
% Plot(绘制散点图)
for i = 1:size(Data,2)
    TD.SPlot(STATS(1,i),STATS(2,i),STATS(3,i),'Marker',MarkerType{i},'MarkerSize',15,...
        'Color','k','MarkerFaceColor',RGB(i,:));
end

% Legend
NameList = cell(11,1);
NameList{1} = 'CMFD';
NameList(2:end,1) = model_name;
lgd = legend(NameList,'FontSize',13,'FontName','Times New Roman','location','northeast');
set(lgd,...
    'Position',[0.777611098066803 0.65361110125565 0.217777772976293 0.291111102733347],...
    'FontSize',15,...
    'FontName','Times New Roman');

% Annotation (第一列为基准，观测值)
TD.SText(STATS(1,1),STATS(2,1),STATS(3,1),{'';'CMFD'},'FontWeight','bold',...
    'FontSize',20,'FontName','Times New Roman','Color',RGB(1,:),...
    'VerticalAlignment','top','HorizontalAlignment','center')

TD.SText(STATS(1,1),STATS(2,1),STATS(3,1),{'RMSD';''},'FontWeight','bold',...
    'FontSize',20,'FontName','Times New Roman','Color',[.77,.6,.18],...
    'VerticalAlignment','bottom','HorizontalAlignment','center')

% % 为每一个点加标注
% for i = 1:size(Data,2)
%     TD.SText(STATS(1,i),STATS(2,i),STATS(3,i),"   "+string(NameList{i}),'FontWeight','bold',...
%     'FontSize',8,'FontName','Times New Roman',...
%     'VerticalAlignment','middle','HorizontalAlignment','right')
% end

% 修改刻度长度
TD.set('TickLength',[.01,.02])

% 修改坐标轴范围
TD.set('SLim',[0,0.12])
TD.set('RLim',[0,0.2])

% 修改主刻度值和次刻度值
TD.set('STickValues',0:0.02:0.12)
TD.set('SMinorTickValues',0:0.02:0.12) % 次刻度，不标注
TD.set('RTickValues',0.02:0.02:0.1)
TD.set('CTickValues',[.1,.2,.3,.4,.5,.6,.7,.8,.9,.95,.99])

% Set Grid(修饰各个网格)
TD.set('SGrid','Color',[.7,.7,.7],'LineWidth',1.5)
TD.set('RGrid','Color',[.77,.6,.18],'LineWidth',1.5)
TD.set('CGrid','Color',[0,0,.8],'LineStyle',':','LineWidth',.8);

% Set Tick Label(修饰刻度标签)
% TD.set('STickLabelX','Color',[.8,0,0],'FontWeight','bold')
% TD.set('STickLabelY','Color',[.8,0,0],'FontWeight','bold')
TD.set('RTickLabel','Color',[.77,.6,.18],'Fontsize',15,'FontWeight','bold')
TD.set('CTickLabel','Color',[0,0,.8],'Fontsize',15,'FontWeight','bold')

% Set Label(修饰标签)
% TD.set('SLabel','Color',[.8,0,0],'FontWeight','bold')
TD.set('CLabel','Color',[0,0,.8],'FontWeight','bold')

% Set Axis(修饰各个轴)
% TD.set('SAxis','Color',[.8,0,0],'LineWidth',1)
TD.set('CAxis','Color',[0,0,.8],'LineWidth',1)

% Set Tick and MinorTick(修饰主次刻度)
% TD.set('STick','Color',[.8,0,0],'LineWidth',8)
% TD.set('CTick','Color',[0,0,.8],'LineWidth',8)
% TD.set('SMinorTick','Color',[.8,0,0],'LineWidth',5)
% TD.set('CMinorTick','Color',[0,0,.8],'LineWidth',5)

% Set Tick and MinorTick(修饰主次刻度)
TD.set('STick','Color','k','LineWidth',1)
TD.set('CTick','Color','k','LineWidth',1)
TD.set('SMinorTick','Color','k','LineWidth',0.5)
TD.set('CMinorTick','Color','k','LineWidth',0.5)

text('string','(b)','Units','normalized','position',[-0.12,1.05],  'FontSize',25,'FontName','Times New Roman')
%%
cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\000-01-CMIP6-His-and-CMFD-GI-RMSE\')
% % exportgraphics(gcf,'RMSE_boxchart.jpg')
exportgraphics(gcf,'Tayor_plot.jpg')





% %% 参考代码1：https://blog.csdn.net/qq_44246618/article/details/129209872
% % Get statistics from time series:
% for ii = 2:size(BUOY,1)
%     C = allstats(BUOY(1,:),BUOY(ii,:));
%     statm(ii,:) = C(:,2);
% end
% statm(1,:) = C(:,1);
% 
% figureUnits = 'centimeters';
% figureWidth = 30; 
% figureHeight = 12;
% 
% figure(1)
% set(gcf, 'Units', figureUnits, 'Position', [0 0 figureWidth figureHeight]);
% [pp tt axl] = taylordiag(squeeze(statm(:,2)),squeeze(statm(:,3)),squeeze(statm(:,4)),...
%             'tickRMS',[0:0.02:0.12],'titleRMS',1,'tickRMSangle',116,'showlabelsRMS',1,'widthRMS',0.5,...
%             'tickSTD',[0:0.02:0.12],'limSTD',0.12,...
%             'tickCOR',[.1:.1:.9 .95 .99 1],'showlabelsCOR',1,'titleCOR',1);
%         
% ID = cell(length(model_name)+1,1);
% ID{1} = 'CMFD';
% ID(2:end,1) = model_name;
% label = ID;
% legend(ID,'FontSize',13,'FontName','Times New Roman')

% for ii = 1 : length(tt)
% %     set(tt(ii),'fontsize',12,'fontweight','bold')% 调整每个点上的字体标注大小
%     set(pp(ii),'markersize',12,'color','b') % 这里调整点的颜色
% %     if ii == 1
% %         set(tt(ii),'String','Buoy');
% %     else
% %         set(tt(ii),'String',alphab(ii-1)); % 调整每个点上的字体标注大小,改成空引号就可以去掉
% %     end
%     set(tt(ii),'String',ID(ii))
% end
% % title(sprintf('%s: Taylor Diagram at CLIMODE Buoy','B'),'fontweight','bold','FontSize',12,'FontName','Times New Roman');
% % 
% % tt = axl(2).handle;
% % for ii = 1 : length(tt)
% %     set(tt(ii),'fontsize',10,'fontweight','normal','FontSize',12,'FontName','Times New Roman');
% % end
% % set(axl(1).handle,'fontweight','normal','FontSize',12,'FontName','Times New Roman');
% % set(gca,'FontSize',12,'Fontname', 'Times New Roman');
% % set(gca,'Layer','top');
% 
% % str= strcat(pathFigure, "Fig.1", '.tiff');
% % print(gcf, '-dtiff', '-r600', str);
