% INTERVAL_EXTREMES     Given two intervals as array, 
%   it just gives back the extremes of both.

function [extreme_x_a,extreme_x_b,extreme_y_a,extreme_y_b] = Interval_extremes(interval_on_x,interval_on_y)

    extreme_x_a = interval_on_x(1);
    extreme_x_b = interval_on_x(2);

    extreme_y_a = interval_on_y(1);
    extreme_y_b = interval_on_y(2);

end
