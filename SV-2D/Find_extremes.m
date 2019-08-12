% FIND_EXTREMES: this function, given a cell i,j, provides the minimum and
% the maximum among the averages of the neighboring cells. To be used in
% the Barth-Jaspersen limiter.

function [u_min u_max] = Find_extremes(n_x,n_y,CV_per_SV_side_x,CV_per_SV_side_y,u);

    for i=1:n_y*CV_per_SV_side_y
        for j=1:n_x*CV_per_SV_side_x

            % Define the stencil

            if i==1 % First row
                right_neighbor = u(i,j+1,:);
                left_neighbor = u(i,j-1,:);
                top_neighbor = u(i+1,j,:);
                NE_neighbor = u(i+1,j+1,:);
                NW_neighbor = u(i+1,j-1,:);

                stencil = [right_neighbor left_neighbor top_neighbor NE_neighbor NW_neighbor];

            else if i==n_y*CV_per_SV_side_y % Last row
                    right_neighbor = u(i,j+1,:);
                    left_neighbor = u(i,j-1,:);
                    bottom_neighbor = u(i-1,j,:);
                    SE_neighbor = u(i-1,j+1,:);
                    SW_neighbor = u(i-1,j-1,:);

                    stencil = [ right_neighbor left_neighbor bottom_neighbor SE_neighbor SW_neighbor];

                else if j==1 % First column
                        right_neighbor = u(i,j+1,:);
                        top_neighbor = u(i+1,j,:);
                        bottom_neighbor = u(i-1,j,:);
                        NE_neighbor = u(i+1,j+1,:);
                        SE_neighbor = u(i-1,j+1,:);

                        stencil = [right_neighbor top_neighbor bottom_neighbor NE_neighbor SE_neighbor];

                    else if j==n_x*CV_per_SV_side_x % Last column
                            left_neighbor = u(i,j-1,:);
                            top_neighbor = u(i+1,j,:);
                            bottom_neighbor = u(i-1,j,:);
                            NW_neighbor = u(i+1,j-1,:);
                            SW_neighbor = u(i-1,j-1,:);

                            stencil = [left_neighbor top_neighbor bottom_neighbor NW_neighbor SW_neighbor];

                        else if i==1 && j==1 % SW cell
                                right_neighbor = u(i,j+1,:);
                                top_neighbor = u(i+1,j,:);
                                NE_neighbor = u(i+1,j+1,:);

                                stencil = [right_neighbor top_neighbor NE_neighbor];

                            else if i==1 && j==n_x*CV_per_SV_side_x % SE cell
                                    left_neighbor = u(i,j-1,:);
                                    top_neighbor = u(i+1,j,:);
                                    NW_neighbor = u(i+1,j-1,:);

                                    stencil = [left_neighbor top_neighbor NW_neighbor];
                                    
                                else if j==1 && i==n_y*CV_per_SV_side_y % NW cell
                                        right_neighbor = u(i,j+1,:);
                                        bottom_neighbor = u(i-1,j,:);
                                        SE_neighbor = u(i-1,j+1,:);

                                        stencil = [right_neighbor bottom_neighbor SE_neighbor]; % NE cell
                                        
                                    else if j==n_x*CV_per_SV_side_x && i==n_y*CV_per_SV_side_y
                                            left_neighbor = u(i,j-1,:);
                                            bottom_neighbor = u(i-1,j,:);
                                            SW_neighbor = u(i-1,j-1,:);
                                            
                                            stencil = [left_neighbor bottom_neighbor SW_neighbor];
                                            
                                        else

                                            right_neighbor = u(i,j+1,:);
                                            left_neighbor = u(i,j-1,:);
                                            top_neighbor = u(i+1,j,:);
                                            bottom_neighbor = u(i-1,j,:);

                                            NE_neighbor = u(i+1,j+1,:);
                                            SE_neighbor = u(i-1,j+1,:);
                                            NW_neighbor = u(i+1,j-1,:);
                                            SW_neighbor = u(i-1,j-1,:);

                                            stencil = [right_neighbor left_neighbor top_neighbor bottom_neighbor NE_neighbor SE_neighbor NW_neighbor SW_neighbor];

                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end

            % Computing u_min and u_max

            u_min(i,j,:) = min(stencil);
            u_max(i,j,:) = max(stencil);

        end
    end

end
