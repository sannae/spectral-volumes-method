% PLOT_MAIN is the main plot of the code. It plots all the variables in a
% single plot. The title corresponds to the chosen PROBLEM_CASE,
% BOUNDARY_CASE and INITIAL_CASE

function plot_main(x0,x1,CV_x,RecValues_left,problem_case,boundary_case,initial_case)

        title_problem = 'Equation: ';
        title_boundary = 'Boundary: ';
        title_initial = 'Initial: ';
          hold off
          plot(CV_x(1:end),RecValues_left(1,:),'r','LineWidth',2)
          hold on
          plot(CV_x(1:end),RecValues_left(2,:),'g','LineWidth',2)
          hold on
          plot(CV_x(1:end),RecValues_left(3,:),'b','LineWidth',2)
          title_complete = ({[title_problem problem_case];[title_boundary boundary_case];[title_initial initial_case]});
          title(title_complete,'FontWeight','bold');
          xlabel('x')
          ylabel('variable')
          axis([x0 x1 -0.5 2.5])
         legend('Density','Momentum','Energy','Location','NorthWest')
      
end
