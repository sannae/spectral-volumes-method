function [parameter,var_number] = Set_Problem(problem_case)

    switch problem_case

        case 'Euler'

            var_number = 3;
            gamma = 1.4;
            parameter = gamma;

        otherwise 

            disp('Equation not available')

    end

end
