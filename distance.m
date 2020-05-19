function dist = distance(x, y)
    dist = sqrt(sum((x-y).^2, 2));