% AREA provides the area of the i,j cell.
%   Given the SW-SE corners, it computes the delta x and given the SW-NW 
%   corners, it computes the delta y.

function surface = Area(x_corner_SW_CV,x_corner_SE_CV,y_corner_SW_CV,y_corner_NW_CV)

    Delta_x = abs(x_corner_SW_CV - x_corner_SE_CV);
    Delta_y = abs(y_corner_SW_CV - y_corner_NW_CV);

    surface = Delta_x * Delta_y;

end
