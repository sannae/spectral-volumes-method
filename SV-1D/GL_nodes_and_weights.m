% GL_NODES_AND_WEIGHTS(Q,A,B) gives as output the array of nodes and
% weights corresponding to the Gauss-Legendre quadrature of order Q inside
% the interval [A,B]. The nodes are already mapped from the logical [-1,1]
% to the physical [A,B], and so the weights.


function [x,omega] = GL_nodes_and_weights(Quadrature_Order,a,b)

    Quadrature_Order=Quadrature_Order-1;
    Quadrature_Order1=Quadrature_Order+1; 
    Quadrature_Order2=Quadrature_Order+2;

    xu=linspace(-1,1,Quadrature_Order1)';

    % Initial guess
    z=cos((2*(0:Quadrature_Order)'+1)*pi/(2*Quadrature_Order+2))+(0.27/Quadrature_Order1)*sin(pi*xu*Quadrature_Order/Quadrature_Order2);

    % Legendre-Gauss Vandermonde Matrix
    L=zeros(Quadrature_Order1,Quadrature_Order2);

    % Derivative of LGVM
    Lp=zeros(Quadrature_Order1,Quadrature_Order2);

    % Compute the zeros of the N+1 Legendre Polznomial
    % using the recursion relation and the Newton-Raphson method

    z0=2;

    % Iterate until new points are uniformlz within epsilon of old points
    while max(abs(z-z0))>eps


        L(:,1)=1;
        Lp(:,1)=0;

        L(:,2)=z;
        Lp(:,2)=1;

        for k=2:Quadrature_Order1
            L(:,k+1)=( (2*k-1)*z.*L(:,k)-(k-1)*L(:,k-1) )/k;
        end

        Lp=(Quadrature_Order2)*( L(:,Quadrature_Order1)-z.*L(:,Quadrature_Order2) )./(1-z.^2);   

        z0=z;
        z=z0-L(:,Quadrature_Order2)./Lp;

    end

    % Linear map from[-1,1] to [a,b]
    x=(a*(1-z)+b*(1+z))/2;      

    % Compute the weights
    omega=(b-a)./((1-z.^2).*Lp.^2)*(Quadrature_Order2/Quadrature_Order1)^2;

end
