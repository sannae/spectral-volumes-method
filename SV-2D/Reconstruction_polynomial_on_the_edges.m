% RECONSTRUCTION_POLYNOMIAL_ON_THE_EDGES    Evaluates the reconstruction 
%   polynomial on the quadrature points of every edge of every cell. The 
%   resulting structure hosts all the values. The structure is described 
%   below.
%   Uncomment the parts involving plot to have a dot-by-dot figure of the
%   reconstruction polynomial on the edge quadrature points.



function Reconstruction_polynomial_edges = Reconstruction_polynomial_on_the_edges(k,var_number,n_x,n_y,CV_per_SV_side_y,CV_per_SV_side_x,Quadrature_order,x_corner_SW_CV,y_corner_SW_CV,x_corner_SE_CV,y_corner_SE_CV,x_corner_NE_CV,y_corner_NE_CV,x_corner_NW_CV,y_corner_NW_CV,Standard_basis_array,Reconstruction_coefficients,x_centers,y_centers,Chosen_basis,u)

    for v=1:var_number

%       figure;

        for index_I = 1:n_y
            for index_J = 1:n_x

                for i=1:n_y*CV_per_SV_side_y
                    for j=1:n_x*CV_per_SV_side_x

                        % Same routine to find the CV i,j in the SV
                        % index_I,index_J
                        [internal_i internal_j] = Which_number_of_CV_in_a_SV(i,j,CV_per_SV_side_y,CV_per_SV_side_x);
                        [SV_belongs_to_flag_i SV_belongs_to_flag_j] = Which_SV_belongs_to(i,j,CV_per_SV_side_x,CV_per_SV_side_y);

                        if (SV_belongs_to_flag_i == index_I && SV_belongs_to_flag_j == index_J)



                            % In order to separate the average from the
                            % rest of the reconstruction polynomial, we
                            % have to subtract it from the first
                            % reconstruction coefficient
                            Reconstruction_coefficients(1,1,internal_i,internal_j,index_I,index_J,v) = Reconstruction_coefficients(1,1,internal_i,internal_j,index_I,index_J,v) - u(i,j,v);


                            for edge=1:4

                                % Storing the x and y coordinates of all the
                                % quadrature points on an edge
                                [x y edge_selected] = Quadrature_storing_function(i,j,edge,Quadrature_order,x_corner_SW_CV,y_corner_SW_CV,x_corner_SE_CV,y_corner_SE_CV,x_corner_NE_CV,y_corner_NE_CV,x_corner_NW_CV,y_corner_NW_CV);

                                for q=1:Quadrature_order

                                    
                                    
                                    % Choosing the basis and building
                                    % the array of it

                                    [x_basis y_basis] = Set_basis(Chosen_basis,x(q),y(q),x_centers(index_I,index_J),y_centers(index_I,index_J));

                                    Standard_array = Standard_basis_array(x_basis,y_basis,k);

                                    
                                    
                                    % The structure of the following
                                    % matrix of reconstructed edge values is
                                    % the following: an array of
                                    % QUADRATURE_ORDER elements corresponding
                                    % to the selected EDGE, the CV I,J and the
                                    % SV INDEX_I,INDEX_J and the variable V

                                    Reconstruction_polynomial_edges(q,edge,i,j,v) = u(i,j,v) + dot(Reconstruction_coefficients(:,1,internal_i,internal_j,index_I,index_J,v),Standard_array);

                                end
                            end
                        end
                    end
                end
            end
        end

    end
    
end
