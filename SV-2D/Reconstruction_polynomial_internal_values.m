% RECONSTRUCTION_POLYNOMIAL_INTERNAL_VALUES    The function evaluates the 
%   Reconstruction polynomial in the internal reconstruction points. These
%   values are not used in the method, but they can be plotted to check if
%   the reconstruction polynomial is correct. 
%   This function is uncommented in the main, but it's almost useless in
%   the method itself and it's called only if the PLOTTING_MODE chosen by
%   the user is 'Reconstruction'.
%
%   IMPORTANT NOTE: the plot of these values might be asymmetrical even with
%   simmetrical smooth initial condition! This is NOT an issue, but it's 
%   just related to the plotting routine. Always check both this plotting 
%   mode and the averaged one (the latter is the actual solution).
%
%   See also RECONSTRUCTION_POLYNOMIAL_ON_THE_EDGES



function Reconstruction_polynomial = Reconstruction_polynomial_internal_values(var_number,n_x,n_y,CV_per_SV_side_x,CV_per_SV_side_y,Quadrature_order,x_corner_SW_CV,x_corner_SE_CV,y_corner_SW_CV,y_corner_NW_CV,Reconstruction_coefficients,k,interval_on_x,interval_on_y,variable_to_be_plotted,plotting_mode,Chosen_basis,x_centers,y_centers,u)

    for v=1:var_number

        
        
        % Initializing for the main mesh

        x_grid_polynomial = [];
        y_grid_polynomial = [];
        Reconstruction_polynomial_total = zeros(Quadrature_order*n_y*CV_per_SV_side_y,Quadrature_order*n_x*CV_per_SV_side_x);

        
        
        for index_I = 1:n_y
            for index_J = 1:n_x

                for i=1:n_y*CV_per_SV_side_y
                    for j=1:n_x*CV_per_SV_side_x

                        
                        
                        % Same routine as before to convert from a (i,j) frame
                        % to a 1...k frame

                        [internal_i internal_j] = Which_number_of_CV_in_a_SV(i,j,CV_per_SV_side_y,CV_per_SV_side_x);
                        [SV_belongs_to_flag_i SV_belongs_to_flag_j] = Which_SV_belongs_to(i,j,CV_per_SV_side_x,CV_per_SV_side_y);

                        if (SV_belongs_to_flag_i == index_I && SV_belongs_to_flag_j == index_J)

                                Reconstruction_coefficients(1,1,internal_i,internal_j,index_I,index_J,v) = Reconstruction_coefficients(1,1,internal_i,internal_j,index_I,index_J,v) - u(i,j,v);
                            
                            
                            % Coordinates x and y, either of the internal
                            % quadrature points or the edge points

                            [x_quadrature_points x_quadrature_weights] = GL_nodes_and_weights_Golub_Welsch(Quadrature_order,x_corner_SW_CV(i,j),x_corner_SE_CV(i,j));
                            [y_quadrature_points y_quadrature_weights] = GL_nodes_and_weights_Golub_Welsch(Quadrature_order,y_corner_SW_CV(i,j),y_corner_NW_CV(i,j));

                            % Saving for the main grid plotting, i.e. the
                            % aforesaid coordinates in a single array

                            x_grid_polynomial = [x_grid_polynomial x_quadrature_points];
                            y_grid_polynomial = [y_grid_polynomial y_quadrature_points];



                            for q=1:Quadrature_order
                                for r=1:Quadrature_order

                                    % Choosing the basis
                                    
                                    [x_basis y_basis] = Set_basis(Chosen_basis,x_quadrature_points(q),y_quadrature_points(r),x_centers(index_I,index_J),y_centers(index_I,index_J));
                                    
                                    % The reconstruction itself: dot product
                                    % between4 standard basis and reconstruction
                                    % coefficients.
                                    
                                    Reconstruction_polynomial(q,r,index_I,index_J,v) = u(i,j,v) + dot(Reconstruction_coefficients(:,:,internal_i,internal_j,index_I,index_J,v),Standard_basis_array(x_basis,y_basis,k));


                                end
                            end
                            

                            
                            
                            % Storing all the reconstructed values computed on
                            % the quadrature points in a single matrix (it will
                            % be useful in plotting the mesh)
                            pos_i = (i-1)*Quadrature_order+linspace(1,Quadrature_order,Quadrature_order);
                            pos_j = (j-1)*Quadrature_order+linspace(1,Quadrature_order,Quadrature_order);
                            Reconstruction_polynomial_total(pos_j,pos_i) = Reconstruction_polynomial(:,:,index_I,index_J,v);

                        end
                    end
                end
            end
        end

    
        
        
        
        
    % Creating a mesh and plotting the reconstruction polynomial
    if strcmp(plotting_mode,'Reconstruction')==1
        if v==variable_to_be_plotted
        %    figure 
            x_grid_polynomial = unique(x_grid_polynomial); x_grid_polynomial=x_grid_polynomial';
            y_grid_polynomial = unique(y_grid_polynomial); y_grid_polynomial=y_grid_polynomial';
            Reconstruction_polynomial_total = Reconstruction_polynomial_total(1:n_x*CV_per_SV_side_x*Quadrature_order,1:n_y*CV_per_SV_side_y*Quadrature_order);
            surf(y_grid_polynomial,x_grid_polynomial,Reconstruction_polynomial_total); 
            grid on;
            colorbar;
            [xa xb ya yb] = Interval_extremes(interval_on_x, interval_on_y);
            xlabel('x'); ylabel('y'); zlabel('u'); 
            switch v 
                case 1 
                    title('Density: Reconstruction polynomial');
                    axis([xa xb ya yb 0.8 2])
                case 2 
                    title('X Momentum: Reconstruction polynomial');
                    axis([xa xb ya yb -0.2 0.2])
                case 3 
                    title('Y Momentum: Reconstruction polynomial');
                    axis([xa xb ya yb -0.2 0.2])
                case 4
                    title('Energy: Reconstruction polynomial');
                    axis([xa xb ya yb 0 2])
            end
            pause(0.2)

        end
    end
    
    
    end
