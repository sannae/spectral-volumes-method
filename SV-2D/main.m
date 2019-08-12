% MAIN FILE

clear all; close all; clc;

% Basic Grid & Method information
mu = 1.5;
k = 2;
Quadrature_order = floor((k+2)/2);
n_x = 5;
n_y = 5;
interval_on_x = [-1 1];
interval_on_y = [-1 1];
SV_discretization = 'Equispaced';
CV_discretization = 'Hyperbolic_tangent';
Chosen_basis = 'Centered standard';
Do_you_want_limiters = 'Y';

% Basic problem parameters
var_number = 4;
gamma = 1.4;
Boundary_case = 'Wall';
Initial_conditions_case = 'Exponential';

% Time scheme parameters
time_steps = 50;
CFLnumber = 0.5;

% Plot options
variable_to_be_plotted = 1;
plotting_mode = 'Averages';

% Super Grid
[amount_of_volumes,domain_x,domain_y,index_I,index_J,corners,edge_horizontal,edge_vertical,x_corner_SW,y_corner_SW,x_corner_SE,y_corner_SE,x_corner_NE,y_corner_NE,x_corner_NW,y_corner_NW,x_centers,y_centers] = SuperGrid(n_x,n_y,SV_discretization,k,mu,interval_on_x,interval_on_y);

        % Check SuperGrid     
%        Plot_the_grid('main grid',n_x,n_y,1,1,x_corner_SW, y_corner_SW, x_corner_SE, y_corner_SE, x_corner_NE, y_corner_NE, x_corner_NW, y_corner_NW)

% Sub Grid     
[CV_per_SV_side_x,CV_per_SV_side_y,index_i_CV,index_j_CV,domain_x_CV_tot,domain_y_CV_tot,corners_CV,edge_horizontal_CV,edge_vertical_CV,x_corner_SW_CV,y_corner_SW_CV,x_corner_SE_CV,y_corner_SE_CV,x_corner_NE_CV,y_corner_NE_CV,x_corner_NW_CV,y_corner_NW_CV,area,x_centers_CV,y_centers_CV] = SubGrid(n_x,n_y,CV_discretization,k,mu,x_corner_SW,y_corner_SW,x_corner_SE,y_corner_NW);
        % Check sub grid     
%        Plot_the_grid('subgrid',n_x,n_y,CV_per_SV_side_x,CV_per_SV_side_y,x_corner_SW_CV, y_corner_SW_CV, x_corner_SE_CV, y_corner_SE_CV, x_corner_NE_CV, y_corner_NE_CV, x_corner_NW_CV, y_corner_NW_CV)

% Average of the initial condition
u = Average_initial(var_number,n_x,n_y,CV_per_SV_side_x,CV_per_SV_side_y,Quadrature_order,x_corner_SW_CV,y_corner_SW_CV,x_corner_SE_CV,y_corner_SE_CV,x_corner_NE_CV,y_corner_NE_CV,x_corner_NW_CV,y_corner_NW_CV,area,Initial_conditions_case);

% Reconstruction process
Reconstruction_matrices = Reconstruction_matrix(n_y,n_x,CV_per_SV_side_y,CV_per_SV_side_x, x_centers_CV, y_centers_CV,Quadrature_order,x_corner_SW_CV,y_corner_SW_CV,x_corner_SE_CV,y_corner_NW_CV,k,area,x_centers,y_centers,Chosen_basis);

