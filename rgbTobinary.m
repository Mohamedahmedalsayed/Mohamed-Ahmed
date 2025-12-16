function [ binary ] = rgbTobinary ( rgbImage , t )
  [rows, columns, numberOfColorChannels] = size(rgbImage);
  if numberOfColorChannels  == 3
      redChannel = rgbImage(:, :, 1);
      greenChannel = rgbImage(:, :, 2);
      blueChannel = rgbImage(:, :, 3);
      
      grayImage = .299*double(redChannel) + ...
                  .587*double(greenChannel) + ...
                  .114*double(blueChannel);
      
      gray = double(grayImage);
      else
      gray = rgbImage;  % Input image is not really RGB color.
  end
	[w h] = size(gray);
	for x=1:w
		for y=1:h
			if(gray(x,y)>t)
				binary(x,y)= 1;
			else	
				binary(x,y)= 0;
			end
		end
	end
imshow (binary),title('rgbTobinary');
end 