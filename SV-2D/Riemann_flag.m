% RIEMANN_FLAG      Builds the matrix of the Riemann Flag. For each edge
%   and I,J index of a cell, the output FLAG_RIEMANN hosts 1 if the
%   aforesaid edge is a SV boundary, 0 if it's not. 
%   Since this code requires limiters, every CV boundary will be treated as
%   a SV boundary, therefore the FLAG_RIEMANN is only made of ones.
%   
%   See also COMPUTE_FLUXES.



function flag_riemann = Riemann_flag(n_x,n_y,CV_per_SV_side_x,CV_per_SV_side_y)



        flag_riemann = ones(4,n_y*CV_per_SV_side_y,n_x*CV_per_SV_side_x);

    

end
