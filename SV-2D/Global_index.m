% GLOBAL_INDEX  Given the indices i,j of a cell in the subgrid, the number 
%   of Spectral Volumes on the x direction and the amount of CVs on the side 
%   of a SV, the function gives back the global index I of the cell.
%   Example: Global_index(2,4,3,2) = 10


function I = Global_index(i,j,n_x,CV_per_SV_side_x)

    I = (i-1)*(n_x*CV_per_SV_side_x) + j;

end
