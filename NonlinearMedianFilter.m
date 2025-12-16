function [ new_img ] = NonlinearMedianFilter( oldimage,mask_h,mask_w)
X=floor(mask_h/2);
Y=floor(mask_w/2);
Z=floor(mask_h/2)+floor(mask_w/2)+1;
[H W L]=size(oldimage);
oldimage=double(oldimage);
copy=zeros(mask_h ,mask_w);
sorted=zeros(mask_h*mask_w,1); 
new_img=zeros(H,W,L);
for i=1:H-mask_h 
 for j=1:W-mask_w
  for m=1:L
   for k=1:mask_h
    for l=1:mask_w
         copy(k,l)=oldimage(i+k-1,j+l-1,m) ;
    end
   end
     sorted=sort(copy);
     new_img(i+X,j+Y,m)=sorted(Z,1);
  end
 end 
end
new_img=uint8(new_img);
%imshow(new_img),title('Median Filter');
end          