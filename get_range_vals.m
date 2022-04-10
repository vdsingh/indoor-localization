function [radar1_range_vals, radar2_range_vals] = get_range_vals(radar1_time_synced,radar1_range_bins, radar2_time_synced, radar2_range_bins, threshold)
%GET_RANGE_VALS This function gets all of the appropriate ranges that
%radars record. It takes time synced data, finds the first value greater
%than the given threshold, and takes the appropriate range bin. If there is
%no value greater than the threshold, it is stored as 0.
%   Detailed explanation goes here

valid_values_radar1 = [];
valid_values_radar2 = [];

indices_to_remove = [];

for a = 1:size(radar1_time_synced, 1)
    radar1_row = radar1_time_synced(a, 1:end);
    radar2_row = radar2_time_synced(a, 1:end);

%     get the index of the first value in the current row that is greater than the threshold
    first_index_radar1 = find(radar1_row >= threshold, 1);
    first_index_radar2 = find(radar2_row >= threshold, 1);

%     there is no value in this row that is greater than the threshold
    if size(first_index_radar1, 2) ~= 0 && size(first_index_radar2, 2) ~= 0
%         first_value_radar1 = 0;
%         indices_to_remove = [indices_to_remove a];
        first_value_radar1 = radar1_range_bins(first_index_radar1);
        first_value_radar2 = radar2_range_bins(first_index_radar2);

        valid_values_radar1 = [valid_values_radar1 first_value_radar1];
        valid_values_radar2 = [valid_values_radar2 first_value_radar2];
%     else
%         first_value_radar1 = radar1_range_bins(first_index_radar1);
%         first_value_radar2 = radar2_range_bins(first_index_radar2);
% 
%         valid_values_radar1 = [valid_values_radar1 first_value_radar1];
%         valid_values_radar2 = [valid_values_radar2 first_value_radar2];
    end  
end
% clearvars a p1_109_diag_with_times p1_103_diag_with_times first_valid_value_103 first_valid_value_109 first_valid_value_index_103 first_valid_value_109


radar1_range_vals = valid_values_radar1.';
radar2_range_vals = valid_values_radar2.';
end

