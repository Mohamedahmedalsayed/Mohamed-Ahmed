function result = Negative(im)
    im = im2double(im);
    
    result = 1 - im;
    result = im2uint8(result);
end

