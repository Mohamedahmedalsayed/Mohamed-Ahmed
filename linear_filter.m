function [ new_img ] = linear_filter( oldimage,mask)
[H W L]=size(oldimage);
oldimage=double(oldimage);
[mask_h,mask_w]=size(mask);
new_img=zeros(H,W,L);
mid_img=zeros(H+(2*mask_h)-2,W+(2*mask_w)-2,L);
for i=1:H
for j=1:W  
for l=1:L
           mid_img(i+mask_h,j+mask_w,l)=oldimage(i,j,l);
 end 
end
end
mid_img =linearFilter( mid_img,mask);

for i=1:H
 for j=1:W  
for l=1:L
           new_img(i,j,l)=mid_img(i+mask_h,j+mask_w,l);
 end 
end
end
new_img=abs(new_img);
new_img=clipping(new_img );
new_img=uint8(new_img);
%imshow(new_img);
end
           
          