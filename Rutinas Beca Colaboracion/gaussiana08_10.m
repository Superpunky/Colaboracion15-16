mux2 = 177; muy2 = 134;
mu2 = [mux2 muy2];
sigma3 = [ 10 0; 0 10];
x2 = 1:320; y2 = 1:256;
[X2 Y2] = meshgrid(x2,y2);
pdf2d2 = mvnpdf([X2(:) Y2(:)], mu2, sigma3);
pdf2d2 = reshape(pdf2d2, length(y2), length(x2));
figure(); surf(x2, y2, pdf2d2);