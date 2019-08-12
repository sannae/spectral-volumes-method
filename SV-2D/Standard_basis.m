% STANDARD_BASIS    Gives the standard monomial basis evaluated in a point
%   or in an array of points, provided the input coordinate X and the desired
%   degree K.


function Basis = Standard_basis(x,k)

    Basis = x.^k;
       

% If you want to plot the function itself, then the input X has to be an 
% array of values. In this case, uncomment the following lines if you want to see the
% Lagrange basis function chosen as output.

%     figure
%     plot(x,Basis,'LineWidth',1); hold on;
    


end
