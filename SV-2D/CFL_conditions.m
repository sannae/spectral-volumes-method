% CFL_CONDITIONS    Given the mesh parameters and problem parameters, the
%   CFL_NUMBER and the coordinates of the cell corners, the function computes
%   the DT following the Courant-Friedrichs-Levy conditions, to be used in
%   updating the solution.
%
%   The 2D CFL conditions are based on choosing the minimum DT between a
%   very large one and the one computed with the fastest sound-wave that
%   may propagate in the domain. The latter is computed using the so-called
%   INFORMATION_VELOCITY, which is the sum of the fluid motion with the
%   SOUNDSPEED.  


function dt = CFL_conditions(n_x,n_y,CV_per_SV_side_x,CV_per_SV_side_y,u,gamma,CFLnumber,x_corner_SW_CV,x_corner_SE_CV,y_corner_SW_CV,y_corner_NW_CV)

    dt=10^12;
    
    for i=1:n_y*CV_per_SV_side_y
        for j=1:n_x*CV_per_SV_side_x
            
            % Sizes
            Delta_x = abs(x_corner_SW_CV(i,j) - x_corner_SE_CV(i,j));
            Delta_y = abs(y_corner_SW_CV(i,j) - y_corner_NW_CV(i,j));
            
            % Computing average pressure of the i,j-th cell
            p = pressure(u(i,j,:),gamma);
            
            % Computing soundspeed of the i,j-th cell
            soundspeed = sqrt(abs(gamma*p/u(i,j,1)));
            
            % Information velocity over x and y
            U = u(i,j,2)/u(i,j,1);
            V = u(i,j,3)/u(i,j,1);
            information_velocity = sqrt(U^2+V^2)+soundspeed;
            
            % Temporary time interval
            Delta = min( [Delta_x Delta_y] );
            dt_temp = CFLnumber*Delta/information_velocity;
            
            % Minimum time interval
            dt=min(dt_temp,dt);
            
        end
    end

end
