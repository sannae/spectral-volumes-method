% SHAPE     This function is not used in the main. But it may be useful to 
%   plot the Shape functions used in the conversion logical-to-physical 
%   coordinates

function shape

    x = linspace(-1,1,20);
    y = linspace(-1,1,20);
    [X Y] = meshgrid(x,y);

    for i=1:length(x)
        for j=1:length(y)
            shape1(i,j) = (1-x(i))*(1-y(j)); 
            shape2(i,j) = (1+x(i))*(1-y(j));
            shape3(i,j) = (1-x(i))*(1+y(j));
            shape4(i,j) = (1+x(i))*(1+y(j));
        end
    end

    surf(X,Y,shape1); hold on;

end
