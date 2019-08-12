% INITIALCONDITIONS     Contains the initial condition functions, depending
%   on both coordinates X,Y of the variable V, corresponding to the
%   user-input INITIAL_CASE. 
%   The available cases are the following: 
%   - Basic
%   - Constant
%   - Exponential
%   - Double exponential
%   - G. Zehua
%   - L. Scarabosio
%   - ICF 1D test
%   All the cases are described below.



function u0 = InitialConditions(v,x,y,initial_case)

switch initial_case
    
    
    % Basic constant test case. Every variable is set equal to 0 except for
    % the density, that is supposed to stay frozen at its initial value.
    case 'Basic'
        
        switch v
            case 1
                u0 = 1;
            case 2
                u0 = 0;
            case 3
                u0 = 0;
            case 4
                u0 = 0;
        end
    
    % Constant test case. Density and Energy set to 1. 
    case 'Constant'
        
        switch v
            case 1
                u0 = 1;
            case 2
                u0 = 0;
            case 3
                u0 = 0;
            case 4
                u0 = 1;
        end
        
    % 2D Gaussian density and energy. The peak of density and energy
    % relaxes, while an inward flow develops.
    case 'Exponential'
        
        switch v
            case 1
                u0 = 1+exp(-5*(x.^2+y.^2));
            case 2
                u0 = 0;
            case 3
                u0 = 0;
            case 4
                u0 = 1+exp(-5*(x.^2+y.^2));
        end
        
        
    % 2D Gaussian density and negative gaussian energy. The system is
    % expected to create a peak in the center and then relax
    case 'Double exponential'
        
        switch v
            case 1
                u0 = 1+exp(-5*(x.^2+y.^2));
            case 2
                u0 = 0;
            case 3
                u0 = 0;
            case 4
                u0 = 1-0.9*exp(-10*(x.^2+y.^2));
        end
        
        
    % Inflow case. The x momentum and y momentum are supposed to create
    % an inward motion.
    case 'G. Zehua'
        
        switch v
            case 1
                u0 = 1+0.9*exp(-10*(x.^2+y.^2));
            case 2
                u0 = -0.1*x;
            case 3
                u0 = -0.1*y;
            case 4
                u0 = 1;
        end
        
    % A shock-capturing test, imposing a jump in the pressure between
    % P0 and P1, with constant density and null momentum. Performed by
    % L. Scarabosio in a 1D Spectral Volume code.
    case 'L. Scarabosio'
        p0 = 1;
        p1 = 1.5;
        switch v
            case 1
                u0 = 1;
            case 2
                u0 = 0;
            case 3
                u0 = 0;
            case 4
                if x^2+y^2 < 0.6
                    u0 = p0/(1.4-1);
                else
                    u0 = p1/(1.4-1);
                end
        end
        
        
    % Study performed by L. Scarabosio in a 1D Spectral Volume code,
    % analyzing the relation between the initial pressure jump and the
    % height of the peak when the shock hits the wall.
    case 'ICF 1D test'
        
        radius = x^2+y^2;
        internal_density = 0.2;
        internal_energy = 1.5;
        
        if radius < 0.1 % Hot spot region
            switch v
                case 1
                    u0 = internal_density;
                case 2
                    u0 = 0;
                case 3
                    u0 = 0;
                case 4
                    u0 = internal_energy;
            end
        end
        
        if radius >= 0.1 && radius < 0.4 % Fuel region
            switch v
                case 1
                    u0 = 10*internal_density;
                case 2
                    u0 = 0;
                case 3
                    u0 = 0;
                case 4
                    u0 = internal_energy;
            end
        end
        
        if radius >= 0.4 && radius < 0.5 % Ablator region
            switch v
                case 1
                    u0 = 12*internal_density;
                case 2
                    u0 = 0;
                case 3
                    u0 = 0;
                case 4
                    u0 = internal_energy;
            end
        end
        
        if radius >= 0.5 % Exterior region
            switch v
                case 1
                    u0 = 4*internal_density;
                case 2
                    u0 = 0;
                case 3
                    u0 = 0;
                case 4
                    u0 = internal_energy + 1;
            end
        end

        
        
end
        
            
        
end
