% PRESSURE is simply computing the pressure P, knowing the average values U
% (array containing all the variables) and the physical parameter GAMMA.

function p = pressure(u,gamma)

    U = u(2)/u(1);
    p = (u(3) - 0.5*u(2)*U)*(gamma-1);

end
