% CORNERS_INDICES   Get the four nodes of a cell, knowing the index_x and
%   index_y: the order is SW,SE,NE,NW. The output is a matrix 4-by-2 with the
%   corners in the rows and the indices I,J in the columns.

function corners = corners_indices(I,J)

    SW_corner_I = I;
    SW_corner_J = J;
        SW_corner = [SW_corner_I SW_corner_J];

    SE_corner_I = I;
    SE_corner_J = J+1;
        SE_corner = [SE_corner_I SE_corner_J];

    NW_corner_I = I+1;
    NW_corner_J = J;
        NW_corner = [NW_corner_I NW_corner_J];

    NE_corner_I = I+1;
    NE_corner_J = J+1;
        NE_corner = [NE_corner_I NE_corner_J];

    corners = [SW_corner; SE_corner; NE_corner; NW_corner];

end
