function [X_new] = update_position_zombie(X, z, h, bound)
    [m, n] = size(X);
    X_new = X;
    %theta = 2*pi*rand(m,1);
    %X_disp = [velocity*cos(theta) velocity*sin(theta)];
    %X_new = X + X_disp;
    for i = 1:m
        nei = zeros(size(X));
        if X(i,3) == 0
            nei = X(((distance(X(:,1:2),X(i,1:2))<=h.radius)&(X(:,3)~=0)),:);
        elseif X(i,3) == 1 && X(i,6) == 0
            nei = [];
            dist_min = z.radius + 1;
            for j = 1:m
                dist = distance(X(j,1:2),X(i,1:2));
                if (dist < dist_min) && (X(j,3) ==0)
                    dist_min = dist;
                    nei = X(j,:);
                    X_new(i, 7) = j;
                end
            end
            %{
            neib = X(((distance(X(:,1:2),X(i,1:2))<=z.radius)&(X(:,3)==0)),:);
            if ~isempty(neib)
                neib_min = distance(neib(1,1:2),X(i,1:2));
                for j=1:size(neib,1)
                    if distance(neib(j,1:2),X(i,1:2)) < neib_min
                        neib_min = distance(neib(j,1:2),X(i,1:2));
                        nei = neib(j,:);
                    end
                end
            else
                nei = [];
            end
            %}
        end
        
        %thus now we calculate x_cent, y_cent
        if ~isempty(nei) && X(i,3) == 0
            x_cent = sum(gaussian(distance(X(i,1:2),nei(:,1:2)), 0, z.radius/2).*nei(:,1))/sum(gaussian(distance(X(i,1:2),nei(:,1:2)), 0, z.radius/2));
            y_cent = sum(gaussian(distance(X(i,1:2),nei(:,1:2)), 0, z.radius/2).*nei(:,2))/sum(gaussian(distance(X(i,1:2),nei(:,1:2)), 0, z.radius/2));
            theta = atan2((y_cent - X(i,2)), (x_cent - X(i,1)));
        elseif ~isempty(nei) && X(i,3) == 1 && X(i,6) == 0
            theta = atan2((nei(1,2) - X(i,2)),(nei(1,1) - X(i,1)));
            X_new(i,6) = 1;
        elseif X(i,3) == 1 && X(i,6) == 1
            theta = atan2(X(X(i,7),2) - X(i,2), X(X(i,7),1) - X(i,1));
        else
            theta = sum(2*pi*rand(2),'all');
            X_new(i,7) = 0;
            X_new(i,6) = 0;
        end
        
        %movement update
        if X_new(i,3) == 0
            if X_new(i,4) == 1
                X_new(i,1) = X_new(i,1) - h.speed_sprint*cos(theta);
                X_new(i,2) = X_new(i,2) - h.speed_sprint*sin(theta);
            else
                X_new(i,1) = X_new(i,1) - h.speed*cos(theta);
                X_new(i,2) = X_new(i,2) - h.speed*sin(theta);
            end
        elseif X(i,3) == 1
            X_new(i,1) = X_new(i,1) + z.speed*cos(theta);
            X_new(i,2) = X_new(i,2) + z.speed*sin(theta);
        end
        
        %Boundary check and reflection
        if (X_new(i,1) > bound.x_max)
            X_new(i,1) = 2*bound.x_max - X_new(i,1);
        end
        if (X_new(i,1) < bound.x_min)
            X_new(i,1) = 2*bound.x_min - X_new(i,1);
        end
        if (X_new(i,2) > bound.y_max)
            X_new(i,2) = 2*bound.y_max - X_new(i,2);
        end
        if (X_new(i,2) < bound.y_min)
            X_new(i,2) = 2*bound.y_min - X_new(i,2);
        end
    end