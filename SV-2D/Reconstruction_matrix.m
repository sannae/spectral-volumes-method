% RECONSTRUCTION_MATRICES   Creates an array of reconstruction matrices,
%   each one corresponding to the INDEX_I,INDEX_J spectral volume.
%   First of all, since there's no simple way to build a reconstruction
%   matrix keeping the I,J frame of reference used to build the CV grid,
%   the first routine checks, for every cell, if it belongs to the selected
%   spectral volumes and puts the cell in a linear increasing order from 1
%   to K. In this way, the reconstruction problem can be solved. 
%   Every element of each reconstruction matrix is then filled with the
%   integral of the standard basis function in the same cell, with order K.
%   A check is then performed, giving the Conditioning Number of all the
%   computed reconstruction matrices.
%
%   See also STANDARD_BASIS_ARRAY, RECONSTRUCTION_COEFFICIENTS_SOLVING.


function Reconstruction_matrices = Reconstruction_matrix(n_y,n_x,CV_per_SV_side_y,CV_per_SV_side_x, x_centers_CV, y_centers_CV,Quadrature_order,x_corner_SW_CV,y_corner_SW_CV,x_corner_SE_CV,y_corner_NW_CV,k,area,x_centers,y_centers,Chosen_basis)


    for index_I = 1:n_y
        for index_J = 1:n_x

            % Obtaining an array with the x and y coordinates of the CV centers

            for i=1:n_y*CV_per_SV_side_y
                for j=1:n_x*CV_per_SV_side_x

                    % In order to build a reconstruction matrix where we can
                    % list from 1 to k the CVs, we need to convert the subgrid
                    % information indices (i,j) into a single number, thus
                    % ordering the CVs inside an SV from the left bottom cell to the
                    % right top cell.

                    [internal_i internal_j] = Which_number_of_CV_in_a_SV(i,j,CV_per_SV_side_y,CV_per_SV_side_x);

                    [SV_belongs_to_flag_i SV_belongs_to_flag_j] = Which_SV_belongs_to(i,j,CV_per_SV_side_x,CV_per_SV_side_y);

                    if (SV_belongs_to_flag_i == index_I && SV_belongs_to_flag_j == index_J)

                        Global_index_SV = Global_internal_index(internal_i,internal_j,CV_per_SV_side_x,CV_per_SV_side_y);

                        % We re-align the centers, again from an (i,j) frame to
                        % a 1...k frame

                        x_CV_centers_realigned(Global_index_SV) = x_centers_CV(i,j);
                        y_CV_centers_realigned(Global_index_SV) = y_centers_CV(i,j);

                    end
                end
            end





            % Building the Reconstruction matrices

            for i=1:n_y*CV_per_SV_side_y
                for j=1:n_x*CV_per_SV_side_x

                    [internal_i internal_j] = Which_number_of_CV_in_a_SV(i,j,CV_per_SV_side_y,CV_per_SV_side_x);

                    [SV_belongs_to_flag_i SV_belongs_to_flag_j] = Which_SV_belongs_to(i,j,CV_per_SV_side_x,CV_per_SV_side_y);

                    if (SV_belongs_to_flag_i == index_I && SV_belongs_to_flag_j == index_J)

                        Global_index_SV = Global_internal_index(internal_i,internal_j,CV_per_SV_side_x,CV_per_SV_side_y);

                                Reconstruction_matrices(Global_index_SV,:,index_I,index_J) = Standard_basis_integral(Quadrature_order,x_corner_SW_CV(i,j),y_corner_SW_CV(i,j),x_corner_SE_CV(i,j),y_corner_NW_CV(i,j),k,area(i,j),x_centers(index_I,index_J),y_centers(index_I,index_J),Chosen_basis);

                    end
                end
            end




        % Check on the Conditioning number of all the matrices:

        Conditioning_number(index_I,index_J) = cond(Reconstruction_matrices(:,:,index_I,index_J));  



        end
    end

end
