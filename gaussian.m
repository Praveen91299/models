function gau = gaussian(Y, mean, std)
    gau = exp(-((Y - mean).^2)./(std^2))./(std*sqrt(2*pi));