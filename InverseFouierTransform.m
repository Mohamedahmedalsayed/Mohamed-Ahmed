function [NewImageS] = InverseFouierTransform( img )

    [w,h] = size(img);
    NewImage=fft2(img);
    for width=1:w
        for hight=1:h
                r=real(NewImage(width,hight));
                im=imag(NewImage(width,hight));
                res=sqrt((r*r)+(im*im));
                NewImage(width,hight)=res;
        end
    end
    NewImage=log2(NewImage+1);
    NewImage=mat2gray(NewImage);
    
    NewImageS=fftshift(NewImage);
    %imshow(NewImageS)
    
end

