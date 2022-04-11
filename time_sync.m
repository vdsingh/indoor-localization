function [radar1_time_sync, radar2_time_sync] = time_sync(radar1_data,radar1_time_stamps, radar2_data, radar2_time_stamps)

% find all of the timestamps that both radars have in common
common_time_stamps = intersect(radar1_time_stamps, radar2_time_stamps);

% here we are simply concatenating the time stamps onto our data.
radar1_time_sync = [radar1_data radar1_time_stamps.'];
radar2_time_sync = [radar2_data radar2_time_stamps.'];

% keep only the data points at times when both radars collected data simultaneously
radar1_time_sync(ismember(radar1_time_sync(:, end), common_time_stamps) == 0, :) = [];
radar2_time_sync(ismember(radar2_time_sync(:, end), common_time_stamps) == 0, :) = [];

% remove the timestamps that we previously appended to the data
radar1_time_sync = radar1_time_sync(:, 1:end-1);
radar2_time_sync = radar2_time_sync(:, 1:end-1);

end

