function ImgAfterFilter =  Ideal_Low_Pass_Filter( I , D0 )
%IDEAL_LOW_PASS_FILTER Summary of this function goes here
%   Detailed explanation goes here
F = I;
[M,N] = size(F);
wM = zeros(M, M);
wN = zeros(N, N);
for u = 0 : (M - 1)
    for x = 0 : (M - 1)
        wM(u+1, x+1) = exp(-2 * pi * 1i / M * x * u);
    end    
end

for v = 0 : (N - 1)
    for y = 0 : (N - 1)
        wN(y+1, v+1) = exp(-2 * pi * 1i / N * y * v);
    end    
end
FI = wM * double(F) * wN;
FIS = fftshift(FI);
Filter = zeros(M,N);
for x = 1 : M
    for y = 1 : N
        if sqrt((x - M/2)^2+(y - N/2)^2) > D0
            Filter(x,y) = 0;
        else
            Filter(x,y) = 1;
        end
    end    
end
RF = real(FIS).*Filter;
ImagF = imag(FIS).*Filter;
New_Image = RF + ImagF*1i;

ImgAfterFilter = Normalize_Fourier_Valid_To_Imshow(ifft2(New_Image));

end

