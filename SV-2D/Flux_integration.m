% FLUX_INTEGRATION      Provides the integration of the fluxes over the
%   edges of a cell. Receiving as input the values of FLUX_HORIZONTAL and
%   FLUX_VERTICAL (from the function COMPUTE_FLUXES), that are evaluated in
%   each quadrature point, this function performs the Gauss-Legendre
%   quadrature rule using those values and the corresponding weights. 
%
%   This function keeps the same edge-wise frame of reference as the input
%   matrices have. For details, see also COMPUTE_FLUXES.
%
%   The output is a matrix, both for horizontal and vertical edges,
%   containing the value of the horizontal/vertical flux integrated over
%   the I,J-th edge.
%
%   See also COMPUTE_FLUXES.




function [flux_integrated_over_edge_horizontal flux_integrated_over_edge_vertical] = Flux_integration(n_x,n_y,CV_per_SV_side_x,CV_per_SV_side_y,Quadrature_order,var_number,flux_horizontal,flux_vertical,x_corner_SW_CV,x_corner_SE_CV,y_corner_SW_CV,y_corner_NW_CV)




% Horizontal edges

    flux_integrated_over_edge_horizontal(n_y*CV_per_SV_side_y+1,n_x*CV_per_SV_side_x,1:var_number) = 0;

    for i =1:n_y*CV_per_SV_side_y+1
        for j=1:n_x*CV_per_SV_side_x
            
            % Saving the quadrature point. For the last edge on the North
            % boundary, there's a personal additional IF condition
            if i==n_y*CV_per_SV_side_y+1
                [x_quadrature_points x_quadrature_weights] = GL_nodes_and_weights_Golub_Welsch(Quadrature_order,x_corner_SW_CV(i-1,j),x_corner_SE_CV(i-1,j));
                Delta_x = abs(x_corner_SW_CV(i-1,j) - x_corner_SE_CV(i-1,j));
            else
                [x_quadrature_points x_quadrature_weights] = GL_nodes_and_weights_Golub_Welsch(Quadrature_order,x_corner_SW_CV(i,j),x_corner_SE_CV(i,j));
                Delta_x = abs(x_corner_SW_CV(i,j) - x_corner_SE_CV(i,j));
            end

            % Saving the flux integrated over each i,j-th edge
            for q=1:Quadrature_order
                for v=1:var_number
                    
                    flux_integrated_over_edge_horizontal(i,j,v) = flux_integrated_over_edge_horizontal(i,j,v) + flux_horizontal(v,q,i,j).*x_quadrature_weights(q);

                end
            end
            
            flux_integrated_over_edge_horizontal(i,j,:) = flux_integrated_over_edge_horizontal(i,j,:)*(Delta_x)/2;
            
        end

    end


    
    
    
    
    
% Vertical edges

    flux_integrated_over_edge_vertical(n_y*CV_per_SV_side_y,n_x*CV_per_SV_side_x+1,1:var_number) = 0;

    for i =1:n_y*CV_per_SV_side_y
        for j=1:n_x*CV_per_SV_side_x+1
            
            % Saving the quadrature point. For the last edge on the East
            % boundary, there's a personal additional IF condition
            if j==n_x*CV_per_SV_side_x+1
                [y_quadrature_points y_quadrature_weights] = GL_nodes_and_weights_Golub_Welsch(Quadrature_order,y_corner_SW_CV(i,j-1),y_corner_NW_CV(i,j-1));
                Delta_y = abs(y_corner_SW_CV(i,j-1) - y_corner_NW_CV(i,j-1));
            else
                [y_quadrature_points y_quadrature_weights] = GL_nodes_and_weights_Golub_Welsch(Quadrature_order,y_corner_SW_CV(i,j),y_corner_NW_CV(i,j));
                Delta_y = abs(y_corner_SW_CV(i,j) - y_corner_NW_CV(i,j));
            end

            % Saving the flux integrated over each i,j-th edge
            for q=1:Quadrature_order
                for v=1:var_number

                    flux_integrated_over_edge_vertical(i,j,v) = flux_integrated_over_edge_vertical(i,j,v) + flux_vertical(v,q,i,j).*y_quadrature_weights(q);

                end
            end
            
            flux_integrated_over_edge_vertical(i,j,:) = flux_integrated_over_edge_vertical(i,j,:)*(Delta_y)/2;
            
        end

    end

end
