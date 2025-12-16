im = imread('cameraman.tif');

figure, imshow(im);
figure, imshow(Gamma(im, 1, 2));
figure, imshow(Gamma(im, 1, 0.5));