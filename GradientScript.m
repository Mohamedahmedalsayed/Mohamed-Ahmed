% Read image
im = imread('house.tif');
figure, imshow(im);

% Calculate gx
Hx = [-1 -2 -1; 0 0 0; 1 2 1];
gx = Correlation(im, Hx);
figure, imshow(gx);

% Calculate gy
Hy = [-1 0 -1; -2 0 2; -1 0 1];
gy = Correlation(im, Hy);
figure, imshow(gy);

% Calculate the magnitude
M = abs(gx) + abs(gy);
figure, imshow(M);


