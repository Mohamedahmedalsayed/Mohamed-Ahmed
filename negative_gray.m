function [ negative ] = negative_gray( I )
[W H]=size(I);
for i=1:W
    for j=1:H
        negative(i,j)=255-I(i,j);
    end 
end
%imshow(negative),title('neg-Gray');

end

