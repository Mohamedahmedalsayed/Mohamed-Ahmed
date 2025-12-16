function [ new_img ] = Weight( oldimage)
mask=[1/16 1/8 1/16;1/8 1/4 1/8;1/16 1/8 1/16];

oldimage=double(oldimage);
new_img=PaddingFilter(oldimage,mask);

new_img=abs(new_img);
new_img=clipping(new_img );

new_img=uint8(new_img);
%imshow(new_img),title('Weight filter');

end