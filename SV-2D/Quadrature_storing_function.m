% QUADRATURE_STORING_FUNCTION   It's the function that stores the
%   geometrical data of the cells, useful to get the values at the quadrature
%   points on the edges of each CV. 
%
%   The inputs are: the CV indices I,J, the number of the EDGE (1=South,
%   2=East, 3=North, 4=West), the QUADRATURE_ORDER and the coordinates of all
%   the verteces.
%
%   The outputs are: the array X containing the x coordinates of the edge
%   quadrature points on the selected EDGE, the array Y containing the y
%   coordinates of the same points, and a string EDGE_SELECTED confirming
%   that the edge is the requested one.



function [x y edge_selected] = Quadrature_storing_function(i,j,edge,Quadrature_order,x_corner_SW_CV,y_corner_SW_CV,x_corner_SE_CV,y_corner_SE_CV,x_corner_NE_CV,y_corner_NE_CV,x_corner_NW_CV,y_corner_NW_CV)

    switch edge

        case 1 % South edge

            x = GL_nodes_and_weights_Golub_Welsch(Quadrature_order,x_corner_SW_CV(i,j),x_corner_SE_CV(i,j));
            y = ones(Quadrature_order,1).*y_corner_SW_CV(i,j); 
            edge_selected = 'South';

        case 2 % East edge

            x = ones(Quadrature_order,1).*x_corner_SE_CV(i,j); 
            y = GL_nodes_and_weights_Golub_Welsch(Quadrature_order,y_corner_SE_CV(i,j),y_corner_NE_CV(i,j));
            edge_selected = 'East';
            
        case 3 % North edge

            x = GL_nodes_and_weights_Golub_Welsch(Quadrature_order,x_corner_NW_CV(i,j),x_corner_NE_CV(i,j));
            y = ones(Quadrature_order,1).*y_corner_NW_CV(i,j);
            edge_selected = 'North';

        case 4 % West edge

            x = ones(Quadrature_order,1).*x_corner_SW_CV(i,j);
            y = GL_nodes_and_weights_Golub_Welsch(Quadrature_order,y_corner_SW_CV(i,j),y_corner_NW_CV(i,j));
            edge_selected = 'West';

    end
    
    x=x';
    y=y';

end
