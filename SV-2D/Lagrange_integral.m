% LAGRANGE_INTEGRAL     performs the average of the Lagrange basis function 
% over a cell. It receives as input:
%   The quadrature order to perform the Gauss-Legendre quadrature
%   The coordinates x,y of the centers of all the cells in a SV
%   The coordinates of the corners of the cells
%   The requested degree of the Lagrange basis
%   The areas of all the cells in the SV

function integral = Lagrange_integral(Quadrature_order,x_centers_CV,y_centers_CV,x_corner_SW_CV,y_corner_SW_CV,x_corner_SE_CV,y_corner_NW_CV,degree,area)
    
    % Initializing integrals
    integral_over_x = 0;
    integral_over_y = 0;

    % Calculating the Deltas, needed in the following computations
    Delta_x = abs(x_corner_SW_CV - x_corner_SE_CV);
    Delta_y = abs(y_corner_SW_CV - y_corner_NW_CV);

    % Finding the x and y quadrature points and weights
    [x_quadrature_points x_quadrature_weights] = GL_nodes_and_weights_Golub_Welsch(Quadrature_order,x_corner_SW_CV,x_corner_SE_CV);
    [y_quadrature_points y_quadrature_weights] = GL_nodes_and_weights_Golub_Welsch(Quadrature_order,y_corner_SW_CV,y_corner_NW_CV);

    % Performing the integrals over x and y on all the quadrature points
    for l=1:Quadrature_order

        integral_over_x = integral_over_x + (Delta_x/2)*lagrange(x_quadrature_points(l),x_centers_CV,degree)*x_quadrature_weights(l);
        integral_over_y = integral_over_y + (Delta_y/2)*lagrange(y_quadrature_points(l),y_centers_CV,degree)*y_quadrature_weights(l);

    end

    % Obtaining the average
    integral = integral_over_x*integral_over_y;
    integral = integral/area;

end
