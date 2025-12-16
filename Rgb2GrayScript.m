im = imread('peppers.png');

figure, imshow(Rgb2Gray(im, 1));
figure, imshow(Rgb2Gray(im, 2));
figure, imshow(Rgb2Gray(im, 3));
figure, imshow(Rgb2Gray(im, 4));
figure, imshow(Rgb2Gray(im, 5, [0.3, 0.5, 0.2]));