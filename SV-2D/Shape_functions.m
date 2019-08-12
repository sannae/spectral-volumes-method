% SHAPE_FUNCTIONS   correspond to the Shape functions needed to perform a
%   mapping between the logical coordinates XI and ETA and the physical
%   coordinates. 
%
%   See also JACOBIAN_MATRIX.


function [S1 S2 S3 S4]= Shape_functions(xi,eta)

    % Shape functions: they are corresponding to, respectively, the SW
    % corner (1), the SE corner (2), the NE corner (3), the NW corner (4)
    S1 = 0.25*(1-xi)*(1-eta);   
    S2 = 0.25*(1+xi)*(1-eta);
    S3 = 0.25*(1+xi)*(1+eta);
    S4 = 0.25*(1-xi)*(1+eta);
    
end
