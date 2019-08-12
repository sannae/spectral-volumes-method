% EQUISPACED_NODES(X0,X1,K) computes K+1 equispaced nodes within the
% interval [X0,X1]

function x = equispaced_nodes(x0,x1,k)

x = linspace(x0,x1,k+1);

end
