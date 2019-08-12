% EDGES_HORIZONTAL  Gives the horizontal edges of the I,J cell. the order
%   is the following: the lower edge (South,S) is called with the same
%   indices I,J, while the upper edge (North,N), is called with the indices
%   I+1,J
%
%   See also EDGES_VERTICAL


function edges_horizontal = Edges_horizontal(I,J)

    Edge_horizontal_S_I = I;
    Edge_horizontal_S_J = J;
        Edge_horizontal_S = [Edge_horizontal_S_I Edge_horizontal_S_J];

    Edge_horizontal_N_I = I+1;
    Edge_horizontal_N_J = J;
        Edge_horizontal_N = [Edge_horizontal_N_I Edge_horizontal_N_J];

    edges_horizontal = [Edge_horizontal_S; Edge_horizontal_N];

end
