function [ new_img ] = NonlinearMaxFilter( oldimage,mask_h,mask_w)
[H W L]=size(oldimage);
oldimage=double(oldimage);
copy=zeros(mask_h ,mask_w);
new_img=zeros(H,W,L);
X=floor(mask_h/2);
Y=floor(mask_w/2);
for i=1:H-mask_h 
 for j=1:W-mask_w
  for m=1:L
   for k=1:mask_h
     for l=1:mask_w
         copy(k,l)=oldimage(i+k-1,j+l-1,m) ; 
     end
   end
         new_img(i+X,j+Y,m)=max(copy(:));
  end
 end 
end
new_img=uint8(new_img);
%imshow(new_img),title('Max Filter');
end          