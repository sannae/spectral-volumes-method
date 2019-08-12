% CHOOSE_PROBLEM allows you to set the equation to solve, in order to have
% the physical parameters PARAMETER necessary and the number of variables VAR_NUMBER.

function [parameter,var_number] = Choose_Problem(problem_case)

    switch problem_case

        case 'Euler'

            var_number = 3;
            gamma = 1.4;
            parameter = gamma;
    
        otherwise 

            disp('Error: this equation is not available')

    end

end
