% RIEMANNFLAG builds an array of size CV_NUMBER, where each element is
% 0 if corresponding to an internal Control Volume node, 1 if corresponding
% a Spectral Volume node. In this way, all the boundary nodes between
% Spectral Volumes are marked.

function RiemFlag = RiemannFlag(CV_number,SV_number,CV_x,SV_x)

    RiemFlag = zeros(1,CV_number+1);

    for i=1:CV_number+1
        for j=1:SV_number+1
            if CV_x(i)==SV_x(j)
                RiemFlag(i)=1;
            end
        end
    end

end
