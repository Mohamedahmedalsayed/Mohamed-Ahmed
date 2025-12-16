im = [2 9 10 0; 7 1 6 1; 10 15 2 6; 11 3 8 10];
filter = [0 -1 0; -1 5 -1; 0 -1 0];
Correlation(im, filter)


% a. Filter an image with 3*3 smoothing box filter.
% im = imread('cameraman.tif');
% filter = ones(3, 3)/9;
% result = Correlation(im, filter);
% figure, imshow(im);
% figure, imshow(result);


% b. Filter an image with 3*3 smoothing weighted filter.
% im = imread('cameraman.tif');
% filter = [1 2 1; 2 4 2; 1 2 1]/16;
% result = Correlation(im, filter);
% figure, imshow(im);
% figure, imshow(result);


% c. Filter an image with 3*3 Laplacian filter with -4 in the center.
% im = imread('cameraman.tif');
% filter = [0 1 0; 1 -4 1; 0 1 0];
% result = Correlation(im, filter);
% figure, imshow(im);
% figure, imshow(result);


% d. Filter an image with 3*3 Laplacian filter with -8 in the center.
% im = imread('cameraman.tif');
% filter = [1 1 1; 1 -8 1; 1 1 1];
% result = Correlation(im, filter);
% figure, imshow(im);
% figure, imshow(result);


% e. Filter an image with 3*3 enhanced sharpened Laplacian filter 
% with 5 in the center.
% im = imread('cameraman.tif');
% filter = [0 -1 0; -1 5 -1; 0 -1 0];
% result = Correlation(im, filter);
% figure, imshow(im);
% figure, imshow(result);


% f. Filter an image with 3*3 enhanced sharpened Laplacian filter 
% with 9 in the center.
% im = imread('cameraman.tif');
% filter = [-1 -1 -1; -1 9 -1; -1 -1 -1];
% result = Correlation(im, filter);
% figure, imshow(im);
% figure, imshow(result);


% f. Filter an image with 3*3 enhanced sharpened Laplacian filter 
% with 9 in the center.
% im = imread('cameraman.tif');
% filter = [-1 -1 -1; -1 9 -1; -1 -1 -1];
% result = Correlation(im, filter);
% figure, imshow(im);
% figure, imshow(result);


% g. Filter an image with 3*3 line detection filter (H).
% im = imread('house.tif');
% filter = [-1 -1 -1; 2 2 2; -1 -1 -1];
% result = Correlation(im, filter);
% figure, imshow(im);
% figure, imshow(result);

% g. Filter an image with 3*3 line detection filter (V).
% im = imread('house.tif');
% filter = [-1 2 -1; -1 2 -1; -1 2 -1];
% result = Correlation(im, filter);
% figure, imshow(im);
% figure, imshow(result);

% g. Filter an image with 3*3 line detection filter (45).
% im = imread('house.tif');
% filter = [2 -1 -1; -1 2 -1; -1 -1 2];
% result = Correlation(im, filter);
% figure, imshow(im);
% figure, imshow(result);

% g. Filter an image with 3*3 line detection filter (-45).
% im = imread('house.tif');
% filter = [-1 -1 2; -1 2 -1; 2 -1 -1];
% result = Correlation(im, filter);
% figure, imshow(im);
% figure, imshow(result);











