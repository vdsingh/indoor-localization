function [radar1_time_sync, radar2_time_sync] = time_sync1(radar1_data,radar1_time_stamps, radar1_range_bins, radar2_data, radar2_time_stamps, radar2_range_bins, threshold)
% here I will create the time window, by which radars can be synced

% threshold = 50000;

% format long e
% dataDir = [pwd,'/data/'];

% load participant 1 diagonal time stamps from radar 109 and 103
% time_stamps_109 = importdata([dataDir 'Localization/' 'participant1/' '109/' 'diag/' 'T_stmp' '.mat']);
% time_stamps_103 = importdata([dataDir 'Localization/' 'participant1/' '103/' 'diag/' 'T_stmp' '.mat']);

% range_bins_109 = importdata([dataDir 'Localization/' 'participant1/' '109/' 'diag/' 'range_bins' '.mat']);
% range_bins_103 = importdata([dataDir 'Localization/' 'participant1/' '103/' 'diag/' 'range_bins' '.mat']);

common_time_stamps = intersect(radar1_time_stamps, radar2_time_stamps);

% here we are simply concatenating the time stamps onto our data.
radar1_time_sync = [radar1_data radar1_time_stamps.'];
radar2_time_sync = [radar2_data radar2_time_stamps.'];

% keep only the data points at times when both radars collected data simultaneously
radar1_time_sync(ismember(radar1_time_sync(:, end), common_time_stamps) == 0, :) = [];
radar2_time_sync(ismember(radar2_time_sync(:, end), common_time_stamps) == 0, :) = [];

radar1_time_sync = radar1_time_sync(:, 1:end-1);
radar2_time_sync = radar2_time_sync(:, 1:end-1);


% radar1_time_sync = radar1_data_with_times(:, 1:end-1);
% radar2_time_sync = radar2_data_with_times(:, 1:end-1);
% 
% valid_values_radar1 = [];
% valid_values_radar2 = [];
% 
% for a = 1:size(common_time_stamps, 2)
%     radar1_row = radar1_data_with_times(a, 1:end-1);
%     radar2_row = radar2_data_with_times(a, 1:end-1);
% 
%     first_index_radar1 = find(radar1_row >= threshold, 1);
%     first_index_radar2 = find(radar2_row >= threshold, 1);
% 
%     if size(first_index_radar1, 2) == 0
%         first_value_radar1 = 0;
%     else
%         first_value_radar1 = radar1_range_bins(first_index_radar1);
%     end
% 
%     if size(first_index_radar2, 2) == 0
%         first_value_radar2 = 0;
%     else
%         first_value_radar2 = radar2_range_bins(first_index_radar2);
%     end
%     valid_values_radar1 = [valid_values_radar1 first_value_radar1];
%     valid_values_radar2 = [valid_values_radar2 first_value_radar2];
% end
% clearvars a p1_109_diag_with_times p1_103_diag_with_times first_valid_value_103 first_valid_value_109 first_valid_value_index_103 first_valid_value_109


% radar1_time_sync_with_ranges = [common_time_stamps.' valid_values_radar1.'];
% radar2_time_sync_with_ranges = [common_time_stamps.' valid_values_radar2.'];

% radar1_time_sync_with_ranges(radar1_time_sync_with_ranges(:,2) == 0 || radar2_time_sync_with_ranges(:,2) == 0, :) = [];
% radar2_time_sync_with_ranges(radar1_time_sync_with_ranges(:,2) == 0 || radar2_time_sync_with_ranges(:,2) == 0, :) = [];

% radar1_time_sync_with_ranges = 0;
% radar2_time_sync_with_ranges(radar2_time_sync_with_ranges(:,2) == 0, :) = [];

% 
% center_103 = [0,0];
% center_109 = [1.016, 0];
% 
% room_measurement = 4.04;
% 
% x_vals = [];
% y_vals = [];

% indices = [];
% for k = 1:size(radar1_time_sync_with_ranges, 1)
%     if(radar1_time_sync_with_ranges(k, 2) == 0 || radar2_time_sync_with_ranges(k, 2) == 0)
%          indices = [indices k];
%         radar1_time_sync_with_ranges(k, :) = [];
%         radar2_time_sync_with_ranges(k, :) = [];
%         k = k-1;
%     end
%     disp(p1_103_diag_min_values(k, 2));
%     [x_intersect, y_intersect] = circcirc(center_103(1), center_103(2), p1_103_diag_min_values(k, 2), center_109(1), center_109(2), p1_109_diag_min_values(k, 2));
 
%     if(size(x_intersect, 2) == 2)
%         if(x_intersect(1) >= 0 && x_intersect(1) <= room_measurement && y_intersect(1) >= 0 && y_intersect(1) <= room_measurement)
%             x_intersect = x_intersect(1);
%             y_intersect = y_intersect(1);
%             x_vals = [x_vals x_intersect];
%             y_vals = [y_vals y_intersect];
%         elseif (x_intersect(2) >= 0 && x_intersect(2) <= room_measurement && y_intersect(2) >= 0 && y_intersect(2) <= room_measurement)
%             x_intersect = x_intersect(2);
%             y_intersect = y_intersect(2);
%             x_vals = [x_vals x_intersect];
%             y_vals = [y_vals y_intersect];
%         else 
%             disp([p1_103_diag_min_values(k, 2) p1_109_diag_min_values(k, 2)]);
%         end
%     end
   
% endz/

% radar1_time_sync_with_ranges(indices, :) = [];
% radar2_time_sync_with_ranges(indices, :) = [];

% clearvars y_intersect x_intersect

% ground truth
% x = 0.762:0.01:1.98;
% y = 0.9652:0.01:3.40;


% figure();
% 
% % x = ;
% % y = ;
% % left = ;
% scatter(x_vals, y_vals, 'filled');
% 
% hold on
% plot(x_vals, y_vals, linspace(0.762, 1.98), linspace(0.9652, 3.40), linspace(0, 4.04), zeros(100), zeros(100), linspace(0, 4.04),linspace(0, 4.04), zeros(100)+4.04, zeros(100)+4.04, linspace(0, 4.04));
% hold off
% % points = scatter(x_vals, y_vals);
% 
% % plot(x_vals, y_vals);
% % x = 
% % plot(x,x,'-');








end

