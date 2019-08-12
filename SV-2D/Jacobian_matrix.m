% JACOBIAN_MATRIX   Computes the Jacobian Matrix. It receives as input the
%   logical coordinates XI and ETA (real numbers) and the corners coordinates
%   of the physical element where we want the mapping to be performed.

function Jacobian = Jacobian_matrix(xi,eta,x_corner_SW,y_corner_SW,x_corner_SE,y_corner_SE,x_corner_NE,y_corner_NE,x_corner_NW,y_corner_NW)

    % Shape functions derivatives 
    dS1_dxi = -0.25*(1-eta);    dS1_deta = -0.25*(1-xi);
    dS2_dxi = 0.25*(1-eta);     dS2_deta = -0.25*(1+xi);
    dS3_dxi = 0.25*(1+eta);     dS3_deta = 0.25*(1+xi);
    dS4_dxi = -0.25*(1+eta);    dS4_deta = 0.25*(1-xi);
    
    % Matrices
    Derivative_matrix = [dS1_dxi dS2_dxi dS3_dxi dS4_dxi; dS1_deta dS2_deta dS3_deta dS4_deta];
    corners_matrix = [x_corner_SW y_corner_SW; x_corner_SE y_corner_SE; x_corner_NE y_corner_NE; x_corner_NW y_corner_NW];
    
    % Product
    Jacobian = Derivative_matrix*corners_matrix;
    
end
