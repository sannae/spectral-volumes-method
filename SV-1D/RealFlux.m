% REALFLUX computes the FLUX of all the variables in the problem knowing 
% the reconstructed values u and the physical parameter gamma (in the Euler
% problem)

function flux = RealFlux(u,parameter)

            gamma = parameter;
            U = u(2)/u(1);
            p = pressure(u,gamma);

            flux(1) = u(2);
            flux(2) = u(2)*U+p;
            flux(3) = U*(u(3)+p);
    
end
