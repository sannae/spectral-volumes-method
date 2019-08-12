% GL_QUADRATURE(Q,A,B,FUN) computes the value of the integral of the
% function FUN inside the interval [A,B] with a Gauss-Legendre quadrature
% of order Q.


function u = GL_quadrature(Q,a,b,fun)

    [x,omega] = GL_nodes_and_weights(Q,a,b);

    % Values of the input function in the Gauss-Legendre nodes
    for i=1:Q
            values(:,i)= fun(x(i));            

    end
    
    % Computing the dot product 
    for i=1:Q
            u(i,1) = dot(omega,values(i,:));
    end
    
end
