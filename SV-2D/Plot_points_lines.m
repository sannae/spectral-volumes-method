% PLOT_POINTS_LINES     Is used in plotting the averaged values of the
% variables. Given all the corners coordinates of a cell and the value of
% the variable U, it can plot, according to the input TYPE_OF_PLOT:
%   - POINTS, i.e. the value is plotted only on the corners of the
%   corresponding cell;
%   - LINES, i.e. the values are connected on lines, thus identificating
%   the rectangle;
%   - RECTANGLES, i.e. the value on each cell is represented as a rectangle




function Plot_points_lines(type_of_plot,x_corner_SW_CV,y_corner_SW_CV,x_corner_SE_CV,y_corner_SE_CV,x_corner_NE_CV,y_corner_NE_CV,x_corner_NW_CV,y_corner_NW_CV,u)

    switch type_of_plot
        
        case 'Points'

        % Points
        plot3(x_corner_SW_CV,y_corner_SW_CV,u,'r*'); hold on;
        plot3(x_corner_SE_CV,y_corner_SE_CV,u,'r*'); hold on;
        plot3(x_corner_NE_CV,y_corner_NE_CV,u,'r*'); hold on;        
        plot3(x_corner_NW_CV,y_corner_NW_CV,u,'r*'); hold on;

        case 'Lines'
        
        % Horizontal lines
        plot3([x_corner_SW_CV x_corner_SE_CV],[y_corner_SW_CV y_corner_SW_CV],[u u],'LineWidth',1,'Color','r'); hold on;
        plot3([x_corner_NW_CV x_corner_NE_CV],[y_corner_NW_CV y_corner_NW_CV],[u u],'LineWidth',1,'Color','r'); hold on;
        
        % Vertical lines
        plot3([x_corner_SW_CV x_corner_SW_CV],[y_corner_SW_CV y_corner_NW_CV],[u u],'LineWidth',1,'Color','r'); hold on;
        plot3([x_corner_SE_CV x_corner_SE_CV],[y_corner_SE_CV y_corner_NE_CV],[u u],'LineWidth',1,'Color','r'); hold on;
   
        case 'Rectangles'
                
        % 3D Rectangles
        fill3( [x_corner_SW_CV x_corner_SE_CV x_corner_NE_CV x_corner_NW_CV x_corner_SW_CV], [y_corner_SW_CV y_corner_SE_CV y_corner_NE_CV y_corner_NW_CV y_corner_SW_CV], [u u u u u],[1 1 0])
        
    end
        
end
