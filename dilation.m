function result = dilation(img, se)
    % Dilation morphological operation
    % img: input image (binary, grayscale, or RGB)
    % se: structuring element
    
    % If image is RGB, convert to grayscale
    if size(img, 3) == 3
        img = rgb2gray(img);
    end
    
    % Convert to binary if needed
    if ~islogical(img)
        try
            img = imbinarize(img);
        catch
            img = im2bw(img, graythresh(img));
        end
    end
    
    % Perform dilation using MATLAB's built-in function
    try
        result = imdilate(img, se);
    catch ME
        fprintf('Using manual dilation due to: %s\n', ME.message);
        result = manual_dilation(img, se);
    end
    
    % Convert to uint8 for display
    if islogical(result)
        result = uint8(result) * 255;
    else
        result = uint8(result);
    end
end

function result = manual_dilation(img, se)
    % Manual dilation implementation
    % Get structuring element information
    se_neighborhood = getnhood(se);
    [se_h, se_w] = size(se_neighborhood);
    se_center = floor(([se_h, se_w] + 1) / 2);
    
    % Get image size
    [h, w] = size(img);
    
    % Initialize result
    result = false(h, w);
    
    % Apply dilation
    for i = 1:h
        for j = 1:w
            if img(i, j)
                % Apply SE to all positions
                for si = 1:se_h
                    for sj = 1:se_w
                        if se_neighborhood(si, sj)
                            % Calculate image coordinates
                            ii = i + (si - se_center(1));
                            jj = j + (sj - se_center(2));
                            
                            % Check bounds
                            if ii >= 1 && ii <= h && jj >= 1 && jj <= w
                                result(ii, jj) = true;
                            end
                        end
                    end
                end
            end
        end
    end
end