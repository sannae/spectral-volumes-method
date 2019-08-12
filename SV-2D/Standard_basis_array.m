% STANDARD_BASIS_ARRAY      Creates an array of the standard 2D basis
%   function, evaluated in the point with coordinates X,Y. The input value K
%   provides also the size of the array.
%
%   Example: k=2, we'll have the basis {1 x y xy} evaluated in the given
%   coordinates

function Standard_array = Standard_basis_array(x,y,k)

    i=1;
    Standard_array = [];

    for degree_x = 0:k-1
        for degree_y = 0:k-1

            Standard_array(i) = Standard_basis2D(x,y,degree_x,degree_y);
            i=i+1;

        end
    end

end
