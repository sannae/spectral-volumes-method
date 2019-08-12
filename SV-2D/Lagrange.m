%LAGRANGE   
% Evaluating the Lagrange basis function of degree CHOSEN_DEGREE in the
% point X, using POINTX as coordinates of interpolation nodes.

function Basis = lagrange(x,pointx,chosen_degree)

    n=size(pointx,2);
    L = ones(n,1);
       for i=1:n
          for j=1:n
             if pointx(i)~=pointx(j)
                L(i)=L(i)*(x-pointx(j))/(pointx(i)-pointx(j));
             end
          end
       end
       Basis = L(chosen_degree);
       
       
       
% By uncommenting the following lines of code and commenting the previous ones, 
% you can have the function evaluated in all the points you want. This 
% is useful in case you want to plot it. In this case, X has to be an array
% and not a scalar.

%     n=size(pointx,2);
%     L=ones(n,size(x,2));
%        for i=1:n
%           for j=1:n
%              if pointx(i)~=pointx(j)
%                 L(i,:)=L(i,:).*(x-pointx(j))/(pointx(i)-pointx(j));
%              end
%           end
%        end
%        Basis = L(chosen_degree,:);
       


% In the second case, uncomment the following lines if you want to see the
% Lagrange basis function chosen as output. The plot shows the function and
% marks the fact that the degree-th function is =1 on the degree-th
% interpolation node and is =0 on all the others.

%     figure
%     plot(x,Basis,'LineWidth',2); hold on;
%     plot([x(1) x(end)],[1 1],'--k'); hold on;
%     plot([x(1) x(end)],[0 0],'--r'); hold on;
%     plot(pointx,ones(1:length(pointx),1),'r*'); hold on;
%     plot(pointx,zeros(1:length(pointx),1),'g*'); hold on;    


end
