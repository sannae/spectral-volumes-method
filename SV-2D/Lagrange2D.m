function Basis_2D = lagrange2D(x,y,pointx,pointy,chosen_degree)

    Basis_x = lagrange(x,pointx,chosen_degree);
    Basis_y = lagrange(y,pointy,chosen_degree);
    
    Basis_2D = Basis_x*Basis_y;
    
% If, instead of wanting as output the exact value of the 2D Lagrange basis
% function, the user wants to have the whole function in the given domain
% x,y, then comment all the previous lines and uncomment the following
% ones. The following function provides a matrix of values to be used in a
% plot3.

%     Basis_x = lagrange(x,pointx,chosen_degree);
%     Basis_y = lagrange(y,pointy,chosen_degree); 
%     
%     for i=1:length(x)
%         for j=1:length(y)
%              Basis_2D(i,j) = Basis_x(:,i).*Basis_y(:,j);
%         end
%     end
    
% If the user also wants to plot the 2D Lagrange basis function in the x,y 
% domain, he may wants to uncomment the following line too to have a
% surface representation.
    
%     figure
%     surf(x,y,Basis_2D); hold on;
    
end
