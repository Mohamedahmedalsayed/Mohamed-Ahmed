im = imread('peppers.png');

figure, imshow(im);
figure, imshow(Brightness(im, '+', 100));
figure, imshow(Brightness(im, '-', 100));
figure, imshow(Brightness(im, '*', 2));
figure, imshow(Brightness(im, '/', 2));