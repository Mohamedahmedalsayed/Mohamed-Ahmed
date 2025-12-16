function [noisyImage] = UniformNoise(image,a,b)


image=double(image);
[h w l]=size(image);

pixels=round((1/(b-a))*w*h);

for i=0:255
   for x=1:pixels
        row=ceil(rand(1,1)*h);
        column=ceil(rand(1,1)*w);
        image(row,column)=image(row,column)+i;
    end
end

noisyImage=uint8(image);
end

