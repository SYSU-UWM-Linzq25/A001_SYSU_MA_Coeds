%% 这个文件将对CMFD两种时间尺度的数据重新进行处理
%% 包括3h尺度和日尺度
%% 考虑润平年
%% 3h
% 这部分的数据已经提取出来了，并且按照月份存储
% 
% clear;clc;
% cd('N:\Data\CMFD\3h原始数据nc\');
% filename = 'prec_ITPCAS-CMFD_V0106_B-01_03hr_010deg_200002.nc';
% nc_info_1 = ncinfo(filename);
% Lat = ncread(filename,'lat');
% Lon = ncread(filename,'lon');
% 
% % 润平年的月索引
% month_index_leap = nan(12,2);
% month_index_noleap = nan(12,2);
% noleapyear_month_day = nan(12,1);
% leapyear_month_day = nan(12,1);
% 
% for i = 1 : 12
%     noleapyear_month_day(i) = eomday(1979,i);
%     leapyear_month_day(i) = eomday(2000,i);
% end
% clear i
% for i = 1 : 12
%     month_index_noleap(i,1) = sum(noleapyear_month_day(1:i-1))*8 + 1;
%     month_index_leap(i,1) = sum(leapyear_month_day(1:i-1))*8 + 1;
%     month_index_noleap(i,2) = sum(noleapyear_month_day(1:i))*8;
%     month_index_leap(i,2) = sum(leapyear_month_day(1:i))*8;
% end
% clear noleapyear_month_day leapyear_month_day
% 
% for year = 1979%:2018
%     pre_3h_noprocessing = nan(length(Lon),length(Lat),(leapyear(year)+365)*8);
%     for month = 1:12
%         if month < 10
%             month2 = ['0',num2str(month)];
%             filename =  ['prec_ITPCAS-CMFD_V0106_B-01_03hr_010deg_',num2str(year),month2,'.nc'];
%         else
%             filename = ['prec_ITPCAS-CMFD_V0106_B-01_03hr_010deg_',num2str(year),num2str(month),'.nc'];
%         end
%         if leapyear(year) == 1
%             pre_3h_noprocessing(:,:,month_index_leap(month,1):month_index_leap(month,2)) = ncread(filename,'prec');
%         else
%             pre_3h_noprocessing(:,:,month_index_noleap(month,1):month_index_noleap(month,2)) = ncread(filename,'prec');
%         end
%         clear filename month2
%     end
%     filename2 = ['pre1_3h_',num2str(year),'.mat'];
%     save(['J:\6-硕士毕业论文\1-Data\CMFD\1-origin-data\',filename2],'pre_3h_noprocessing','Lon','Lat');
%     disp([num2str(year),' is done!'])
%     clear pre_3h_noprocessing filename2
% end

%% 拼合未处理的3h数据，以一年为单位存储
clear;clc;

save_path = 'N:\Data\CMFD\Prec_3h\未预处理\3h\';
cd(save_path)
load('LLT.mat')
path(path,'F:\File_of_MATLAB\6-硕士毕业论文\3-tool\')
Lon = Lon_3h_scale;
Lat = Lat_3h_scale;

for year =1979:2018
    if leapyear(year) ~= 1 
        pre_3h_noprocessing = nan(length(Lon),length(Lat),365*8);
    else
        pre_3h_noprocessing = nan(length(Lon),length(Lat),366*8);
    end
    for month = 1:12
        clear pre_3h_scale_no_preprocessing filename time1 time2;
        if month < 10     
            time1 = begin_time(year,month,3);
            time2 = end_time(year,month,3);
            month = ['0',num2str(month)];
            filename =  ['pre_no_preprocessing',num2str(year),month,'.mat'];
            load(filename)  
            pre_3h_noprocessing(:,:,time1:time2) = pre_3h_scale_no_preprocessing; 
        else
            filename = ['pre_no_preprocessing',num2str(year),num2str(month),'.mat'];
            load(filename)
            time1 = begin_time(year,month,3);
            time2 = end_time(year,month,3);
            pre_3h_noprocessing(:,:,time1:time2) = pre_3h_scale_no_preprocessing; 
        end           
    end
    filename2 = ['pre1_3h_no_preprocessing_',num2str(year),'.mat'];
    save(['J:\6-硕士毕业论文\1-Data\CMFD\1-origin-data-3h\',filename2],'pre_3h_noprocessing','Lon','Lat');
    disp([num2str(year),' is done!'])
    clear pre_3h_noprocessing filename2
end

% %% 日尺度的CMFD数据，并不是自己取平均得来的，是原始数据便是1-day
% %% 这一部分发现结果不如从3h直接升尺度到1-day
% clear;clc;
% cd('N:\Data\CMFD\1d原始数据nc\');
% filename = 'prec_ITPCAS-CMFD_V0106_B-01_01dy_010deg_200001-200012.nc';
% nc_info_1 = ncinfo(filename);
% Lat = ncread(filename,'lat');
% Lon = ncread(filename,'lon');
% 
% for year = 1979 : 2018
%     filename =  ['prec_ITPCAS-CMFD_V0106_B-01_01dy_010deg_',num2str(year),'01-',num2str(year),'12.nc'];
%     pre_1d_noprocessing = ncread(filename,'prec');
%     
%     filename2 = ['pre4_1d_no_preprocessing_',num2str(year),'.mat'];
%     save(['J:\6-硕士毕业论文\1-Data\CMFD\2-origin-data-1d\',filename2],'pre_1d_noprocessing','Lon','Lat');
%     disp([num2str(year),' is done!'])
%     clear pre_1d_noprocessing filename2 filename
% end
% 
% 
% 




