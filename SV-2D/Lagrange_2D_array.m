% LAGRANGE_2D_ARRAY     Provides the array of 2D Lagrange basis function to
% be used in the dot product with the Reconstruction Coefficients. It
% receives as input the point (X,Y) where it has to be evaluated, the
% interpolation points POINTX and POINTY and the degree K.


function lagrange_array = Lagrange_2D_array(x,y,pointx,pointy,k)

    for degree = 1:(k^2)
        
        lagrange_array(degree) = lagrange2D(x,y,pointx,pointy,degree);
        
    end
    
end
