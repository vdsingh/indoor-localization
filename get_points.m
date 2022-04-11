function [x_vals, y_vals] = get_points(radar1_range_vals,radar2_range_vals, radar1_center_x, radar1_center_y, radar2_center_x, radar2_center_y, room_dim)
%This function takes the range values (radii), and coordinate/bound
%information of radars and of the room. It then calculates the intersection
%points of the pair of circles (radar 1 and radar 2), finds the one in the bounds of the room 
%and stores it to be returned
x_vals = [];
y_vals = [];

for k = 1:size(radar1_range_vals, 1)

    % get the intersection points (there will usually be two)
    [x_intersect, y_intersect] = circcirc(radar1_center_x, radar1_center_y, radar1_range_vals(k, 1), radar2_center_x, radar2_center_y, radar2_range_vals(k, 1));
 
    % if there are not two intersection points, ignore it
    if(size(x_intersect, 2) == 2)

        % these are just booleans that tell us whether the points are
        % inside the room
        point1_inside = x_intersect(1) >= 0 && x_intersect(1) <= room_dim && y_intersect(1) >= 0 && y_intersect(1) <= room_dim;
        point2_inside = x_intersect(2) >= 0 && x_intersect(2) <= room_dim && y_intersect(2) >= 0 && y_intersect(2) <= room_dim;

        %point 1 is inside the bounds of the room.
        if(point1_inside && ~point2_inside)
            x_intersect = x_intersect(1);
            y_intersect = y_intersect(1);
            x_vals = [x_vals x_intersect];
            y_vals = [y_vals y_intersect];

        % point 2 is inside the room.
        elseif (~point1_inside && point2_inside)
            x_intersect = x_intersect(2);
            y_intersect = y_intersect(2);
            x_vals = [x_vals x_intersect];
            y_vals = [y_vals y_intersect];

        % both points are inside the room.
        elseif (point1_inside && point2_inside)
            disp("Both points are inside.")
            dist_p1 = ([x_intersect(1) x_vals(k, end); y_intersect(1) y_vals(k, end)]);
            dist_p2 = ([x_intersect(2) x_vals(k, end); y_intersect(2) y_vals(k, end)]);
            if(dist_p1 < dist_p2)
                x_intersect = x_intersect(1);
                y_intersect = y_intersect(1);
            else
                x_intersect = x_intersect(2);
                y_intersect = y_intersect(2);
            end
            x_vals = [x_vals x_intersect];
            y_vals = [y_vals y_intersect]; 
        % neither point is inside the room or the circles do not intersect.
        else
            disp(["Not two points: ", x_intersect, " ", y_intersect]);
        end
    end
end

