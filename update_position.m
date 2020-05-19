function [X_new] = update_position(X, velocity, x_min, x_max, y_min, y_max)
    [m, n] = size(X);
    theta = 2*pi*rand(m,1);
    X_disp = [velocity*cos(theta) velocity*sin(theta)];
    X_new = X + X_disp;
    for i = 1:m
        if (X_new(i,1) > x_max)
            X_new(i,1) = 2*x_max - X_new(i,1);
        end
        if (X_new(i,1) < x_min)
            X_new(i,1) = 2*x_min - X_new(i,1);
        end
        if (X_new(i,2) > y_max)
            X_new(i,2) = 2*y_max - X_new(i,2);
        end
        if (X_new(i,2) < y_min)
            X_new(i,2) = 2*y_min - X_new(i,2);
        end
    end
    
    