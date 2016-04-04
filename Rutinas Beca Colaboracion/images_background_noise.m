function [noise DR] = images_background_noise(images, TAaxis)

nbit = 12;
max = 2^nbit;

[width height nim] = size(images);

center = [round(width/2) round(height/2)];

for n=1:nim
    noise(n) = images(center(1), center(2), n);
    DR(n) = 10*log10(max/noise(n));
end
figure();plot(TAaxis,noise); title('Noise value for center pixel (128, 160)'); xlabel('Exposure time (\mus)'); ylabel('Pixel value(0 - 4096)');
figure();plot(TAaxis,DR); title('Dinamic range in dB for center pixel (128, 160)'); xlabel('Exposure time (\mus)'); ylabel('Dinamic range(dB)');