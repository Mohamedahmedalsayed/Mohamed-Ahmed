im = imread('low.tif');

figure, imshow(im);
figure, imshow(ImAdjust(im, 0, 255));

%ImAdjust([6 13 12 13; 12 6 7 12; 13 7 7 12; 14 11 11 14], 0, 15)