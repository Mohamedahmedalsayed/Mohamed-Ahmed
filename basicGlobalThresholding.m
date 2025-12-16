function result = basicGlobalThresholding(im, T, delta)
    [H, W] = size(im);
    result = zeros(H, W);
    
    while 1
        T0 = T;
        G1 = im(im > T);
        G2 = im(im <= T);
        
        m1 = mean(G1);
        m2 = mean(G2);
        T = round((m1 + m2) / 2);

        if abs(T - T0) < delta
            break;
        end
    end
    
    for i=1:H
        for j=1:W
            if im(i, j) > T
                result(i, j) = 1;
            else
                result(i, j) = 0;
            end
        end
    end
    
    result = logical(result);
end

