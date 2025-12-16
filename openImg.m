function result = openImg(img, se)
    % OPENING - Erosion followed by Dilation
    % ????? ??????: ???? ?? ????
    
    % Apply erosion first
    eroded_img = erosion(img, se);
    
    % Then apply dilation on the eroded image
    result = dilation(eroded_img, se);
end