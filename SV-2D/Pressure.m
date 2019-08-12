% PRESSURE      Computes the pressure, given the averaged values array U
%   and the fluid adiabatic parameter GAMMA. The output is the scalar
%   averaged P.


function p = pressure(u,gamma)

    U = u(2)/u(1);
    V = u(3)/u(1);
    
    p = (u(4) - 0.5*u(1)*(U.^2+V.^2))*(gamma-1);

end
