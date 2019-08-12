% EXPLICIT_EULER    Is a time scheme used to update the solution, based on
%   the Explicit Euler method. With all the grid parameters, the function
%   receives as input the integrated fluxes, the areas of all the cells and
%   the time interval. It gives back the updated solution.
%
%   See also CFL_CONDITIONS.

function u = Explicit_euler(u,n_x,n_y,CV_per_SV_side_x,CV_per_SV_side_y,flux_integrated_over_edge_horizontal,flux_integrated_over_edge_vertical,dt,area)

    for i=1:n_y*CV_per_SV_side_y
        for j=1:n_x*CV_per_SV_side_x

            flux_bottom = flux_integrated_over_edge_horizontal(i,j,:);
            flux_top = flux_integrated_over_edge_horizontal(i+1,j,:);

            flux_left = flux_integrated_over_edge_vertical(i,j,:);
            flux_right = flux_integrated_over_edge_vertical(i,j+1,:);

            u(i,j,:) = u(i,j,:) - (dt/area(i,j)) * (flux_top - flux_bottom + flux_right - flux_left);

        end
    end

end
