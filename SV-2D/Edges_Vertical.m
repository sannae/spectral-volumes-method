% EDGES_VERTICAL  Gives the vertical edges of the I,J cell. the order
%   is the following: the left edge (West,W) is called with the same
%   indices I,J, while the right edge (East,E), is called with the indices
%   I+1,J
%
%   See also EDGES_HORIZONTAL.


function edges_vertical = Edges_vertical(I,J)

    Edge_vertical_W_I = I;
    Edge_vertical_W_J = J;
        Edge_vertical_W = [Edge_vertical_W_I Edge_vertical_W_J];

    Edge_vertical_E_I = I;
    Edge_vertical_E_J = J+1;
        Edge_vertical_E = [Edge_vertical_E_I Edge_vertical_E_J];

    edges_vertical = [Edge_vertical_W; Edge_vertical_E];

end
