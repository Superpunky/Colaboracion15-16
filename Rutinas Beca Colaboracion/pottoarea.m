%function rect = pottoarea(image, P)
%

function [rect,dist] = pottoarea(image, P)

Plin = sqrt(P/100);

[mu, maxpix] = centers_location_colab(image);

[backnoise, sigmax, sigmay] = gaussimagefit(image, mu(1), mu(2), maxpix);

sigma2 = [sigmax^2 0;0 sigmay^2];

x = norminv([Plin 1-Plin], mu(1), sigmax);
y = norminv([Plin 1-Plin], mu(2), sigmay);

rect = [x(2), y(2), x(1)-x(2), y(1)-y(2)];

dist.maxpix = maxpix;
dist.backnoise = backnoise;
dist.mux = mu(1);
dist.muy = mu(2);
dist.sigmax = sigmax;
dist.sigmay = sigmay;

h = figure(); imagesc(image);
hold on; rectangle('Position', rect);