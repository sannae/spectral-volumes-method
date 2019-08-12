% COMPUTEFLUXES is the function that computes all the fluxes in the domain.
% It receives the left reconstructed value RECVAL_LEFT and the right
% reconstructed value RECVAL_RIGHT, the physical parameter GAMMA in order
% to compute the real flux and the FLAG_RIEMANN to call the Riemann Flux on
% the right nodes.

function f=ComputeFluxes(RecVal_left,RecVal_right,gamma,Flag_Riemann)

        f_left = RealFlux(RecVal_left,gamma);
        f_right = RealFlux(RecVal_right,gamma);
        
        f_left = f_left';
        f_right = f_right';

        if Flag_Riemann==1
                f = RiemannFlux(f_left,f_right,RecVal_left,RecVal_right);
        else
                f = f_left;
        end


end
