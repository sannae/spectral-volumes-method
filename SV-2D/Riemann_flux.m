% RIEMANN_FLUX  Computes the Rusanov Riemann Solver between two elements.
%   Providing the fluxes and the reconstructed values (both as arrays,
%   containing all the variables), the function computes the soundspeed
%   from left and right and uses them to compute the eigenvalue Alpha to be
%   used in the Rusanov flux formula.
%
%   See also REAL_FLUX.



function f_Riemann = Riemann_flux(flux_left,flux_right,u_left,u_right,gamma)

    % Pressure
    p_left=pressure(u_left,gamma);
    p_right=pressure(u_right,gamma);
    
    % Soundspeed
    soundspeed_left = sqrt(abs(gamma*p_left/u_left(1)));
    soundspeed_right = sqrt(abs(gamma*p_right/u_right(1)));
    
    % Maximum eigenvalue
    alpha = max([ abs(u_left(2)/u_left(1))+soundspeed_left abs(u_right(2)/u_right(1)) + soundspeed_right ]);
    
    % Rusanov flux formula
    f_Riemann = 0.5*(flux_left + flux_right - alpha*(u_right-u_left));
    
end
