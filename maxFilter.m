function [noisyImage] =maxFilter(I,SizeOfMark)

[W,H]=size(I);
newImage=zeros(W,H);
if SizeOfMark==3
    I=padarray(I,[1 1],'rep');
    start=2;
elseif SizeOfMark==5
      I=padarray(I,[2 2],'rep');
      start=3;
end
k=start-1;

[W,H]=size(I);
for i=start:W-k
    for j=start:H-k
        mask=double(I(i-k:i+k,j-k:j+k));
        maskVector=mask(:);
        maskVector=sort(maskVector);
        mid=(max(maskVector(:))+min(maskVector(:)))/2;
        val=mid;
        newImage(i-k,j-k)=val;
    end
end
noisyImage=uint8(newImage);


end

