% COMPUTE_FLUXES    It's one of the most important functions in the method.
%   It computes the flux in every quadrature point of every edge,
%   distinguishing the horizontal and the vertical values.
%
%   In this function and in the following steps, we switch the frame of
%   reference. Instead of using a grid of cells with indices I,J, from now
%   on we'll consider a grid of edges with indices I,J, where the I,J-th
%   horizontal edge is actually the Southern edge of the I,J-th cell, and
%   the I,J-th vertical edge is the Western one. That's why in this
%   function the boundary conditions have to be implemented in a separate
%   IF statement.
%
%   In both of them, a LEFT and RIGHT value are stored, where the orientation
%   depends on the arbitrary choice of the normal vector: in this case, ALL
%   the horizontal edges have normal vector (0 1) and ALL vertical edges have
%   normal vector (1 0). Therefore, the 'left' and 'right' values on the
%   boundary depend on which boundary we are. 
%
%   Since the Euler problem is solved once at all using a Normal Velocity and
%   a Tangential Velocity that depend on what direction the flux is computed,
%   here the values of the horizontal edges have to be projected in order to
%   have the y velocity as the Normal Component and the x velocity as the
%   Tangential Component. On the other hand, since the values on the vertical
%   edges are already in the correct order, they won't be projected.
%
%   Once the reconstructed values are stored in the proper way, the function
%   calls REAL_FLUX or RIEMANN_FLUX according to the input matrix
%   FLAG_RIEMANN. All the fluxes are then stored in a matrix
%   FLUX_HORIZONTAL(:,Q,I,J) and FLUX_VERTICAL(:,Q,I,J), where the indices
%   represent the variables, the quadrature points and the cell grid indices.
%
%   See also FLUX_INTEGRATION.



function [flux_horizontal flux_vertical] = Compute_fluxes(n_x,n_y,CV_per_SV_side_x,CV_per_SV_side_y,Boundary_case,Quadrature_order,flag_riemann, Reconstruction_polynomial_edges,gamma)







% Horizontal fluxes

    left_edge = 3;
    right_edge = 1;

    for i =1:n_y*CV_per_SV_side_y+1
        for j=1:n_x*CV_per_SV_side_x

            for q=1:Quadrature_order

                % Switch row in the subgrid
                switch i

                    
                    
                    % Calling the boundary conditions on the South edge: the
                    % known value is the one on the Right
                    case 1

                        % Neither real nor Riemann flux
                        flag_riemann_new_frame(i,j) = -1;

                        % The right value is the known one, i.e. the
                        % reconstruction polynomial
                        Boundary_values_right = Reconstruction_polynomial_edges(q,right_edge,i,j,:);
                        u_right = Projection(Boundary_values_right,right_edge);

                        % The left value is the imposed one
                        u_left = Set_boundary_conditions(Boundary_case, u_right);

                        
                        
                    % Calling the boundary conditions on the North edge: notice
                    % that right and left edges have been inverted, because the
                    % known value is the one on the Left
                    case n_y*CV_per_SV_side_y+1

                        % Neither real nor Riemann flux
                        flag_riemann_new_frame(i,j) = -1;

                        % The left value is the known one
                        Boundary_values_left = Reconstruction_polynomial_edges(q,left_edge,i-1,j,:);
                        u_left = Projection(Boundary_values_left,right_edge);

                        % The right value is the imposed one
                        u_right = Set_boundary_conditions(Boundary_case, u_left);

                        
                        
                    % In all the internal edges
                    otherwise

                        % Re-setting the riemann flag only on the south edge of the
                        % cell: now it is related only to the i,j-th line
                        flag_riemann_new_frame(i,j) = flag_riemann(right_edge,i,j);

                        % Left value, in this case bottom value. Coming from the
                        % reconstructed value on the North edge of the (i-1)-th
                        % cell. Projected on the normal vector (0 1)
                        u_left = Projection(Reconstruction_polynomial_edges(q,left_edge,i-1,j,:),left_edge);

                        % Right value, in this case top value. Coming from the
                        % reconstructed value on the South edge of the i-th cell.
                        % Projected on the normal vector (0 -1)
                        u_right = Projection(Reconstruction_polynomial_edges(q,right_edge,i,j,:),right_edge);

                end

                
                % Checking the Riemann condition
                if flag_riemann_new_frame(i,j) == 0

                    % No riemann flag: the flux is the physical flux calculated
                    % on the left value, i.e. the one from the bottom cell
                    flux_horizontal(:,q,i,j) = Real_flux(u_left,gamma);

                else if (flag_riemann_new_frame(i,j)==1 || flag_riemann_new_frame(i,j)==-1)

                        % Both 'left' (bottom) and 'right' (top) fluxes are
                        % computed and used in the Riemann flux formula
                        flux_left = Real_flux(u_left,gamma);
                        flux_right = Real_flux(u_right,gamma);


                            % The Riemann flux function is called
                            flux_horizontal(:,q,i,j) = Riemann_flux(flux_left(:),flux_right(:),u_left(:),u_right(:),gamma);

                    end
                end

                % Counter-projection in the original frame-of-reference
                flux_horizontal(:,q,i,j) = Projection(flux_horizontal(:,q,i,j),left_edge);

            end
        end
    end

    
    
    
    
    
    
    

