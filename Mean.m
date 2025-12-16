function [ new_img ] = Mean( oldimage)
mask=[1/9 1/9 1/9;1/9 1/9 1/9;1/9 1/9 1/9];

oldimage=double(oldimage);
new_img=PaddingFilter(oldimage,mask);

new_img=abs(new_img);
new_img=clipping(new_img );

new_img=uint8(new_img);
%imshow(new_img),title('mean filter');

end     
          