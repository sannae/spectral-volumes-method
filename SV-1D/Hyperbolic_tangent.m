% HYPERBOLIC_TANGENT(K,MU,X0,X1) computes the nodes of an hyperbolic tangent
% discretization of order K, with clustering parameter MU, within the
% interval [X0,X1].

function x = hyperbolic_tangent(H,mu,x0,x1)


    for j=0:H
            logical_grid(j+1) = tanh(2*mu*j/H-mu)/tanh(mu);
    end
    
    x = (x1-x0)/2 * logical_grid + (x1+x0)/2;
    
    x([1 end]) = [];
    
end
