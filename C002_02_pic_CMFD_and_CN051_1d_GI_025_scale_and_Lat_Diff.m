%% 这个文件根据升尺度后的CMFD计算得到的基尼系数
%% 以及CN051计算得到的基尼系数
%% 画其多年平均的空间分布图
%% 并且在纬度方向上做平均，画二维线图
%% 研究时段为1985-2014
%% 说明CMFD结果与CN051接近，而且分辨率提高，结果可信度高

clear;clc;

% CN051
% 0.1 mm/h
filename2 = 'CN051_Daily_Gini_1979_2018_01mmh.mat';
load(['J:\6-硕士毕业论文\1-Data\CN051-TM-Pre-1979-2018\3-CN051-Pr-Gini&LinearTrend\',filename2]);
Gini_CN051 = Gini_CN051(:,:,7:end-4);
Gini_CN051_01mmh_mean = nanmean(Gini_CN051,3);
Lon_CN051 = Lon;
Lat_CN051 = Lat;
clear Gini_CN051

% 升尺度的CMFD
% 读取CMFD整合到0.25°上的经纬度坐标
filename2 = 'CMFD_1d_Gini_025_scale_01mmh_1979_2018_from_Paper2.mat';
load(['J:\6-硕士毕业论文\1-Data\CMFD\0-from-paper2\',filename2])
Gini_CMFD_1d_025_scale_01mmh_1985_2014 = Gini_CMFD_1d_025_scale_01mmh(:,:,7:end-4);
clear Gini_CMFD_1d_025_scale_01mmh
Gini_CMFD_01mmh_mean = nanmean(Gini_CMFD_1d_025_scale_01mmh_1985_2014,3);
Gini_CMFD_01mmh_mean = Gini_CMFD_01mmh_mean';
clear Gini_CMFD_1d_025_scale_01mmh_1985_2014 

% 针对纬度求平均
Gini_CN051_01mmh_meanLat = nanmean(Gini_CN051_01mmh_mean,1);
Gini_CMFD_01mmh_meanLat = nanmean(Gini_CMFD_01mmh_mean,1);

a1 = max([Gini_CN051_01mmh_meanLat,Gini_CMFD_01mmh_meanLat]);
b1 = min([Gini_CN051_01mmh_meanLat,Gini_CMFD_01mmh_meanLat]);

% CN051是没有台湾岛的，这里要独立开两个shp0
% 这里改换的地图用于裁剪数据，去除掉TW岛
shp0_1 = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\China_map_without_TW\bou1_4p_without_TW.shp');
shp0_2 = shaperead('J:\4-论文备份\论文代码2021.4.14\map\bou1_4p.shp');

shp = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\基于审图号GS(2019)1822号新制作的底图\新国界_无东沙赤尾钓鱼_需和Chinaline连用.shp');
shp1 = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\基于审图号GS(2019)1822号新制作的底图\New_China_line.shp');
shp2 = shaperead('F:\File_of_MATLAB\6-硕士毕业论文\6-map\基于审图号GS(2019)1822号新制作的底图\Dongsha_Chiwei_Diaoyu.shp');
% 读取4个气候区的线shp图，叠加在绘图上
shp_line_HR = shaperead('F:\File_of_MATLAB\关于3h尺度的CMFD降水数据研究2022.3.2\New climate seperate method from Du\湿润区\shiRunQu_Line.shp');
shp_line_TR = shaperead('F:\File_of_MATLAB\关于3h尺度的CMFD降水数据研究2022.3.2\New climate seperate method from Du\过渡区\guoDuQu_Line.shp');
shp_line_AR = shaperead('F:\File_of_MATLAB\关于3h尺度的CMFD降水数据研究2022.3.2\New climate seperate method from Du\干旱区\ganHanQu_Line.shp');
shp_line_TP = shaperead('F:\File_of_MATLAB\关于3h尺度的CMFD降水数据研究2022.3.2\New climate seperate method from Du\高寒区\qingZangGaoYuanQu_Line.shp');

Z1 = Gini_CN051_01mmh_mean;
Z2 = Gini_CMFD_01mmh_mean;
mask_CN_GI_and_LatDiff(Lon,Lat,Z1,Z2,shp0_1,shp0_2,shp,shp1,shp2,0.7,1,6,shp_line_HR,shp_line_TR,shp_line_AR,shp_line_TP)
cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\002-03-02-Lat-Diff-CMFD_and-CN051-Gi-025-scale\')
exportgraphics(gcf,'CMFD_and_CN051_1d_GI_025_scale_and_Latitude_Difference.jpg')



% %%
% Fig = figure('Units','centimeter','Position',[5 5 15 20]);
% set (gca,'position',[0.3,0.15,0.45,0.8] );
% 
% plot(Lat_CN051,Gini_CMFD_01mmh_meanLat,'r.--','linewidth',3)
% hold on
% plot(Lat_CN051,Gini_CN051_01mmh_meanLat,'k.--','linewidth',3)
% hold off
% ylim([0.75 1])
% set(gca,'ytick',0.75:0.05:1)
% 
% % 强制保留纵坐标为2位小数
% tick2 = get(gca,'ytick');
% ticklabel2 = cell(1,length(tick2));
% for i = 1 : length(ticklabel2)
%     ticklabel2{1,i} = num2str(roundn(tick2(i),-2),'%4.2f');
% end
% set(gca,'yticklabel',ticklabel2)
% set(gca,'linewidth',2)
% set(gca,'fontsize',25)
% 
% xlabel('纬度(\circN)','FontName', '微软雅黑','Fontsize',25)
% ylabel('GI','FontName', 'Times New Roman','Fontsize',26)
% set(gca,'xdir','reverse')
% % 让图形竖起来
% view(-90, 90)
% set(gca, 'ydir', 'reverse');
% 
% k1 = find(isnan(Gini_CMFD_01mmh_meanLat));
% k2 = find(isnan(Gini_CN051_01mmh_meanLat));
% k3 = unique([k1,k2]);
% 
% a = Gini_CMFD_01mmh_meanLat;
% b = Gini_CN051_01mmh_meanLat;
% a(k3) = [];
% b(k3) = [];
% aaa = corrcoef(a,b);
% 
% text('string',['相关系数: ',num2str(roundn(aaa(2),-2),'%4.2f')],'Units','normalized','position',[0.8,0.08],'fontsize',26,'FontName','微软雅黑')
% legend('CMFD','CN051','FontName', 'Times New Roman','NumColumns',1,'fontsize',26,'location','northeast')
%    
% % cd('F:\File_of_MATLAB\6-硕士毕业论文\4-pic\002-03-02-Lat-Diff-CMFD_and-CN051-Gi-025-scale\')
% % exportgraphics(gcf,'CMFD_and_CN051_Latitude_Difference.jpg')


