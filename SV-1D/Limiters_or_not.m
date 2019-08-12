% LIMITERSORNOT is simply a function that, depending on the answer to the
% do_you_want_limiters in the main, calls the Riemann Flux just on the SV
% boundary node (if 'N') or on every CV boundary node (if 'Y').

function lim = limiters_or_not(answer,Flag_riemann)

    switch answer

        case 'Y'

            lim = 1;

        case 'N'

            lim = Flag_riemann;

        otherwise

            disp('Case not available: choose Y or N in the function limiters_or_not')

    end

end
