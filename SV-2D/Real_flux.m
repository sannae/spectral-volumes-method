% REAL_FLUX_X   Computes the real flux over the x directions. It receives
%   as input the array of variables U and the physical parameter GAMMA.

function flux_x = Real_flux(u,gamma)

    % Velocities
    U = u(2)/u(1);
    V = u(3)/u(1);

    % Pressure
    p = pressure(u,gamma);

    % Flux components
    flux_x(1) = u(2);
    flux_x(2) = u(2)*U + p;
    flux_x(3) = u(2)*V;
    flux_x(4) = U*(u(4) + p);

end
