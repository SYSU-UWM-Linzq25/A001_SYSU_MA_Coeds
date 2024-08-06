%% 这个文件找到Eva的基尼系数的多年平均在中国北边出现nan的情况

clear;clc;

load('J:\6-硕士毕业论文\1-Data\GLEAM-V3.8a-025-scale\GLEAM_SMsurf_1d_Gini_1985_2014.mat')
load('J:\6-硕士毕业论文\1-Data\GLEAM-V3.8a-025-scale\GLEAM_Eva_1d_Gini_1985_2014.mat')

% 多年平均
Gini_1d_Eva_GLEAM_mean = nanmean(Gini_1d_Eva_GLEAM,3);
Gini_1d_SMsurf_GLEAM_mean = nanmean(Gini_1d_SMsurf_GLEAM,3);
clear Gini_1d_Eva_GLEAM Gini_1d_SMsurf_GLEAM

shp0 = shaperead('J:\4-论文备份\论文代码2021.4.14\map\bou1_4p.shp');


% 提取shp范围
zz = nan(length(shp0),1);
for i = 1: length(shp0)    
    a = length(shp0(i).X);
    zz(i) = a;
end
range = nan(sum(zz),2);
clear cout;
cout = 1;
for i = 1:length(shp0)
    for j = 1:length(shp0(i).X)
        range(cout,1) = shp0(i).X(j);
        range(cout,2) = shp0(i).Y(j);
        cout = cout + 1;
    end
end

% 制作mask
Z = Gini_1d_Eva_GLEAM_mean';
Z1 = Gini_1d_SMsurf_GLEAM_mean';

R=makerefmat('RasterSize',size(Z),'Lonlim',[double(min(Lon_025)) double(max(Lon_025))],'Latlim',[double(min(Lat_025)) double(max(Lat_025))]);
MASK=vec2mtx(range(:,2),range(:,1),Z,R,'filled');
MASK(find(MASK>1))=nan;
MASK(find(MASK==1))=0;

% 缩小画图范围
Z = Z + MASK;
Z1 = Z1 + MASK;

% 寻找有数据的经度方向的端点
clear cout aa;
cout = 1;
for i = 1:length(Z(:,1))
    if sum(isnan(Z(i,:))) ~= length(Z(1,:))
        aa(cout,1) = i;
        cout = cout + 1;
    end
end
% 寻找有数据的纬度方向的端点
clear cout bb;
cout = 1;
for i = 1:length(Z(1,:))
    if sum(isnan(Z(:,i))) ~= length(Z(:,1))
        bb(cout,1) = i;
        cout = cout + 1;
    end
end
% 计算新的范围
[xx,yy] = meshgrid(Lon_025(min(bb):max(bb)),Lat_025(min(aa):max(aa)));
Z = Z(min(aa):max(aa),min(bb):max(bb));
Z1 = Z1(min(aa):max(aa),min(bb):max(bb));

figure
pcolor(xx,yy,Z)
colorbar
title('Eva')

figure
pcolor(xx,yy,Z1)
colorbar
title('SM')

k = find(~isnan(Z1) & isnan(Z));
[I,J] = ind2sub(size(xx),k);

% 找到有问题的经纬度
for i = 1 : length(I)
Lon_proble(i) = xx(I(i),J(i));
Lat_proble(i) = yy(I(i),J(i));
end

%%
cd('J:\6-硕士毕业论文\1-Data\GLEAM-V3.8a-025-scale\Eva\')
filename = ['Eva_CN_025_scale_in_',num2str(2000),'.mat'];
load(filename)
clear Eva_025_scale_year


[xx_025,yy_025] = meshgrid(Lon_025,Lat_025);
xx_025 = xx_025';
yy_025 = yy_025';

xx_025_line = reshape(xx_025,[1,size(xx_025,1)*size(xx_025,2)]);
yy_025_line = reshape(yy_025,[1,size(yy_025,1)*size(yy_025,2)]);

for i = 1 : length(I)
pro_index(i) = find(xx_025_line == Lon_proble(i) & yy_025_line == Lat_proble(i));
end
% 检查有没有找错
Gini_1d_Eva_GLEAM_mean_line = reshape(Gini_1d_Eva_GLEAM_mean,[1,size(Gini_1d_Eva_GLEAM_mean,1)*size(Gini_1d_Eva_GLEAM_mean,2)]);
all(isnan(Gini_1d_Eva_GLEAM_mean_line(pro_index)))

% 检查逐年数据
for year = 1985: 2014
    filename = ['Eva_CN_025_scale_in_',num2str(year),'.mat'];
    load(filename)
    
    Eva_025_scale_2D = reshape(Eva_025_scale_year,[],size(Eva_025_scale_year,3));
    
    Eva_problem_grid = Eva_025_scale_2D(pro_index,:);
    
    G_1D = ginicoeff(Eva_problem_grid,2,true);
end

% 因为GLEAM的实际蒸散发出现了负值，
%在实际应用中，有时会观察到模型输出的蒸发值为负数。

%这种情况通常发生在模型输出的数据范围内，主要是因为模型在估算蒸发时可能受到不确定性、数据误差或模型参数的影响。此外，负的蒸发值可能也反映了在某些地区，由于一些特殊的地表条件或气象情况，实际蒸发量可能低于模型预测的值。

%因此，在使用GLEAM模型输出的数据时，需要谨慎处理负值，并考虑可能的原因。可能需要进一步的验证和分析，以确定负值的来源，并根据实际情况进行调整或修正。