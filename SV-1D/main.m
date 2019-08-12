% Main file

clear all; close all; clc

% General parameters
    % Problem Cases available: Euler
    % Boundary Cases available: Wall, Outflow, Periodic, Dirichlet
    % Initial Cases available: exponential, constant, cosinusoidal, Laura Scarabosio Euler shock, Laura Scarabosio ICF, Zehua 

k = 3;

mu = 2;

problem_case = 'Euler';
boundary_case = 'Wall';
initial_case = 'Exponential';

% Grid parameters
    % SV discretization available: equispaced, hyperbolic_tangent
    % CV discretization available: equispaced, hyperbolic_tangent    

SV_number = 10;

Quadrature_Order = 5;

SV_discretization = 'Equispaced';
CV_discretization = 'Hyperbolic_tangent';

% Time method parameters

CFLnumber = 0.5;

timesteps = 1000;

% Some other initializations

do_you_want_limiters = 'Y';

% Set the chosen problem

[gamma,var_number] = Choose_Problem(problem_case);

% Set the chosen boundary

[x0,x1,BC_left,BC_right] = Choose_Boundary(boundary_case);

% Grid

[CV_per_SV,CV_number,I,I_global,CV_index,SV_x,CV_x,centroid,SVcentroid,whichSV] = grid(SV_number,k,mu,x0,x1,SV_discretization,CV_discretization);


% Initializing the average variables

for i=1:CV_number
    u(:,i) = average(Quadrature_Order,CV_x(i),CV_x(i+1),@InitialConditions,var_number,initial_case);
end

% Building the Reconstruction Matrix

ReconstructionMatrix = ReconstructionMatrices(SV_number,k,CV_per_SV,Quadrature_Order,CV_x,I_global,SVcentroid);

% Time loop

for t=1:timesteps
    
    t
    
    % Reconstruction coefficients

    ReconstructionCoeffs = ReconstructionCoefficients(var_number,SV_number,I_global,CV_per_SV,ReconstructionMatrix,u);

    
    % Reconstruction values

    for i=1:CV_number+1
        if i==CV_number+1
           RecValues_right(:,i) = 0; 
        else
           RecValues_right(:,i) = ReconstructionValues(i,ReconstructionCoeffs(:,:,i),k,CV_x(i),SVcentroid(whichSV(i)),var_number);
        end
    end

    for i=2:CV_number+1
        RecValues_left(:,i) = ReconstructionValues(i-1,ReconstructionCoeffs(:,:,i-1),k,CV_x(i),SVcentroid(whichSV(i-1)),var_number);
    end
   
    
    % Limiters
    
    [RecValues_right,RecValues_left] = limiters(RecValues_right,RecValues_left,u,CV_number,var_number);
    
    
    % Imposing the Boundary Conditions

    if strcmp(boundary_case,'Periodic')==1
        RecValues_right(:,CV_number+1) = Set_Boundary_Conditions(RecValues_right(:,1),boundary_case,@InitialConditions,initial_case);
        RecValues_left(:,1) = Set_Boundary_Conditions(RecValues_left(:,CV_number+1),boundary_case,@InitialConditions,initial_case);
    else
        RecValues_right(:,CV_number+1) = Set_Boundary_Conditions(RecValues_left(:,CV_number+1),boundary_case,@InitialConditions,initial_case);  
        RecValues_left(:,1) = Set_Boundary_Conditions(RecValues_right(:,1),boundary_case,@InitialConditions,initial_case); 
    end
   
    
    % Plot the reconstructed values
    
    plot_main(x0,x1,CV_x,RecValues_right,problem_case,boundary_case,initial_case)
 
       
    % Storing the fluxes

    Flag_Riemann = RiemannFlag(CV_number,SV_number,CV_x,SV_x);
    
    for i=1:CV_number+1    
        limiter_flag = limiters_or_not(do_you_want_limiters,Flag_Riemann(i));
        f(:,i)=ComputeFluxes(RecValues_left(:,i),RecValues_right(:,i),gamma,limiter_flag);
    end

    
    % CFL conditions

    dt = CFLconditions(CV_number,CV_x,u,gamma,CFLnumber);

    
    % Updating

    u = ExplicitEuler(CV_number,CV_x,dt,u,f);
    
    
    % Plot averages
    
    %plot_averages(CV_number,CV_x,u,1,x0,x1)

    
    % Movie
    
    M(t)=getframe(gcf);
  
    
end


break

% Save the movie

movie(M);
movie2avi(M,'Movie');

