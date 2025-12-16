function [noisyImage] = GammaNoise(image,a,b)


image=double(image);
[h w l]=size(image);


for i=0:255 
   pixels=round(((a^b*i^(b-1))/(factorial(b-1)))*exp(-a*i)*w*h);
   for x=1:pixels
        row=ceil(rand(1,1)*h);
        column=ceil(rand(1,1)*w);
        image(row,column)=image(row,column)+i;
    end
end

%normalize gray level
for k=l:l
    mn=min(min(image(:,:,k)));
    mx=max(max(image(:,:,k)));
    image(:,:,k)=((image(:,:,k)-mn)/(mx-mn))*255;
end
noisyImage=uint8(image);
end



