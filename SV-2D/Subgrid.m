% SUBGRID creates the CV grid, provided the SV grid.
%   The function receives as input the order of the method K, the
%   discretization parameter MU, the number of SV required by the user both
%   on x and y direction (N_X and N_Y) and the complete map of the corners
%   of the spectral volumes, provided as output by the function SUPERGRID.
%   The function gives the general features of the subgrid (like the number
%   of cells per spectral volumes, as required by the user), the x and y
%   coordinates of the CV corners in the domain, the indices i and j of
%   each cell and then it builts the grid itself, providing corners,
%   horizontal edges, vertical edges and corners coordinates per each cell.
%
%   See also SUPERGRID: building the SV grid.
%   See also WHICH_SV_BELONGS_TO: which SV a given CV belongs to.


function [CV_per_SV_side_x,CV_per_SV_side_y,index_i_CV,index_j_CV,domain_x_CV_tot,domain_y_CV_tot,corners_CV,edge_horizontal_CV,edge_vertical_CV,x_corner_SW_CV,y_corner_SW_CV,x_corner_SE_CV,y_corner_SE_CV,x_corner_NE_CV,y_corner_NE_CV,x_corner_NW_CV,y_corner_NW_CV,area,x_centers_CV,y_centers_CV] = SubGrid(n_x,n_y,CV_discretization,k,mu,x_corner_SW,y_corner_SW,x_corner_SE,y_corner_NW)



    % General features of the subgrid: the number of CV inside an SV, both
    % on x and y directions, should be the same and equal to K, so that
    % each spectral volume contains (K)^2 cells.

    CV_per_SV_side_x = k;
    CV_per_SV_side_y = k;

    
    
    
    % Building the domain over x and y of the CVs, per each cell and then
    % re-linking all the coordinates in a single vector. Plus, the matrix of
    % the CV indices i and j is built.

    for I=1:n_y
        for J=1:n_x

            % Domain over x and y with proper coordinates per each cell

            [extreme_x_a,extreme_x_b,extreme_y_a,extreme_y_b] = Interval_extremes([x_corner_SW(I,J) x_corner_SE(I,J)],[y_corner_SW(I,J),y_corner_NW(I,J)]);
            if strcmp(CV_discretization,'Hyperbolic_tangent')==1
                domain_x_CV(:,:,I,J) = hyperbolic_tangent(k,mu,extreme_x_a,extreme_x_b);
                domain_y_CV(:,:,I,J) = hyperbolic_tangent(k,mu,extreme_y_a,extreme_y_b);
            else if strcmp(CV_discretization,'Equispaced')==1
                domain_x_CV(:,:,I,J) = Equispaced_nodes(extreme_x_a,extreme_x_b,CV_per_SV_side_x);
                domain_y_CV(:,:,I,J) = Equispaced_nodes(extreme_y_a,extreme_y_b,CV_per_SV_side_y);
                else
                    disp('Discretization method not available for the CV grid')
                end
            end
            
                    

            for ii=1:CV_per_SV_side_y
                for jj=1:CV_per_SV_side_x

                    % The big matrices with i,j indices

                    index_i_CV((I-1)*CV_per_SV_side_y + ii,(J-1)*CV_per_SV_side_x + jj) = (I-1)*CV_per_SV_side_y + ii;
                    index_j_CV((I-1)*CV_per_SV_side_y + ii,(J-1)*CV_per_SV_side_x + jj) = (J-1)*CV_per_SV_side_x + jj;

                end
            end
        end
    end

    
    
    
    
    % Re-ordering the coordinates of the total grid

    domain_x_CV_tot = [];
    domain_y_CV_tot = [];
    for J=1:n_x
        domain_x_CV_tot = [domain_x_CV_tot domain_x_CV(:,:,I,J)];
    end
    for I=1:n_y
        domain_y_CV_tot = [domain_y_CV_tot domain_y_CV(:,:,I,J)];
    end
    domain_x_CV_tot = uniquetol(domain_x_CV_tot,1e-5); domain_x_CV_tot = domain_x_CV_tot';
    domain_y_CV_tot = uniquetol(domain_y_CV_tot,1e-5); domain_y_CV_tot = domain_y_CV_tot';


    
    
    
    % Now, building the main sub grid: the approach is the same as the
    % SuperGrid of Spectral Volumes

    for i=1:n_y*CV_per_SV_side_y
        for j=1:n_x*CV_per_SV_side_x

            
            
            % Corners of the i,j cell

            corners_CV(:,:,i,j) = corners_indices(i,j);

            
            
            % Horizontal and vertical edges of the i,j cell

            edge_horizontal_CV(:,:,i,j) = Edges_horizontal(i,j);
            edge_vertical_CV(:,:,i,j) = Edges_vertical(i,j);

            
            
            % Coordinates of the CV corners of the i,j cell

            x_corner_SW_CV(i,j) = domain_x_CV_tot(1,j);
            y_corner_SW_CV(i,j) = domain_y_CV_tot(1,i);

            x_corner_SE_CV(i,j) = domain_x_CV_tot(1,j+1);
            y_corner_SE_CV(i,j) = domain_y_CV_tot(1,i);

            x_corner_NE_CV(i,j) = domain_x_CV_tot(1,j+1);
            y_corner_NE_CV(i,j) = domain_y_CV_tot(1,i+1);

            x_corner_NW_CV(i,j) = domain_x_CV_tot(1,j);
            y_corner_NW_CV(i,j) = domain_y_CV_tot(1,i+1);

            
            
            % Computing area of the i,j cell
            
            area(i,j) = Area(x_corner_SW_CV(i,j),x_corner_SE_CV(i,j),y_corner_SW_CV(i,j),y_corner_NW_CV(i,j));             
            
            
            
            % Computing the centers of each CV
            
            x_centers_CV(i,j) = (x_corner_SE_CV(i,j) + x_corner_SW_CV(i,j))/2;
            y_centers_CV(i,j) = (y_corner_NW_CV(i,j) + y_corner_SW_CV(i,j))/2;
            
        end
    end
  
end
