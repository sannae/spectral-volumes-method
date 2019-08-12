% WHICH_NUMBER_OF_CV_IN_A_SV    This function, provided the indices of a 
%   cell i,j, gives back the indices of the same cell in a logical spectral 
%   volume, i.e. the indices of the cell in a frame of reference inside the 
%   spectral volume and not inside the total subgrid. For example, the cell 
%   (2,4) in the subgrid is actually the cell (2,2) in its own spectral volume.

function [I,J] = Which_number_of_CV_in_a_SV(i,j,CV_per_SV_side_y,CV_per_SV_side_x)

    % Index I
    
    if rem(i,CV_per_SV_side_y)~=0 
        I = rem(i,CV_per_SV_side_y);
    else
        I = rem(i,CV_per_SV_side_y) + CV_per_SV_side_y;
    end
    
    % Index J
    
    if rem(j,CV_per_SV_side_x)~=0 
        J = rem(j,CV_per_SV_side_x);
    else
        J = rem(j,CV_per_SV_side_x) + CV_per_SV_side_x;
    end
    
end

    
