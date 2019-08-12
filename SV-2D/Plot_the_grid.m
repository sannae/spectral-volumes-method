% PLOT_THE_GRID plots the grid.
%   This function just plots some symbols to individuate the nodes of the
%   grid and then all the lines on the grid. It requires all the data from
%   the function building grids and a string TYPE_OF_GRID where the user
%   may choose what kind of grid he wants the function to show.




function Plot_the_grid(type_of_grid,n_x,n_y,CV_per_SV_side_x,CV_per_SV_side_y,x_corner_SW, y_corner_SW, x_corner_SE, y_corner_SE, x_corner_NE, y_corner_NE, x_corner_NW, y_corner_NW)

        % Choose the grid, therefore the color and the style

        if strcmp(type_of_grid,'main grid')==1
            color = 'b';
            width = 4;
            length_x = n_x;
            length_y = n_y;
        else if strcmp(type_of_grid,'subgrid')==1
                color = 'k';
                width = 1;
                length_x = n_x*CV_per_SV_side_x;
                length_y = n_y*CV_per_SV_side_y;
            end
        end
        
        % Plot the nodes with a star (in 3D)

        plot3(x_corner_SW(:,:),y_corner_SW(:,:),zeros(length_y,length_x),strcat(color,'*')); hold on;
        plot3(x_corner_SE(:,:),y_corner_SE(:,:),zeros(length_y,length_x),strcat(color,'*')); hold on;
        plot3(x_corner_NE(:,:),y_corner_NE(:,:),zeros(length_y,length_x),strcat(color,'*')); hold on;
        plot3(x_corner_NW(:,:),y_corner_NW(:,:),zeros(length_y,length_x),strcat(color,'*')); hold on;grid on;
        
        % Plot the nodes with a star (in 2D)
%         
%         plot(x_corner_SW(:,:),y_corner_SW(:,:),strcat(color,'*')); hold on;
%         plot(x_corner_SE(:,:),y_corner_SE(:,:),strcat(color,'*')); hold on;
%         plot(x_corner_NE(:,:),y_corner_NE(:,:),strcat(color,'*')); hold on;
%         plot(x_corner_NW(:,:),y_corner_NW(:,:),strcat(color,'*')); hold on;grid on;        
        
        % Plot lines
        
        for j=1:n_x*CV_per_SV_side_y
        line(x_corner_SW(:,j),y_corner_SW(:,j),'LineWidth',width,'Color',color)
        line(x_corner_NW(:,j),y_corner_NW(:,j),'LineWidth',width,'Color',color)
        line(x_corner_SE(:,j),y_corner_SE(:,j),'LineWidth',width,'Color',color)
        line(x_corner_NE(:,j),y_corner_NE(:,j),'LineWidth',width,'Color',color)
        end
        for i=1:n_y*CV_per_SV_side_x
            line(x_corner_SW(i,:),y_corner_SW(i,:),'LineWidth',width,'Color',color)
            line(x_corner_NW(i,:),y_corner_NW(i,:),'LineWidth',width,'Color',color)
            line(x_corner_SE(i,:),y_corner_SE(i,:),'LineWidth',width,'Color',color)
            line(x_corner_NE(i,:),y_corner_NE(i,:),'LineWidth',width,'Color',color)            
        end    
        
end
