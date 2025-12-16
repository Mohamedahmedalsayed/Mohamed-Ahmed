function [ new_img ] = point_edge(oldimage)
mask=[-1 -1 -1;-1 8 -1; -1 -1 -1];
oldimage=double(oldimage);
new_img=PaddingFilter(oldimage,mask);

new_img=abs(new_img);
new_img=clipping(new_img );

new_img=uint8(new_img);
imshow(new_img),title('new image (4N)');

end       
          