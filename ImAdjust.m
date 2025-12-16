function result = ImAdjust(im, new_min, new_max)
    [H, W, L] = size(im);
    result = zeros(H, W, L);
    new_range = new_max - new_min;
    im = double(im);
    
    for k=1:L
        old_min = min(min(im(:, :, k)));
        old_max = max(max(im(:, :, k)));
        range = old_max-old_min;
        
        for i=1:H
            for j=1:W
                result(i, j, k) = ((im(i, j, k) - old_min) / range) * new_range + new_min;
            end
        end
    end
    
    result = uint8(result);
end

