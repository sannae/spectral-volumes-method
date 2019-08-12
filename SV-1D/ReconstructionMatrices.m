% RECONSTRUCTIONMATRICES(SV_NUMBER,K<CV_PER_SV,Q,CV_X,I_GLOBAL,SVCENTROID)
% provides a 3-by-3-by-3 array, so an array of matrices. 
% The first index of the array goes along all the CV_NUMBER, the second
% index goes till order K, and the third index goes along all the
% SV_NUMBER. A generic element of the matrix stores the result of the 
% function Monomial.

function RecM = ReconstructionMatrices(SV_number,k,CV_per_SV,Quadrature_Order,CV_x,I_global,SVcentroid)

    for s=1:SV_number
        for h=0:k
            for i=1:CV_per_SV
                RecM(i,h+1,s) = monomial(Quadrature_Order,CV_x(I_global(s,i)),CV_x(I_global(s,i)+1),h,SVcentroid(s));
            end
        end
    end
    
end
