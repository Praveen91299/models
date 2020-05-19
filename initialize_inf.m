function [X_inf] = initialize_inf(X, inf_no)
    [m, n] = size(X);
    X_inf = X;
    X_inf(1:inf_no,3) = 1;