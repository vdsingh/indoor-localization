close all;
clear all;
warning off

% location of data directory
dataDir = [pwd,'/data/', 'Localization/'];

participants = ["participant1" "participant2"];
radars = ["109" "103"];
shapes = ["U" "L" "gamma" "four" "diag"];
% shapes = ["U"];


threshold = 5e04;

for participant = participants
%     disp(a)
    for shape = shapes
        data_109 = importdata(strcat(dataDir, participant, '/', radars(1),'/', shape,'/', 'envNoClutterscans', '.mat'));
        data_103 = importdata(strcat(dataDir, participant, '/', radars(2),'/', shape,'/', 'envNoClutterscans', '.mat'));
    
        time_stamps_109 = importdata(strcat(dataDir, participant, '/', radars(1),'/', shape,'/', 'T_stmp', '.mat'));
        time_stamps_103 = importdata(strcat(dataDir, participant, '/', radars(2),'/', shape,'/', 'T_stmp', '.mat'));

        range_bins_109 = importdata(strcat(dataDir, participant, '/', radars(1),'/', shape,'/', 'range_bins', '.mat'));
        range_bins_103 = importdata(strcat(dataDir, participant, '/', radars(2),'/', shape,'/', 'range_bins', '.mat'));

        [time_sync_109, time_sync_103] = time_sync(data_109, time_stamps_109, range_bins_109, data_103, time_stamps_103, range_bins_103, threshold);
        [range_vals_109, range_vals_103] = get_range_vals(time_sync_109, range_bins_109, time_sync_103, range_bins_103, threshold);

        [x_vals, y_vals] = get_points(range_vals_109, range_vals_103,1.106, 0, 0, 0, 4.04);
% 
%         figure()
%         title(strcat(participant, shape, radars(1), "- Envelope of Clutter Removed Radar Data"));
%         xlabel('Fast Time/Range');
%         ylabel('Slow Time/Scan Number');
%         waterfall1 = surf(time_sync_109);
%         waterfall1.EdgeColor = 'none';
%         view(2);
% 
%         figure()
%         title(strcat(participant, shape, radars(2), "- Envelope of Clutter Removed Radar Data"));
%         xlabel('Fast Time/Range');
%         ylabel('Slow Time/Scan Number');
%         waterfall1 = surface(time_sync_103);
%         waterfall1.EdgeColor = 'none';
%         view(2);

        figure()

        plot(x_vals, y_vals, 'r.');
        title(strcat(participant, " Pattern ", shape, " Tracking with Radars: ", radars(1), " and ", radars(2)));
        xlabel('Radar 109 Wall')
        ylabel('Radar 108 Wall')
        hold on
        plot(linspace(0, 4.04), zeros(100), 'b', zeros(100), linspace(0, 4.04), 'b', linspace(0, 4.04), zeros(100)+4.04, 'b', zeros(100)+4.04, linspace(0, 4.04), 'b');
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

