% PROJECTION    Is used in computing the fluxes. According to the EDGE
%   selected, the function projects the vector of variables U in order to
%   have the proper Normal Velocity and Tangential Velocity to be used in
%   computing the fluxes.
%
%   See also COMPUTE_FLUXES.


function u = Projection(u,edge)
    
    % Horizontal edge
    if edge==1 || edge==3 

        % The normal velocity is the one along y
        normal_velocity =u(3); 
        % The tangential velocity is the one along x
        tangential_velocity = u(2); 

        
    % Vertical edge    
    else 

        % The normal velocity is the one along x
        normal_velocity = u(2); 
        % The tangential velocity is the one along y
        tangential_velocity = u(3); 

    end

    % The new vector of variables, the one used to compute the flux
    u(:) = [u(1), normal_velocity, tangential_velocity, u(4)];

end
