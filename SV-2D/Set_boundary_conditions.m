% SET_BOUNDARY_CONDITIONS       Imposes the approach to be followed in
%   setting the boundary conditions. According to the user-chosen 
%   BOUNDARY_CASE, the function assigns the VALUES_TO_BE_IMPOSED to the
%   BOUNDARY_VALUES. This function is called in the COMPUTE_FLUXES
%   function.
%   The following Boundary Conditions are available:
%   - Dirichlet (to be set manually)
%   - Wall
%   - Outflow or No Boundary Conditions
%
%   See also COMPUTE_FLUXES.


function Boundary_values = Set_boundary_conditions(Boundary_case,values_to_be_imposed)

    switch Boundary_case

        case 'Dirichlet'

            Boundary_values(1) = 1;
            Boundary_values(2) = 0;
            Boundary_values(3) = 0;
            Boundary_values(4) = 1;            
            
        case 'Wall'
            
            Boundary_values(1) = values_to_be_imposed(1);
            Boundary_values(2) = -values_to_be_imposed(2);
            Boundary_values(3) = values_to_be_imposed(3);
            Boundary_values(4) = values_to_be_imposed(4); 
            
        case 'Outflow'
            
            Boundary_values = values_to_be_imposed;          
            
    end
    
end
