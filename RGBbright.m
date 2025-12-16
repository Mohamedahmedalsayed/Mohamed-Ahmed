function [ RGB ] = RGBbright( RGB , op , offset )
[w,h,index]=size(RGB);
if(op=='+')
  for i=1:w
    for j=1:h   
        RGB(i,j,1)=RGB(i,j,1)+offset;
		RGB(i,j,2)=RGB(i,j,2)+offset;
		RGB(i,j,3)=RGB(i,j,3)+offset;
    end
  end
else if(op=='-')
  for i=1:w
    for j=1:h 
        RGB(i,j,1)=RGB(i,j,1)-offset;
		RGB(i,j,2)=RGB(i,j,2)-offset;
		RGB(i,j,3)=RGB(i,j,3)-offset;
    end
 end 
else if(op=='*')
  for i=1:w
    for j=1:h  
        RGB(i,j,1)=RGB(i,j,1)*offset;
		RGB(i,j,2)=RGB(i,j,2)*offset;
		RGB(i,j,3)=RGB(i,j,3)*offset;
    end
 end 
else if(op=='/')
  for i=1:w
    for j=1:h  
        RGB(i,j,1)=RGB(i,j,1)/offset;
		RGB(i,j,2)=RGB(i,j,2)/offset;
		RGB(i,j,3)=RGB(i,j,3)/offset;
    end
 end 
    end
    end
    end
end
imshow(RGB),title('rgb');
end