function X_new = update_status_zombie(X, z, h)
    [m, n] = size(X);
    X_new = X;
    for i=1:m
        if (X(i,3)>1)
            X(i,3) = X(i,3) - 1;
        elseif (X(i,3)==0)
            if ~isempty(X(((distance(X(:,1:2),X(i,1:2))<=z.infect_radius)&(X(:,3)==1)),:))  %any zombie within infection radius
                X(i,3) = z.conv_time;
                X(((distance(X(:,1:2),X(i,1:2))<=z.infect_radius)&(X(:,3)==1)),6:7) = 0;
            elseif ~isempty(X(((distance(X(:,1:2),X(i,1:2))<=h.radius)&(X(:,3)==1)),:))   %any zombie within line of sight
                if X(i,4) ~= 2
                    if X(i,5) >0
                        X(i,5) = X(i,5) - 1;
                        X(i,4) = 1;
                    else
                        X(i,4) = 2;
                        X(i,5) = h.tired_frames;
                    end
                else
                    if X(i,5) == 0
                        X(i,4) = 1;
                    else
                        X(i,5) = X(i,5) - 1;
                    end
                end
            end
        end     
    end
    X_new = X;