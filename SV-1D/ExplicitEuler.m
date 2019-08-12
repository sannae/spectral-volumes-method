% EXPLICITEULER is the time scheme. Using as input the CV_NUMBER, the nodes
% CV_X, the time interval DT and the flux F, it basically updates the
% average U.

function u = ExplicitEuler(CV_number,CV_x,dt,u,f)

    for i=1:CV_number
        Delta_x = CV_x(i+1)-CV_x(i);
        u(:,i)=u(:,i)-dt/Delta_x * (f(:,i+1)-f(:,i));
    end
    
end
