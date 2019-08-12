% LIMITERS applies the minmod limiter to the reconstructed values from left
% and right (RECVALUES_RIGHT, RECVALUES_LEFT) and the average variable U.
% The two other inputs are just inserted in order to simplify the
% calculation. It gives back as output the new limited reconstructed
% values.


function [RecValues_right,RecValues_left] = limiters(RecValues_right,RecValues_left,u,CV_number,var_number)

    for i=1:CV_number
        for v=1:var_number
            
            Delta_plus = RecValues_left(v,i+1) - u(v,i);
            Delta_minus = u(v,i) - RecValues_right(v,i);

            if i~=CV_number
                Delta1 = u(v,i+1)-u(v,i);
            else
                Delta1 = 0;
            end

            if i~=1
                Delta2 = u(v,i)-u(v,i-1);
            else
                Delta2 = 0;
            end

            Delta_tilde_plus = minmod(Delta_plus,Delta1,Delta2);
            Delta_tilde_minus = minmod(Delta_minus,Delta1,Delta2);

            RecValues_left(v,i+1) = u(v,i) + Delta_tilde_plus;
            RecValues_right(v,i) = u(v,i) - Delta_tilde_minus;
        
        end
        
    end

end




function m = minmod(x,y,z)
     if sign(x)==sign(y) && sign(y)==sign(z)
         m = sign(x)*min([abs(x) abs(y) abs(z)]);
     else
         m = 0;
     end
end
