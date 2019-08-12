% MONOMIAL(Q,A,B,K,CTR) computes the integral of the polynomial x^K inside
% the interval [A,B] with a Gauss-Legendre quadrature of order Q. The input
% CTR contains the centroid of the interval.

function u = monomial(Quadrature_Order,a,b,k,ctr)

[x,omega] = GL_nodes_and_weights(Quadrature_Order,a,b);

    % Values of the input function in the Gauss-Legendre nodes
    values= (x-ctr).^k;            

    % Computing the dot product 
    u = 1/(b-a)*dot(omega,values);
  

end
