function [ negative ] = negative_rgb( I )
[W H L]=size(I);
for i=1:W
    for j=1:H
        for k=1:L
        negative(i,j,k)=255-I(i,j,k);
        end
    end 
end
%imshow(negative),title('neg-RGB');
end