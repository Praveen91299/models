frames = 100;
m = 50;                         %number of samples
ini_inf = 2;
X = zeros(m, 3);                %positions
X(:,1:2) = 100*rand(m,2);       %initialization
radius = 6;                     %radius of spread
velocity = 5;                   %velocity of movement
x_min = 0;
x_max = 100;
y_min = 0;
y_max = 100;
X_uinf = zeros(size(X));
X_inf = zeros(size(X));
X = initialize_inf(X, ini_inf);
F(frames) = struct('cdata',[],'colormap',[]);
%output = figure;
for i=1:frames
    X_uinf = X((X(:,3) == 0),:);
    X_inf = X((X(:,3) == 1),:);
    clf
    plot(X_uinf(:,1), X_uinf(:,2), '*b');
    hold on;
    plot(X_inf(:,1), X_inf(:,2), 'vr');
    title(sprintf('Spread simulation (frame = %.1f)',i));
    X(:,1:2) = update_position(X(:,1:2), velocity, x_min, x_max, y_min, y_max);
    X(:,3) = update_status(X, radius);
    hold all
    %F(i) = getframe(output);
    F(i) = getframe;
    pause(0.1);
end
hold off
clf
movie(F,1,10);