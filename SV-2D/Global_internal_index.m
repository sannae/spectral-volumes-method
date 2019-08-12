% GLOBAL_INTERNAL_INDEX     Function to have the global internal index of 
%   a CV inside a SV. The input must be the LOCAL indices, not the indices 
%   un the total subgrid. For example, the CV numbered (3,4) in the total 
%   grid is actually the CV numbered (3,1) in its own SV. This function then 
%   provides the index 7 (the first CV is the one on the left bottom, then 
%   proceeding row-wise).

function Global_index = Global_internal_index(i,j,CV_per_SV_side_x,CV_per_SV_side_y)

    if i > CV_per_SV_side_y || j > CV_per_SV_side_x

        disp('Error: the indices must be in the interval 1<i<CV_per_SV_side_y and 1<j<CV_per_SV_side_y')

    else

        Global_index = (i-1)*CV_per_SV_side_x + j;

    end
    
end
