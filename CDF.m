function [] = CDF(im)
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
    
    plot(cdf);
    title('CDF');
    xlabel('Gray Level');
    ylabel('CDF');
    legend('CDF Curve');
end

