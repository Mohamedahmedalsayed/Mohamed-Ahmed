function [ new_img ] = point_sharp(oldimage)
mask=[0 -1 0;-1 5 -1;0 -1 0];
oldimage=double(oldimage);
new_img=PaddingFilter(oldimage,mask);

new_img=abs(new_img);
new_img=clipping(new_img );

new_img=uint8(new_img);
%imshow(new_img),title('point sharp');

end          
          