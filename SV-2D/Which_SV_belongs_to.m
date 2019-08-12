% WHICH_SV_BELONGS_TO   Provided the indices i,j of a control volume, this 
%   function gives back the I,J indices of the spectral volume the input CV 
%   is in.

function [I J] = Which_SV_belongs_to(i,j,CV_per_SV_side_x,CV_per_SV_side_y)

    % Index I

    if rem(i,CV_per_SV_side_y)~=0
        I = floor(i/CV_per_SV_side_y) + 1;
    else
        I = i/CV_per_SV_side_y;
    end

    % Index J

    if rem(j,CV_per_SV_side_x)~=0
        J = floor(j/CV_per_SV_side_x) + 1;
    else
        J = j/CV_per_SV_side_x;
    end

end
