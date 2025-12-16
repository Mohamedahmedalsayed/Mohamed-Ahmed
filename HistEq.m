function result = HistEq(im)
    [H, W] = size(im);
    count = zeros(256, 1);
    
    % Count gray levels
    for i=1:H
        for j=1:W
            count(im(i, j) + 1) = count(im(i, j) + 1) + 1;
        end
    end
    
    % PDF
    p = count / (H*W);
    cdf = zeros(256, 1);
    
    % CDF
    for i=1:256
        cdf(i) = p(i);
        if i ~= 1
            cdf(i) = cdf(i) + cdf(i - 1);
        end
    end
    
    % Mapping gray levels
    % r -> s
    s = round(255*cdf);
    
    result = zeros(H, W);
    for i=1:H
        for j=1:W
            result(i, j) = s(im(i, j) + 1);
        end
    end
    
    result = uint8(result);
    imshow(result);
end

