% STANDARD_BASIS_INTEGRAL   Creates an array of the averaged standard basis
%   functions in a cell. The user has to provide the QUADRATURE_ORDER
%   required to perform the Gauss-Legendre quadrature rule, the coordinates
%   of the cell corners (xSW,ySW,xSE,yNW), the order of the method K and the
%   AREA of the cell itself.

function integral = Standard_basis_integral(Quadrature_order,x_corner_SW_CV,y_corner_SW_CV,x_corner_SE_CV,y_corner_NW_CV,k,area,x_center,y_center,Chosen_basis)

    i=1;
    
    for degree_x = 0:k-1
        for degree_y = 0:k-1

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
                
                [x_basis y_basis] = Set_basis(Chosen_basis,x_quadrature_points(l),y_quadrature_points(l),x_center,y_center);

                integral_over_x = integral_over_x + (Delta_x/2)*Standard_basis(x_basis,degree_x)*x_quadrature_weights(l);
                integral_over_y = integral_over_y + (Delta_y/2)*Standard_basis(y_basis,degree_y)*y_quadrature_weights(l);

            end

            % Obtaining the average
            integral_value = integral_over_x*integral_over_y;
            integral(i) = integral_value/area;
            i=i+1;
            
        end
    end


end
