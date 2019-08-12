% MINMOD_LIMITER    Performs the Minmod limiter on the reconstructed
%   values. The input are the matrix of RECONSTRUCTED_VALUES, the average U
%   and some other mesh parameters. The output is the updated
%   RECONSTRUCTED_VALUES.
%
%   NOTE: Consider that, since this limiter is being performed in a 1D-wise
%   manner, it's not actually following the minmod limiters presented by
%   Z.J. Wang in his paper. The Barth-Jespersen limiter is more suitable
%   for 2D systems.


function Reconstructed_values = Minmod_limiter(n_x,n_y,CV_per_SV_side_x,CV_per_SV_side_y,Reconstructed_values,Quadrature_order,u,var_number)

for i=1:n_y*CV_per_SV_side_y
    for j=1:n_x*CV_per_SV_side_x
        
        for q=1:Quadrature_order
            
            for v=1:var_number
                
                
                
                
            % North-South direction
                
                % Reconstruction values on edge North and South
                u_plus = Reconstructed_values(q,3,i,j,v);
                u_minus = Reconstructed_values(q,1,i,j,v);
                
                % Cell average of CV i,j
                cell_average = u(i,j,v);
                
                % Differences between reconstruction and averages
                Delta_u_plus = u_minus - cell_average;
                Delta_u_minus = cell_average - u_plus;
                
                % Differences between averages
                if i==1 || i==n_y*CV_per_SV_side_y
                    
                    Delta_1 = 0;
                    Delta_2 = 0;
                    
                else
                    
                    cell_average_next = u(i+1,j,v);
                    cell_average_previous = u(i-1,j,v);
                    
                    Delta_1 = cell_average_next - cell_average;
                    Delta_2 = cell_average - cell_average_previous;
                    
                end
                
                % Updated differences using minmod function
                Delta_tilde_u_plus = minmod(Delta_u_plus, Delta_1,Delta_2);
                Delta_tilde_u_minus = minmod(Delta_u_minus, Delta_1,Delta_2);
                
                % Updated reconstructed values
                Reconstructed_values(q,3,i,j,v) = cell_average - Delta_tilde_u_minus;
                Reconstructed_values(q,1,i,j,v) = Delta_tilde_u_plus + cell_average;
            
                
                
                
            % East-West direction (same approach as above)
                
                u_plus = Reconstructed_values(q,2,i,j,v);
                u_minus = Reconstructed_values(q,4,i,j,v);
                cell_average = u(i,j,v);
                Delta_u_plus = u_minus - cell_average;
                Delta_u_minus = cell_average - u_plus;
                
                if j==1 || j==n_x*CV_per_SV_side_x
                    
                    Delta_1 = 0;
                    Delta_2 = 0;
                    
                else
                    
                    cell_average_next = u(i,j+1,v);
                    cell_average_previous = u(i,j-1,v);
                    
                    Delta_1 = cell_average_next - cell_average;
                    Delta_2 = cell_average - cell_average_previous;
                    
                end
                
                Delta_tilde_u_plus = minmod(Delta_u_plus, Delta_1,Delta_2);
                Delta_tilde_u_minus = minmod(Delta_u_minus, Delta_1,Delta_2);
                
                Reconstructed_values(q,2,i,j,v) = cell_average - Delta_tilde_u_minus;
                Reconstructed_values(q,4,i,j,v) = Delta_tilde_u_plus + cell_average;
                
            end
            
        end
        
    end
end

end





% MINMOD    Or Minimum Modulus function, gives the minimum modulus among
%   the three input, as long as they all have the same sign; otherwise is 0

function m = minmod(x,y,z)
     if sign(x)==sign(y) && sign(y)==sign(z)
         m = sign(x)*min([abs(x) abs(y) abs(z)]);
     else
         m = 0;
     end
end    
