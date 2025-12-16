function [ new_image ] = Log( image )
image=im2double(image);
[H  W  L]=size(image);
if L==3
 
    for i=1:H
        for j=1:W
                new_image(i,j,1)=log(image(i,j,1)+1);
                new_image(i,j,2)=log(image(i,j,2)+1);
                new_image(i,j,3)=log(image(i,j,3)+1);
        end
    end 
else
    for i=1:H
        for j=1:W
              new_image(i,j)=log(image(i,j)+1);
         end
     end
end
%imshow(new_image),title('log-image');
end

