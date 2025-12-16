function [ filter_image ] = ideal_high( img,d0 )
img= rgb2gray(img);
imshow(img);
    fi=fft2(img);
    fi=fftshift(fi);
    nreal=real(fi);
    nimag=imag(fi);
    [h ,w]=size(img);
    filter=zeros(h,w);
    for i=1:h
        for j=1:w
            d=sqrt((i-h/2)^2+(j-w/2)^2);
            if d <= d0
                filter(i,j)=0;
            else
                filter(i,j)=1;
            end

        end
    end
    for i=1:h
        for j=1:w
            nreal(i,j)=nreal(i,j)*filter(i,j);
            nimag(i,j)=nimag(i,j)*filter(i,j);
            NI(i,j)=nreal(i,j)+sqrt(-1)*nimag(i,j);
        end
    end
    NI=fftshift(NI);
    NI=ifft2(NI);
    z=mat2gray(abs(NI));
    filter_image=z;
end

