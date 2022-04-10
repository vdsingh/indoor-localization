function [x_vals, y_vals] = get_points(radar1_range_vals,radar2_range_vals, radar1_center_x, radar1_center_y, radar2_center_x, radar2_center_y, room_dim)
%GET_POINTS Summary of this function goes here
%   Detailed explanation goes here
% center_103 = [0,0];
% center_109 = [1.016, 0];

x_vals = [];
y_vals = [];

for k = 1:size(radar1_range_vals, 1)
%     disp(p1_103_diag_min_values(k, 2));
    [x_intersect, y_intersect] = circcirc(radar1_center_x, radar1_center_y, radar1_range_vals(k, 1), radar2_center_x, radar2_center_y, radar2_range_vals(k, 1));
 
    if(size(x_intersect, 2) == 2)
        if(x_intersect(1) >= 0 && x_intersect(1) <= room_dim && y_intersect(1) >= 0 && y_intersect(1) <= room_dim)
            x_intersect = x_intersect(1);
            y_intersect = y_intersect(1);
            x_vals = [x_vals x_intersect];
            y_vals = [y_vals y_intersect];
        elseif (x_intersect(2) >= 0 && x_intersect(2) <= room_dim && y_intersect(2) >= 0 && y_intersect(2) <= room_dim)
            x_intersect = x_intersect(2);
            y_intersect = y_intersect(2);
            x_vals = [x_vals x_intersect];
            y_vals = [y_vals y_intersect];
        else 
            disp("Not two points");
        end
    end
end

