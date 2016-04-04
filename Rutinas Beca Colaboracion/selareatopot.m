%function P = selareatopot(image)
%

function [P,dist] = selareatopot(image)

h = figure(); imagesc(image);

rect = getrect(h);
liminf = [ rect(1) rect(2)];
limsup = [ rect(1)+rect(3) rect(2)+rect(4)];

hold on; rectangle('Position', rect);

[mu, maxpix] = centers_location_colab(image);

[backnoise, sigmax, sigmay] = gaussimagefit(image, mu(1), mu(2), maxpix);

sigma2 = [sigmax^2 0;0 sigmay^2];

P = 100*mvncdf(liminf, limsup, mu, sigma2);

dist.maxpix = maxpix;
dist.backnoise = backnoise;
dist.mux = mu(1);
dist.muy = mu(2);
dist.sigmax = sigmax;
dist.sigmay = sigmay;

hold on; text(15, 25, ['Potencia en el área seleccionada: ', num2str(P,4), '%'],...
    'BackgroundColor', [0.6 0.6 0.6]);