% PLOT THE AVERAGES     Plots the solution as rectangles. Each rectangle
%   corresponds to the average of the cell I,J. This function receives as
%   input all the grid parameters, the solution and the chosen variable to be
%   plotted. Although it's uncommented, this function is called by the Main
%   only if the PLOTTING_MODE chosen by the user is 'Averages'.
%
%   See also RECONSTRUCTION_POLYNOMIAL_INTERNAL_VALUES.

function Plot_averages(n_x,n_y,CV_per_SV_side_x,CV_per_SV_side_y,x_corner_SW_CV,y_corner_SW_CV,x_corner_SE_CV,y_corner_SE_CV,x_corner_NE_CV,y_corner_NE_CV,x_corner_NW_CV,y_corner_NW_CV,u,variable_to_be_plotted,plotting_mode,interval_on_x,interval_on_y)

    if strcmp(plotting_mode,'Averages')==1

        % Initializing the vectors of coordinates and values
        X = [];
        Y = [];
        U = [];
        for i=1:n_y*CV_per_SV_side_y
            for j=1:n_x*CV_per_SV_side_x

                % Build the matrices of coordinates and values
                X = [X; x_corner_SW_CV(i,j) x_corner_SE_CV(i,j) x_corner_NE_CV(i,j) x_corner_NW_CV(i,j) x_corner_SW_CV(i,j)];
                Y = [Y; y_corner_SW_CV(i,j) y_corner_SE_CV(i,j) y_corner_NE_CV(i,j) y_corner_NW_CV(i,j) y_corner_SW_CV(i,j)];
                U = [U; u(i,j,variable_to_be_plotted) u(i,j,variable_to_be_plotted) u(i,j,variable_to_be_plotted) u(i,j,variable_to_be_plotted) u(i,j,variable_to_be_plotted)];
            end
        end

        X=X';Y=Y';U=U';


        % Plot rectangles

        fill3(X,Y,U,U); hold on;

        [xa xb ya yb] = Interval_extremes(interval_on_x, interval_on_y);
        xlabel('x'); ylabel('y'); zlabel('u');
        colorbar
        grid on;
        switch variable_to_be_plotted
            case 1
                title('Density: Cell-averages');
                axis([xa xb ya yb 0.8 2])
            case 2
                title('X Momentum: Cell-averages');
                axis([xa xb ya yb -0.2 0.2])
            case 3
                title('Y Momentum: Cell-averages');
                axis([xa xb ya yb -0.2 0.2])
            case 4
                title('Energy: Cell-averages');
                axis([xa xb ya yb 0 2])
        end
        pause(0.2)
        hold off;

    end
    
end
