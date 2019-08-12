% SET_BASIS     Allows to choose among a range of basis to build the
%   Reconstruction matrix and to perform the reconstruction. This function is
%   called in both processes so that the choice is coherent all over the
%   method. 
%
%   See also RECONSTRUCTION_MATRIX and
%   RECONSTRUCTION_POLYNOMIAL_ON_THE_EDGES


function [x_basis y_basis] = Set_basis(Chosen_basis,x,y,x_center,y_center)

    switch Chosen_basis
        
        % The Standard basis is the one made with x^k, where x is the
        % coordinate and k is the order
        case 'Standard'
            
            x_basis=x; y_basis=y;
            
        % The Centered Standard basis is the one made with (x-c)^k, where
        % x is the coordinate, k is the order and c is the centroid of the
        % cell
        case 'Centered standard'
            x_basis=x-x_center; y_basis= y-y_center;
    end

end
