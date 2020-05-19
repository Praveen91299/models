function [status] = update_status(X, radius)
    [m,n] = size(X);
    status = X(:,3);
    X_inf = X((X(:,3)==1),:);
    [m_inf, n_inf]= size(X_inf);
    for i = 1:m
        for j = 1:m_inf
            if distance(X(i,1:2),X_inf(j,1:2))<radius
                status(i) = 1;
                break;
            end
        end
    end