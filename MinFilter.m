function [im]=MinFilter(img,hightFiltter,widthFilter)

[h w] =size(img);
NImg=zeros(h,w);
FImg=zeros(h+2,w+2);
for i=1:h
    for j=1:w
        FImg(i+1,j+1)=img(i,j);
    end
end

for i=1:h
    for j=1:w
        NImg(i,j)=min(min(FImg(i:i+hightFiltter-1,j:j+widthFilter-1)));
    
    end   

end
im = uint8(NImg);
end

