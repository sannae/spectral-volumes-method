% RECONSTRUCTIONVALUES

function RecValues = ReconstructionValues(i,ReconstructionCoeffs,k,x,SVcentroid,var_number)

for v=1:var_number
    RecValues(v)=ReconstructionCoeffs(1,v);
    for h=1:k
        RecValues(v)=RecValues(v)+ReconstructionCoeffs(h+1,v)*(x-SVcentroid)^(h);
    end
end
    
end
