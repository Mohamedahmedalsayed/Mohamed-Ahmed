function [ FI ] = ferqancy_filter( FI )

FI = fftshift(FI);
FI = ifft2(FI);
FI=abs(FI);
FI=log(FI);
FI=mat2gray(FI);
end

