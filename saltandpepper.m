function [new_Img] = saltandpepper(img,ps ,pp)
[w ,h,l] = size (img);
numofsalt =round(ps *w*h);
numofpepper=round(pp*w *h);

for i =1:numofsalt
    
    row =ceil(rand(1,1)*h);
    col =ceil(rand(1,1)*w);
    img(row,col) =255;
end
for i =1:numofpepper
     row =ceil(rand(1,1)*h);
     col =ceil(rand(1,1)*w);
     img(row,col) =0;
end
new_Img=img;
new_Img=uint8(new_Img);
end