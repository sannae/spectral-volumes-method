% INITIALCONDITIONS is a function of the abscissa X and the conditions
% chosen in the main. According to the INITIAL_CASE set in the main, it
% assigns the initial conditions to all the variables.


function u0 = InitialConditions(x,initial_case)

    switch initial_case
        
        case 'Exponential'

            u0(1) = 1+exp(-5*(x^2));
            u0(2) = 0;
            u0(3) = u0(1);

        case 'Constant'
            
            u0(1) = 1;
            u0(2) = 0;
            u0(3) = u0(1); 
            
        case 'Cosinusoidal'
            
            u0(1) = cos(x);
            u0(2) = 0;
            u0(3) = u0(1);
            
        case 'Laura Scarabosio Euler shock'
            if x < 0.5
                u0(1) = 1;
            else
                u0(1) = 1.5;
            end
            u0(2) = 1;
            u0(3) = 1;

      
        case 'Laura Scarabosio ICF'
            
            hotspot=0.1;
            fuel=0.4;
            ablator=0.5;
            hotspot_density = 0.2;
            internal_energy = 1.5;
            external_energy = 2.5;
            u0(2)=0;
            if x<=hotspot
                u0(1)=hotspot_density;
                u0(3)=internal_energy;
            else if x>hotspot && x<=fuel
                u0(1)=10*hotspot_density;
                u0(3)=internal_energy;
                else if x>fuel && x<ablator
                    u0(1)=12*hotspot_density;
                    u0(3)=internal_energy;                        
                    else
                        u0(1)=4*hotspot_density;
                        u0(3)=external_energy;      
                    end
                end
            end
            
        case 'Zehua'
            
            u0(1) = 1-0.9*exp(-10*(x^2));
            u0(2) =-sin(pi*x);
            u0(3) = 0.5*(u0(2))^2/u0(1);
            
        case 'Transport'
            
            u0(1) = sin(pi*x)+2;
            u0(2) = 1;
            u0(3) = 0;
            

        otherwise
            
            disp('Error: this initial condition is not available');
            
    end
    
end
