% NORMAL_VECTOR     Provides the normal vector of the input EDGE (according
%   to the S,E,N,W approach). The output is the array containing the
%   coordinates of the normal vector.



function normal_vector = Normal_vector(edge)

    switch edge

        case 1 % South

            normal_vector = [0 -1];

        case 2 % East

            normal_vector = [1 0];

        case 3 % North

            normal_vector = [0 1];

        case 4 % West

            normal_vector = [-1 0];

    end

end
