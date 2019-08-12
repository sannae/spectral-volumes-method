% CHOOSE_BOUNDARY allows to choose with what kind of Boundary Conditions you want to run the SV1D
% code. The selected test is then passed to the main. Each case test
% contains  the extrema of the domain (X0,X1) and the Boundary Condition 
% that you want to impose on left % (BC_left) and right (BC_right). The
% flags corresponding to the boundary conditions are implemented in the
% function SET_BOUNDARY_CONDITIONS.

function [x0,x1,BC_left,BC_right] = Choose_Boundary(boundary_case)

    switch boundary_case
        
        case 'Wall'
            
            x0 = -1;
            x1 = 1;
            BC_left = 1;
            BC_right = -1;

        case 'Outflow'
            
            x0 = -1;
            x1 = 1;
            BC_left = 1;
            BC_right = 1;
            
        case 'Periodic'
            
            x0 = -1;
            x1 = 1;
            BC_left = 1;
            BC_right = 1;
            
        case 'Dirichlet'
            
            x0 = -1;
            x1 = 1;
            BC_left = 'whatever';
            BC_right = 'whatever';
            
        otherwise
            
            disp('Error: this boundary condition is not available');

    end
    
end
