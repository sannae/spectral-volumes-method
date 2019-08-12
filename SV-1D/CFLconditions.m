% CFLCONDITIONS checks that the CFL conditions are respected. Knowing the
% CV_NUMBER, the abscissas CV_X, the average values U, the physical
% parameter GAMMA and the CFLNUMBER, it gives back the correct time
% interval DT to be used in the time scheme.

function dt = CFLconditions(CV_number,CV_x,u,gamma,CFLnumber)

    dt=10^12;
    
    for i=1:CV_number
            Delta_x(i) = abs(CV_x(i+1)-CV_x(i));
            p = pressure(u(:,i),gamma);
            soundspeed(i) = sqrt(gamma*p/u(1,i));
            information_velocity = abs(u(2,i)/u(1,i)) + soundspeed(i);
            dt_temp = CFLnumber*Delta_x(i)/information_velocity;
            dt=min(dt_temp,dt);
     end

end
