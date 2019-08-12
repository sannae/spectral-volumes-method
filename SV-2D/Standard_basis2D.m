% BASIS_2D  Simply provides the product between two standard basis
%   functions, provided the coordinates X,Y and the degrees of both the
%   required functions (K,D)


function Basis_2D = Standard_basis2D(x,y,degree_x,degree_y)

   Basis_x = Standard_basis(x,degree_x);
   Basis_y = Standard_basis(y,degree_y);
   
   Basis_2D = Basis_x*Basis_y;
    
    
   
   
% If, instead of wanting as output the exact value of the 2D Lagrange basis
% function, the user wants to have the whole function in the given domain
% x,y, then comment all the previous lines and uncomment the following
% ones. The following function provides a matrix of values to be used in a
% plot3.

%     Basis_x = Standard_basis(x,k);
%     Basis_y = Standard_basis(y,k);
%     
%     for i=1:length(x)
%         for j=1:length(y)
%              Basis_2D(i,j) = Basis_x(:,i).*Basis_y(:,j);
%         end
%     end
    



% If the user also wants to plot the 2D Lagrange basis function in the x,y 
% domain, he may wants to uncomment the following line too to have a
% surface representation.
%     
%     figure
%      surf(x,y,Basis_2D); hold on;
    
    
end