% Vertical fluxes

    left_edge = 2;
    right_edge = 4;
    flag_riemann_new_frame = zeros(n_y*CV_per_SV_side_y,n_x*CV_per_SV_side_x+1);
    
    for i =1:n_y*CV_per_SV_side_y
        for j=1:n_x*CV_per_SV_side_x+1

            for q=1:Quadrature_order

                % Switch column in the subgrid
                switch j

                    % Calling the boundary conditions on the West edge: the
                    % known value is the one on the Right
                    case 1

                        % Neither real nor Riemann flux
                        flag_riemann_new_frame(i,j) = -1;

                        % The right value is the known one, i.e. the
                        % reconstruction polynomial
                        Boundary_values_right = Reconstruction_polynomial_edges(q,right_edge,i,j,:);
                        u_right = Boundary_values_right;

                        % The left value is the imposed one
                        u_left = Set_boundary_conditions(Boundary_case, u_right);
                        


                        % Calling the boundary conditions on the East edge: notice
                        % that right and left edges have been inverted, because the
                        % known value is the one on the Left
                    case n_x*CV_per_SV_side_x+1

                        % Neither real nor Riemann flux
                        flag_riemann_new_frame(i,j) = -1;

                        % The left value is the known one
                        Boundary_values_left = Reconstruction_polynomial_edges(q,left_edge,i,j-1,:);
                        u_left = Boundary_values_left;

                        % The right value is the imposed one
                        u_right = Set_boundary_conditions(Boundary_case, u_left);


                    otherwise

                        % Re-setting the riemann flag only on the south edge of the
                        % cell: now it is related only to the i,j-th line
                        flag_riemann_new_frame(i,j) = flag_riemann(right_edge,i,j);

                        % Left value, in this case bottom value. Coming from the
                        % reconstructed value on the North edge of the (i-1)-th
                        % cell. Projected on the normal vector (0 1)
                        u_left = Reconstruction_polynomial_edges(q,left_edge,i,j-1,:);

                        % Right value, in this case top value. Coming from the
                        % reconstructed value on the South edge of the i-th cell.
                        % Projected on the normal vector (0 -1)
                        u_right = Reconstruction_polynomial_edges(q,right_edge,i,j,:);

                end

                if flag_riemann_new_frame(i,j) == 0

                    % No riemann flag: the flux is the physical flux calculated
                    % on the left value, i.e. the one from the bottom cell
                    flux_vertical(:,q,i,j) = Real_flux(u_left,gamma);

                else if (flag_riemann_new_frame(i,j)==1 || flag_riemann_new_frame(i,j)==-1)

                        % Both 'left' (bottom) and 'right' (top) fluxes are
                        % computed and used in the Riemann flux formula
                        flux_left = Real_flux(u_left,gamma);
                        flux_right = Real_flux(u_right,gamma);

                            % The Riemann flux function is called
                            flux_vertical(:,q,i,j) = Riemann_flux(flux_left(:),flux_right(:),u_left(:),u_right(:),gamma);

                    end
                end

            end
        end
    end
end
