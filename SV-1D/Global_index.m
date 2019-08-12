% GLOBAL_INDEX(SV_NUMBER,CV_PER_SV) receives as input the amount of
% Spectral Volumes SV_NUMBER in the domain and it assigns an index to each one of
% the CV_PER_SV control volumes inside each spectral volume.


function y = global_index (SV_number,CV_per_SV)

    for j=1:SV_number
        for i=1:CV_per_SV
            y(j,i) = (j-1)*(CV_per_SV)+i;
        end
    end

end
