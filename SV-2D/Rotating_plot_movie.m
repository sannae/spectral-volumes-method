% ROTATING_PLOT_MOVIE   Simply rotates the plot shown within the time
%   interval TIMESTEPS at the specified speed (AZIMUTHAL_SPEED to set the 
%   azimuthal angle, INCLINATION_SPEED to set the inclination angle) then save 
%   it as an .avi file with the specified NAME in the main folder.
%
%   Hint: To improve the visualization, low azimuthal and inclination speed
%   are recommended, i.e. <1. An optimal visualization is usually with
%   (0.9,-0.1)

function Rotating_plot_movie(timesteps,name,azimuthal_speed,inclination_speed)

    for t=1:timesteps
        camorbit(azimuthal_speed,inclination_speed); 
        drawnow; 
        M(t)=getframe(gcf);
    end

    movie(M)
    movie2avi(M,name);

end
