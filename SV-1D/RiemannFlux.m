% RIEMANNFLUX calls the selected Riemann Flux F_RIEM by receiving as input
% the left flux FL, the right flux FR, the left reconstructed value UL and
% the right reconstructed value UR.


function f_riem = RiemannFlux(fL,fR,uL,uR)

    % Lax-Friedrichs flux
    alpha = 1;
    f_riem = 0.5*(fR + fL -alpha*(uR-uL));
    
end