for t=1:time_steps
    
    t
  
    % Plot (this function is here and not below the time scheme, 
    % so that also initial conditions can be plotted)   
    Plot_averages(n_x,n_y,CV_per_SV_side_x,CV_per_SV_side_y,x_corner_SW_CV,y_corner_SW_CV,x_corner_SE_CV,y_corner_SE_CV,x_corner_NE_CV,y_corner_NE_CV,x_corner_NW_CV,y_corner_NW_CV,u,variable_to_be_plotted,plotting_mode,interval_on_x,interval_on_y)

    % Solving the linear reconstruction system
    Reconstruction_coefficients = Reconstruction_coefficients_solving(var_number, n_y,n_x, CV_per_SV_side_x,CV_per_SV_side_y,Reconstruction_matrices,u);

    % Reconstruction polynomial evaluated in the internal quadrature points
    % (actually this is a check of the reconstruction process, because
    % it's not really helpful in the method)
	Reconstruction_polynomial = Reconstruction_polynomial_internal_values(var_number,n_x,n_y,CV_per_SV_side_x,CV_per_SV_side_y,Quadrature_order,x_corner_SW_CV,x_corner_SE_CV,y_corner_SW_CV,y_corner_NW_CV,Reconstruction_coefficients,k,interval_on_x,interval_on_y,variable_to_be_plotted,plotting_mode,Chosen_basis,x_centers,y_centers,u);

    % Compare with the real initial condition: uncomment the following
    % lines to have a plot of the chosen initial conditions  
        x = linspace(-1,1,n_x*CV_per_SV_side_x*Quadrature_order);
        y=linspace(-1,1,n_y*CV_per_SV_side_y*Quadrature_order);
        for v=1:var_number
            for i=1:length(x)
                for j=1:length(y)
                    real_initial(i,j) = InitialConditions(v,x(i),y(j),Initial_conditions_case);
                end
            end
    %        figure;
    %        surf(x,y,real_initial')
    %        variable_string = num2str(v); xlabel('x'); ylabel('y'); zlabel('u'); title(strcat('Real Initial Condition of variable ',variable_string));
        end
        
	% Reconstruction polynomial evaluated in every quadrature point of the
	% edges in the subgrid
   	Reconstruction_polynomial_edges = Reconstruction_polynomial_on_the_edges(k,var_number,n_x,n_y,CV_per_SV_side_y,CV_per_SV_side_x,Quadrature_order,x_corner_SW_CV,y_corner_SW_CV,x_corner_SE_CV,y_corner_SE_CV,x_corner_NE_CV,y_corner_NE_CV,x_corner_NW_CV,y_corner_NW_CV,@Standard_basis_array,Reconstruction_coefficients,x_centers,y_centers,Chosen_basis,u);

    % Minmod limiter 
    if strcmp(Do_you_want_limiters,'Y')==1
    Reconstruction_polynomial_edges = Minmod_limiter(n_x,n_y,CV_per_SV_side_x,CV_per_SV_side_y,Reconstruction_polynomial_edges,Quadrature_order,u,var_number);
    end

    % Compute fluxes
    flag_riemann = Riemann_flag(n_x,n_y,CV_per_SV_side_x,CV_per_SV_side_y);
    [flux_horizontal flux_vertical] = Compute_fluxes(n_x,n_y,CV_per_SV_side_x,CV_per_SV_side_y,Boundary_case,Quadrature_order,flag_riemann, Reconstruction_polynomial_edges,gamma);
    [flux_integrated_over_edge_horizontal flux_integrated_over_edge_vertical] = Flux_integration(n_x,n_y,CV_per_SV_side_x,CV_per_SV_side_y,Quadrature_order,var_number,flux_horizontal,flux_vertical,x_corner_SW_CV,x_corner_SE_CV,y_corner_SW_CV,y_corner_NW_CV);


    % CFL conditions
    dt = CFL_conditions(n_x,n_y,CV_per_SV_side_x,CV_per_SV_side_y,u,gamma,CFLnumber,x_corner_SW_CV,x_corner_SE_CV,y_corner_SW_CV,y_corner_NW_CV);

    % Update
    u = Explicit_euler(u,n_x,n_y,CV_per_SV_side_x,CV_per_SV_side_y,flux_integrated_over_edge_horizontal,flux_integrated_over_edge_vertical,dt,area);
    
    % Get frame for the movie
    M(t)=getframe(gcf);

end

% Save the movie
movie(M);
movie2avi(M,'Movie');
