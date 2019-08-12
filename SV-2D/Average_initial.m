% AVERAGE_INITIAL   provides all the cell-averaged initial conditions. This
% function can also be used to plot the cell-averages of any input
% function, provided the corresponding formula. 
% Giving the VAR_NUMBER, all the mesh parameters, the QUADRATURE_ORDER and
%   the INITIAL CASE, the function produces the averaged U corresponding to
%   the cell I,J and the variable V. 
%
%   Uncomment the lines concerning the plot to have a figure showing
%   rectangles for each cell-average.


function u = Average_initial(var_number,n_x,n_y,CV_per_SV_side_x,CV_per_SV_side_y,Quadrature_order,x_corner_SW_CV,y_corner_SW_CV,x_corner_SE_CV,y_corner_SE_CV,x_corner_NE_CV,y_corner_NE_CV,x_corner_NW_CV,y_corner_NW_CV,area,Initial_case)

    for v=1:var_number

%        figure(v)

        for i=1:(n_y*CV_per_SV_side_y)
            for j=1:(n_x*CV_per_SV_side_x)

                % Gauss-Legendre nodes on the logical element
                [xi(i,j,:) xi_weights(i,j,:)] = GL_nodes_and_weights_Golub_Welsch(Quadrature_order,-1,1);
                [eta(i,j,:) eta_weights(i,j,:)] = GL_nodes_and_weights_Golub_Welsch(Quadrature_order,-1,1);

                % Gauss-Legendre nodes on the physical element
                [x_quadrature_nodes(i,j,:) x_quadrature_weights(i,j,:)] = GL_nodes_and_weights_Golub_Welsch(Quadrature_order,x_corner_SW_CV(i,j),x_corner_SE_CV(i,j));
                [y_quadrature_nodes(i,j,:) y_quadrature_weights(i,j,:)] = GL_nodes_and_weights_Golub_Welsch(Quadrature_order,y_corner_SW_CV(i,j),y_corner_NW_CV(i,j));

                u(i,j,v) = 0;

                for q = 1:Quadrature_order
                    for r = 1:Quadrature_order

                        % Initial function
                        u0(q,r,v,i,j) = InitialConditions(v,x_quadrature_nodes(i,j,q),y_quadrature_nodes(i,j,r),Initial_case);
%                       plot3(x_quadrature_nodes(i,j,q),y_quadrature_nodes(i,j,r),u0(q,r,v,i,j),'g*'); hold on;

                        % Jacobian matrix
                        Jacobian(:,:,q,r,i,j) = Jacobian_matrix(xi(i,j,q),eta(i,j,r),x_corner_SW_CV(i,j),y_corner_SW_CV(i,j),x_corner_SE_CV(i,j),y_corner_SE_CV(i,j),x_corner_NE_CV(i,j),y_corner_NE_CV(i,j),x_corner_NW_CV(i,j),y_corner_NW_CV(i,j));

                        % Gauss quadrature
                        u(i,j,v) = u(i,j,v) + u0(q,r,v,i,j)*x_quadrature_weights(i,j,q)*y_quadrature_weights(i,j,r)*det(Jacobian(:,:,q,r,i,j));

                    end
                end

                % Cell Average
                u(i,j,v) = u(i,j,v)./area(i,j);

                % Plot the average

%               Plot_points_lines('Rectangles',x_corner_SW_CV(i,j),y_corner_SW_CV(i,j),x_corner_SE_CV(i,j),y_corner_SE_CV(i,j),x_corner_NE_CV(i,j),y_corner_NE_CV(i,j),x_corner_NW_CV(i,j),y_corner_NW_CV(i,j),u(i,j,v)); hold on;
%               title('Initial averaged values')


            end
        end
    
    end
    
end
