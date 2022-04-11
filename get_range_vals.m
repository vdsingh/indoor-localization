function [radar1_range_vals, radar2_range_vals] = get_range_vals(radar1_time_synced,radar1_range_bins, radar2_time_synced, radar2_range_bins, threshold)
%This function gets all of the appropriate ranges that the
%radars record. It takes time synced data, finds the first value greater
%than the given threshold, and takes the appropriate range bin. If there is
%no value greater than the threshold, the data point is omitted from both outputs.

valid_values_radar1 = [];
valid_values_radar2 = [];

%iterate through all the rows of the time synced data
for a = 1:size(radar1_time_synced, 1)

    % get the current row
    radar1_row = radar1_time_synced(a, 1:end);
    radar2_row = radar2_time_synced(a, 1:end);

    % get the index of the first value in the current row that is greater than the threshold
    first_index_radar1 = find(radar1_row >= threshold, 1);
    first_index_radar2 = find(radar2_row >= threshold, 1);

    % if there exists a value in this row in BOTH time synced data sets, greater than the threshold, find
    % each associated range from the range bins and append them to our
    % outputs
    if size(first_index_radar1, 2) ~= 0 && size(first_index_radar2, 2) ~= 0
        first_value_radar1 = radar1_range_bins(first_index_radar1);
        first_value_radar2 = radar2_range_bins(first_index_radar2);

        valid_values_radar1 = [valid_values_radar1 first_value_radar1];
        valid_values_radar2 = [valid_values_radar2 first_value_radar2];
    end  
end

% transpose the range values that we found
radar1_range_vals = valid_values_radar1.';
radar2_range_vals = valid_values_radar2.';
end

