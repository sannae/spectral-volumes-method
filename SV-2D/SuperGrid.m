% SUPERGRID creates the SV grid. 
%   The function receives as inputs the number of Spectral Volumes on
%   the x and y direction (N_X and N_Y) and the interval of x and y that the
%   user requires to be analysed as domains (INTERVAL_ON_X, INTERVAL_ON_Y).
%   The function gives back the total amount of volumes in the domain
%   (AMOUNT_OF_VOLUMES), the x and y coordinates (DOMAIN_X,DOMAIN_Y), the
%   index I and J of each cell, the corners of each I,J volume, the index of
%   horizontal and vertical edges, then all the coordinates of all the SV corners.
%
%   See also SUBGRID: building the CV grid.


function [amount_of_volumes,domain_x,domain_y,index_I,index_J,corners,edge_horizontal,edge_vertical,x_corner_SW,y_corner_SW,x_corner_SE,y_corner_SE,x_corner_NE,y_corner_NE,x_corner_NW,y_corner_NW,x_centers,y_centers] = SuperGrid(n_x,n_y,SV_discretization,k,mu,interval_on_x,interval_on_y)



    % Number of spectral volumes

    amount_of_volumes = n_x*n_y;
    
    
    
    
    % Defining the size of the grid: DOMAIN_X contains all the coordinates
    % of the grid nodes in the x direction, DOMAIN_Y on the y direction.
    % Spectral volumes nodes are now equispaced.
    
    [extreme_x_a,extreme_x_b,extreme_y_a,extreme_y_b] = Interval_extremes(interval_on_x,interval_on_y);
    if strcmp(SV_discretization,'Equispaced')==1
        domain_x = Equispaced_nodes(extreme_x_a,extreme_x_b,n_x);
        domain_y = Equispaced_nodes(extreme_y_a,extreme_y_b,n_y);
    else if strcmp(SV_discretization,'Hyperbolic_tangent')==1
        domain_x = hyperbolic_tangent(n_x,mu,extreme_x_a,extreme_x_b);
        domain_y = hyperbolic_tangent(n_y,mu,extreme_y_a,extreme_y_b);
        %domain_x = uniquetol(domain_x,1e-5); domain_x = domain_x';
        %domain_y = uniquetol(domain_y,1e-5); domain_y = domain_y';
        else
            disp('Discretization method not available for the SV grid')
            
        end
    end

    
    
    
    % Storing, for each volume (I,J), the indices of the volume, the
    % indices of the corners, the indices of the edges, the coordinates of
    % all the corners.
    
    for I=1:n_y
        for J=1:n_x
            
            
            
            % Indices of the spectral volume: the
            % index I (along rows, the first one is the bottom one) and J
            % (along columns, the first one is the left one)
            
            index_I(I,J) = I;
            index_J(I,J) = J;
            
            
            
            % corners: a 4-D matrix containing the
            % matrix of corners indices per each I,J volume (the corners are ordered in
            % a counter-clockwise manner, starting from the SW corner)
            
            corners(:,:,I,J) = corners_indices(I,J);
            
            
            
            % Edges: the index of horizontal edges (the I,J edge is the 
            % bottom or S horizontal edge of the I,J cell) and vertical 
            % edges (the I,J edge is the left or W vertical edge
            % of the I,J cell)
            
            edge_horizontal(:,:,I,J) = Edges_horizontal(I,J);
            edge_vertical(:,:,I,J) = Edges_vertical(I,J);
            
            
            
            % The x,y coordinates of all the corner nodes. Each direction
            % (SW,SE,NW,NE) gives back a matrix where the i,j element
            % corresponds to the corner on that direction for the I,J
            % volume.
            
            x_corner_SW(I,J) = domain_x(J);
            y_corner_SW(I,J) = domain_y(I);
            
            x_corner_SE(I,J) = domain_x(J+1);
            y_corner_SE(I,J) = domain_y(I);
            
            x_corner_NE(I,J) = domain_x(J+1);
            y_corner_NE(I,J) = domain_y(I+1);           

            x_corner_NW(I,J) = domain_x(J);
            y_corner_NW(I,J) = domain_y(I+1);
            
            
            
            % The x,y coordinates of the centers of each SV
            
            x_centers(I,J) = (x_corner_SE(I,J) + x_corner_SW(I,J))/2;
            y_centers(I,J) = (y_corner_NW(I,J) + y_corner_SW(I,J))/2;
            
  
        end
    end
    
