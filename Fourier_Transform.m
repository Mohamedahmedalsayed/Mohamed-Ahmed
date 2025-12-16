function F = Fourier_Transform( I )

[M,N] = size(I);
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
FI = wM * double(I) * wN;
% FI=fft2(I);
FIS = fftshift(FI);
R = real(FIS);
Im = imag(FIS);

power = R.^2 + Im.^2;
Fabs = sqrt(power);
Flog = log(1+Fabs);

newmax = 255;
newmin = 0;
oldMin = min(min(Flog));
oldMax = max(max(Flog));    
FN = ((Flog-oldMin)/(oldMax-oldMin))*(newmax - newmin)+newmin;
F = uint8(FN);
end
