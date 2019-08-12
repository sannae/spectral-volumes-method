% SETBOUNDARYCONDITIONS receives as input the INSIDE_VALUE on the boundary 
% (specifically, the left or the right one) and the BC_TYPE you want to set
% it with. It gives the OUTSIDE_VALUE as output.


function outside_value = Set_Boundary_Conditions(inside_value, BC_Type, InitialConditions, initial_state)

    switch BC_Type
        
        case 'Outflow'  
        
            outside_value = inside_value;
        
        case 'Wall'   
            
            outside_value(1) = inside_value(1);
            outside_value(2) = -inside_value(2);
            outside_value(3) = inside_value(3);
            
        case 'Periodic'
            
             outside_value = inside_value; 
             
        case 'Dirichlet'
            
            outside_value = InitialConditions(1,initial_state);
           
        otherwise
            
            disp('Case not available')

    end
    
end
