function [ new_img ] = linearFilter( oldimage,mask)
[H W L]=size(oldimage);
oldimage=double(oldimage);
[mask_h,mask_w]=size(mask);
X=floor(mask_h/2);
Y=floor(mask_w/2);
new_img=zeros(H,W,L);
for i=1:H-mask_h 
 for j=1:W-mask_w
     for m=1:L
     sum=0;    
    for k=1:mask_h
        for l=1:mask_w
            sum =sum+(oldimage(i+k-1,j+l-1,m)*mask(k,l));
        end
    end
           new_img(i+X,j+Y,m)=sum;
     end
 end 
end
end

           
          