% Reconstruction Matrices

function RecM = ReconstructionMatrix(SV_number,k,CV_per_SV,Q,CV_x,I_global,SVcentroid)

    for s=1:SV_number
        for h=0:k
            for i=1:CV_per_SV
                RecM(i,h+1,s) = monomial(Q,CV_x(I_global(s,i)),CV_x(I_global(s,i)+1),h,SVcentroid(s));
            end
        end
    end
    
end
