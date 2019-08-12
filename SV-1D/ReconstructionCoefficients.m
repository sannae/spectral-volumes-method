% RECONSTRUCTIONCOEFFICIENTS(VAR_NUMBER,SV_NUMBER,I_GLOBAL,CV_PER_SV,RECONS
% TRUCTIONMATRIX,U)

function RecCoeffs = ReconstructionCoefficients(var_number,SV_number,I_global,CV_per_SV,ReconstructionMatrix,u)

    for v=1:var_number
        for s=1:SV_number

            % Solving the linear system
            temp_matrix=ReconstructionMatrix(:,:,s);
                %RecCoeffs(:,v,I_global(s,1))=linsolve(temp_matrix,(u(v,I_global(s,1:CV_per_SV)))');
                RecCoeffs(:,v,I_global(s,1))=(temp_matrix)\(u(v,I_global(s,1:CV_per_SV)))';

            % Storing all the solutions inside the same matrix
            for i=2:CV_per_SV
                RecCoeffs(:,v,I_global(s,i))=RecCoeffs(:,v,I_global(s,1));
            end

        end
    end

end
