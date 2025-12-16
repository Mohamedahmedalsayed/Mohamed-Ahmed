function [nimage]=Peppernoise( I,p )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
[w,h,l]=size(I);
nimage=I;
np=p*w*h;
np=uint8(np);
%figure,imshow(I);
for k=1:l
for i=1:np    
    x=randi(w,1,1);
    y=randi(h,1,1);
    nimage(x,y,k)=0;    
end
end
%figure,imshow(nimage);
end
