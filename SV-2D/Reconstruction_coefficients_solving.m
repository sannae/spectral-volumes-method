% RECONSTRUCTION_COEFFICIENTS_SOLVING   Is the function that actually
%   performs the solution of the linear reconstruction system. Receiving as
%   input the grid parameters, the RECONSTRUCTION_MATRICES and the
%   cell-averaged variables matrix U, it stores the averages in an ordered
%   array (using the same routine to convert from the I,J frame to the 1...K
%   frame) and then uses the function MLDIVIDE to solve the problem.
%   The output is the vector containing the RECONSTRUCTION_COEFFICIENTS
%   corresponding to the control volume I,J, to the spectral volume 
%   INDEX_I,INDEX_J and the variable V.
%
%   See also RECONSTRUCTION_MATRIX.



function Reconstruction_coefficients = Reconstruction_coefficients_solving(var_number, n_y,n_x, CV_per_SV_side_x,CV_per_SV_side_y,Reconstruction_matrices,u)

    for v=1:var_number

        for index_I = 1:n_y
            for index_J = 1:n_x 

                for i=1:n_y*CV_per_SV_side_y
                    for j=1:n_x*CV_per_SV_side_x

                        % Same routine as before to convert from a (i,j) frame
                        % to a 1...k frame

                        [internal_i internal_j] = Which_number_of_CV_in_a_SV(i,j,CV_per_SV_side_y,CV_per_SV_side_x);
                        [SV_belongs_to_flag_i SV_belongs_to_flag_j] = Which_SV_belongs_to(i,j,CV_per_SV_side_x,CV_per_SV_side_y);

                        if (SV_belongs_to_flag_i == index_I && SV_belongs_to_flag_j == index_J)

                            Global_index_SV = Global_internal_index(internal_i,internal_j,CV_per_SV_side_x,CV_per_SV_side_y);
                            
                            % Storing the cell-averages inside a specific SV into
                            % an array: this is going to be the known term when
                            % solving the linear reconstruction system

                            averages(Global_index_SV,1,index_I,index_J,v) = u(i,j,v);

                        end
                    end
                end
                
                % Applying the Matlab function MLDIVIDE to solve the linear
                % reconstruction problem for each spectral volume
                temp = Reconstruction_matrices(:,:,index_I,index_J)\(averages(:,1,index_I,index_J,v));
                for i=1:CV_per_SV_side_y
                    for j=1:CV_per_SV_side_x
                        Reconstruction_coefficients(:,1,i,j,index_I,index_J,v) = temp;
                    end
                end
             end
        end
    end
end
