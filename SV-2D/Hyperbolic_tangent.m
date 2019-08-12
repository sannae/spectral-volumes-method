% HYPERBOLIC_TANGENT   Provides a 1-D array of coordinates with the
%   Hyperbolic Tangent discretization, provided the order H, the
%   discretization parameter MU and the two extremes of the interval X0 and
%   X1

function x = hyperbolic_tangent(H,mu,x0,x1)

    for j=0:H
            logical_grid(j+1) = tanh(2*mu*j/H-mu)/tanh(mu);
    end
    
    x = (x1-x0)/2 * logical_grid + (x1+x0)/2;

end
