function [newImage] = GaussianFilterUpdated(image,D0,option)

[M,N] = size(image);
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

FI = wM * double(image) * wN;
FIS = fftshift(FI);


filter=zeros(M, N);

if option == 1
    for i=1:M
        for j=1:N
            dis=sqrt((i-(M/2)).^2+(j-(N/2)).^2);
            if dis<=D0
                filter(i,j)=exp(-(dis^2)/(2*(D0^2)));    %lowpass
            end
        end
    end

else 
    for i=1:M
        for j=1:N
            dis=sqrt((i-(M/2)).^2+(j-(N/2)).^2);
            if dis>=D0
                filter(i,j)=1-(exp(-(dis^2)/(2*(D0^2))));    %heighpass
            end
        end
    end
end

RF = real(FIS).*filter;
ImagF = imag(FIS).*filter;
New_Image = RF + ImagF*1i;

newImage = Normalize_Fourier_Valid_To_Imshow(ifft2(New_Image));
    
end

