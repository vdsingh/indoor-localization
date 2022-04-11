close all;
clear all;
warning off

% location of data directory
dataDir = [pwd,'/data/', 'Localization/'];

% we'll use these arrays to iterate through all of the participants/shapes
participants = ["participant1" "participant2"];
radars = ["109" "103"];
shapes = ["U" "L" "gamma" "four" "diag"];

% this is the threshold for finding the most relevant rangebin
threshold = 5e04;

% iterate through all the participants
for participant = participants
    % iterate through all the shapes/patterns
    for shape = shapes

        % import the envNoClusterScansData
        data_109 = importdata(strcat(dataDir, participant, '/', radars(1),'/', shape,'/', 'envNoClutterscans', '.mat'));
        data_103 = importdata(strcat(dataDir, participant, '/', radars(2),'/', shape,'/', 'envNoClutterscans', '.mat'));
    
        % import the timestamp data
        time_stamps_109 = importdata(strcat(dataDir, participant, '/', radars(1),'/', shape,'/', 'T_stmp', '.mat'));
        time_stamps_103 = importdata(strcat(dataDir, participant, '/', radars(2),'/', shape,'/', 'T_stmp', '.mat'));
        
        % import the range bin data
        range_bins_109 = importdata(strcat(dataDir, participant, '/', radars(1),'/', shape,'/', 'range_bins', '.mat'));
        range_bins_103 = importdata(strcat(dataDir, participant, '/', radars(2),'/', shape,'/', 'range_bins', '.mat'));

        % get the time synced data. see time_sync.m for more info. 
        % This only contains the data points in which both radars have the associated timestamps in common.
        [time_sync_109, time_sync_103] = time_sync(data_109, time_stamps_109, data_103, time_stamps_103);
        
        % get the range values for each radar (the radius). See get_range_vals.m for more info
        [range_vals_109, range_vals_103] = get_range_vals(time_sync_109, range_bins_109, time_sync_103, range_bins_103, threshold);

        % get the relevant intersection points of the radar signals (this is the location of the person in the room). See get_points.m for more info
        [x_vals, y_vals] = get_points(range_vals_109, range_vals_103,1.106, 0, 0, 0, 4.04);

        % plot the waterfall plots for the envNoClutterscans data.
        figure()
        title(strcat(participant, " ", shape, " ", radars(1), " - Envelope of Clutter Removed Radar Data"));
        xlabel('Fast Time/Range');
        ylabel('Slow Time/Scan Number');
        waterfall1 = surf(time_sync_109);
        waterfall1.EdgeColor = 'none';
        view(2);

        figure()
        title(strcat(participant, " ", shape, " ", radars(2), " - Envelope of Clutter Removed Radar Data"));
        xlabel('Fast Time/Range');
        ylabel('Slow Time/Scan Number');
        waterfall2 = surface(time_sync_103);
        waterfall2.EdgeColor = 'none';
        view(2);

        figure()
        % plot the points that the person was detected
        plot(x_vals, y_vals, 'r.');
        title(strcat(participant, " Pattern ", shape, " Tracking with Radars: ", radars(1), " and ", radars(2)));
        xlabel('Radar 109 Wall')
        ylabel('Radar 108 Wall')
        hold on

        % plot the bounds of the room
        plot(linspace(0, 4.04), zeros(100), 'b', zeros(100), linspace(0, 4.04), 'b', linspace(0, 4.04), zeros(100)+4.04, 'b', zeros(100)+4.04, linspace(0, 4.04), 'b');
        
        % plot the ground truth of the shapes/patterns
        if(shape == "U")
            plot(zeros(100)+0.762, linspace(0.9652, 3.4), 'b', linspace(0.762, 1.98), zeros(100) + 0.9652, 'b', zeros(100)+1.98, linspace(0.9652, 3.4), 'b');
        elseif (shape == "gamma")
            plot(linspace(0.762, 1.98), zeros(100) + 0.9652, 'b', zeros(100)+1.98, linspace(0.9652, 3.4), 'b');
        elseif (shape == "four")
            plot(zeros(100)+0.762, linspace(2.1844, 3.4), 'b', linspace(0.762, 1.98), zeros(100) + 2.1844, 'b', zeros(100)+1.98, linspace(0.9652, 2.1844), 'b');
        elseif (shape == "diag")
            plot(linspace(0.762, 1.98), linspace(0.9652, 3.40), 'b');
        elseif (shape == "L")
            plot(linspace(0.762, 1.98), zeros(100) + 3.4,'b',  zeros(100)+1.98, linspace(0.9652, 3.4), 'b');
        end

        hold off
    end
end

