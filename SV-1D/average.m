% AVERAGE(Q,A,B,FUN,VAR_NUMBER) computes the average of the function FUN
% inside the interval [A,B]. If the function is an array of many variables,
% the amount of them is provided by VAR_NUMBER.

function u = average(Quadrature_Order,a,b,fun,var_number,initial_case)

    [x,omega] = GL_nodes_and_weights(Quadrature_Order,a,b);

    % Values of the input function in the Gauss-Legendre nodes
    for i=1:Quadrature_Order
            values(:,i)= fun(x(i),initial_case);            

    end
    
    % Computing the dot product 
    for i=1:var_number
            u(i) = 1/(b-a)*dot(omega,values(i,:));
    end
  
end
