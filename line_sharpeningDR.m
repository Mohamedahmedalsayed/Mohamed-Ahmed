function [im]=line_sharpeningDR(img)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
DR=[ 1 0 0 ;
     0 1 0;
     0 0 -1 ];
[h w] =size(img);
[fh fw] = size(DR);
NImg=zeros(h,w);
FImg=zeros(h+2,w+2);
for i=1:h
    for j=1:w
        FImg(i+1,j+1)=img(i,j);
    end
end

m = zeros(fh,fw);

for i=1:h
    for j=1:w
        m = FImg(i:i+fh-1, j:j+fh-1);
        NImg(i,j) = sum(sum(m .*DR));
    end
end
im= uint8(NImg);

end