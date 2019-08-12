% PLOT_AVERAGES simply plots the updated averages of a selected CHOSEN VARIABLE. 
% It needs the CV_NUMBER, the array with the CV abscissas CV_X, the average U, 
% and the extrema X0, X1 as limits of the plot.

function plot_averages(CV_number,CV_x,u,chosen_variable,x0,x1)

    for i=1:CV_number
        plot([CV_x(i) CV_x(i+1)],[u(chosen_variable,i) u(chosen_variable,i)],'r','LineWidth',2)
        axis([x0 x1 -0.5 2.5])
        hold on
    end
    hold off  
    
end
