% GL_NODES_AND_WEIGHTS_GOLUB_WELSCH  Finds the nodes and weights of a
%   Gauss-Legendre Quadrature of order Q in the interval A,B with the
%   Golub-Welsch algorithm. 
%   
%   Author: Nick Hale, 8th November 2011



function [x w] = GL_nodes_and_weights_Golub_Welsch(Q,a,b)    

    n = Q; format short

    beta = .5./sqrt(1-(2*(1:n-1)).^(-2)); % 3-term recurrence coeffs
    T = diag(beta,1) + diag(beta,-1);     % Jacobi matrix
    [V,D] = eig(T);                       % Eigenvalue decomposition
    z = diag(D); [z,i] = sort(z);         % Legendre points
    x = 0.5*(b-a).*z + 0.5*(b+a);         % Nodes mapping
    w = 2*V(1,i).^2; w=w';                % Quadrature weights

    
end
