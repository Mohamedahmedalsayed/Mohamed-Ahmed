function [nimage]=saltnoise( I,s )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
[w,h,l]=size(I);
nimage=I;
ns=s*w*h;
ns=uint8(ns);
%figure,imshow(I);
for k=1:l
for i=1:ns    
    x=randi(w,1,1);
    y=randi(h,1,1);
    nimage(x,y,k)=255;    
end
end
%figure,imshow(nimage);
end
