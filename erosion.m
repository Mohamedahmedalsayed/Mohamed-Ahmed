function result = erosion(img, se)
    % Erosion morphological operation
    % img: input image (binary, grayscale, or RGB)
    % se: structuring element
    
    % If image is RGB, convert to grayscale
    if size(img, 3) == 3
        img = rgb2gray(img);
    end
    
    % Convert to binary if needed
    if ~islogical(img)
        % Try different methods based on MATLAB version
        try
            img = imbinarize(img);
        catch
            % For older MATLAB versions
            img = im2bw(img, graythresh(img));
        end
    end
    
    % Perform erosion using MATLAB's built-in function (most reliable)
    try
        result = imerode(img, se);
    catch ME
        % If built-in fails, use manual method
        fprintf('Using manual erosion due to: %s\n', ME.message);
        result = manual_erosion(img, se);
    end
    
    % Convert to uint8 for display
    if islogical(result)
        result = uint8(result) * 255;
    else
        result = uint8(result);
    end
end

function result = manual_erosion(img, se)
    % Manual erosion implementation
    % Get structuring element information
    se_neighborhood = getnhood(se);
    [se_h, se_w] = size(se_neighborhood);
    se_center = floor(([se_h, se_w] + 1) / 2);
    
    % Get image size
    [h, w] = size(img);
    
    % Initialize result
    result = false(h, w);
    
    % Apply erosion
    for i = 1:h
        for j = 1:w
            % Check if structuring element fits
            fits = true;
            
            % Check each element in SE
            for si = 1:se_h
                for sj = 1:se_w
                    if se_neighborhood(si, sj)
                        % Calculate image coordinates
                        ii = i + (si - se_center(1));
                        jj = j + (sj - se_center(2));
                        
                        % Check bounds
                        if ii >= 1 && ii <= h && jj >= 1 && jj <= w
                            if ~img(ii, jj)
                                fits = false;
                                break;
                            end
                        else
                            % Out of bounds - doesn't fit
                            fits = false;
                            break;
                        end
                    end
                end
                if ~fits
                    break;
                end
            end
            
            % Set result pixel
            if fits
                result(i, j) = true;
            end
        end
    end
end