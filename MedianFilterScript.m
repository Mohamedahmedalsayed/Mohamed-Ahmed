im = imread('sp.tif');

figure, imshow(im);
figure, imshow(MedianFilter(im, 3));