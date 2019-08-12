% SET_TEST allows to choose with what kind of test you want to run the SV1D
% code. The selected test is then passed to the main. Each case test
% contains the physical parameters (like GAMMA), the extrema of the domain
% (X0,X1) and the Boundary Condition that you want to impose on left
% (BC_left) and right (BC_right).

function [gamma,x0,x1,BC_left,BC_right] = Set_Test(boundary_case)

    switch boundary_case
        
        case 'Wall'
            
            gamma = 1.4;
            x0 = -1;
            x1 = 1;
            BC_left = -1;
            BC_right = -1;

        case 'Outflow'
            
            gamma = 1.4;
            x0 = -1;
            x1 = 1;
            BC_left = 1;
            BC_right = 1;
            
        otherwise
            
            disp('Error: this case is not available');

    end
    
end
