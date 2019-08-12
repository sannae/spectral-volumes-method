% Centroid function

function u = centroid(Q,a,b,k)

[x,omega] = GL_nodes_and_weights(Q,a,b);

    % Values of the input function in the Gauss-Legendre nodes
    values= x.^k;            

    % Computing the dot product 
    u = 1/(b-a)*dot(omega,values);
  

end
