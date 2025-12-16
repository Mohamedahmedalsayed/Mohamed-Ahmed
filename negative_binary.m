function [ negative ] = negative_binary( I )
[W H]=size(I);
for i=1:W
    for j=1:H
        if I(i,j)==1
            negative(i,j)=0;
        else
            negative(i,j)=1;
        end
        end
end
%imshow(negative),title('neg-Binary');
end


	 