function [noisyImage] = salt&papperNoise(image,option,precent)

%salt noise
if option == "salt"
    [h w]=size(image);
    noisyImage=image;
    for i = 1:h %for loops iterate through every pixel
        for j = 1:w
            noise_check = randi(precent); %creates a random number between 1 and noise_percent
            if noise_check == precent    %if the random number = noise_percent (1/noise_percent chance of any given pixel being noisy)
              noisyImage(i,j) = 255; %replaces the original pixel value with the random noise
            end
        end
    end
    
%pepper noise
elseif option=="pepper"
    [h w]=size(image);
    noisyImage=image;
    for i = 1:h %for loops iterate through every pixel
        for j = 1:w
            noise_check = randi(precent); %creates a random number between 1 and noise_percent
            if noise_check == precent    %if the random number = noise_percent (1/noise_percent chance of any given pixel being noisy)
               noisyImage(i,j) = 0; %replaces the original pixel value with the random noise
            end
        end
    end
    
% salt & pepper noise
elseif option == "salt & pepper"
    %noisyImage=imnoise(image,'salt & pepper');
    [h w]=size(image);
    noisyImage=image;
    for i = 1:h %for loops iterate through every pixel
        for j = 1:w
            noise_check = randi(precent); %creates a random number between 1 and noise_percent
            if noise_check == precent    %if the random number = noise_percent (1/noise_percent chance of any given pixel being noisy)
              noise_value = randi(256);    %creates a random noise value to replace the pixel
              noisyImage(i,j) = noise_value; %replaces the original pixel value with the random noise
            end
        end
    end
 

end


end

