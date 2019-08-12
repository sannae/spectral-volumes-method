% EQUISPACED_NODES  Gives back a 1-D array of equispaced coordinates between
%   the extremes A and B, made of N elements.

function x = Equispaced_nodes(a,b,N)

    x = linspace(a,b,N+1);

end
