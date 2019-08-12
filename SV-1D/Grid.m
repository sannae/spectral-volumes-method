% GRID contains all the information about the grid itself.


function [CV_per_SV,CV_number,I,I_global,CV_index,SV_x,CV_x,centroid,SVcentroid,whichSV]=grid(SV_number,k,mu,x0,x1,SV_grid_discretization,CV_grid_discretization)


    CV_per_SV = k+1;
    CV_number = CV_per_SV*SV_number;

    
    % Index of the Control Volume
    I = 1: (CV_number+1);

    
    % Global index of the Control Volume
    I_global = global_index(SV_number,CV_per_SV);


    % Index of the j-th Control Volume in the i-th Spectral Volume
    CV_index = [];
    for i=1:SV_number
        CV_index = [CV_index ; 1:CV_per_SV];
    end

    
    % Abscissas of the Spectral Volumes
    if strcmp(SV_grid_discretization,'Equispaced')==1
        SV_x = equispaced_nodes(x0,x1,SV_number);
        else if strcmp(SV_grid_discretization,'Hyperbolic_tangent')==1
             SV_x = hyperbolic_tangent(SV_number,mu,x0,x1);  
            end
    end

    
    % Abscissas of the Control Volumes
    CV_x=[];
    for i=1:SV_number
        if strcmp(CV_grid_discretization,'Hyperbolic_tangent')==1
            CVx = hyperbolic_tangent(CV_per_SV,mu,SV_x(i),SV_x(i+1));
            CVx = [SV_x(i) CVx SV_x(i+1)];
        else if strcmp(CV_grid_discretization,'Equispaced')==1
                CVx = equispaced_nodes(SV_x(i),SV_x(i+1),CV_per_SV);
            end
        end
        CV_x_temp = [CV_x CVx];
        CV_x = unique(CV_x_temp);
    end

    % Centroid of the Control Volume
    for i=1:CV_number
        centroid(i) = (CV_x(i)+CV_x(i+1))/2;
    end
    
    % Centroid of the Spectral Volume
    for i=1:SV_number
        SVcentroid(i)=(SV_x(i)+SV_x(i+1))/2;
    end
    
    % Which Spectral Volume the input CV belongs to?   
    for s=1:SV_number
        for i=1:CV_per_SV
            whichSV(I_global(s,i))=s;
        end
    end
    whichSV = [whichSV SV_number];
    
end
