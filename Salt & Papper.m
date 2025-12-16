function newImage = saltandpeppernoise(i , psalt , ppepper)
newImage = i;
[w,h,L] = size (i);

numofsalt =(psalt *w *h);
numofpepper=(ppepper*w *h);

for k=1:L
          for  i =1:numofsalt
                  row =randi(w,1,1);
                  col =randi (h,1,1);  
                  newImage(row,col,k) =255;
           end
end

for k =1:L
         for i =1:numofpepper
               row =randi(w,1,1);
               col =randi (h,1,1);  
               newImage(row,col,k) =0; 
          end
end


subplot(1,2,1),imshow(i),title('origin image');
subplot(1,2,2),imshow(newImage),title('image after noise');
end



