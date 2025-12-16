function result = closeImg(img, se)
    % CLOSING - Dilation followed by Erosion
    % ??????? ??????: ???? ?? ????
    
    % Apply dilation first
    dilated_img = dilation(img, se);
    
    % Then apply erosion on the dilated image
    result = erosion(dilated_img, se);
end