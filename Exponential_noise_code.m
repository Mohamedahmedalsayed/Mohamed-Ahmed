function new_img=Exponential_noise_code( img,a,b)
[W, H] = size(img);
x=max(max(img));
for z = 1:double(x)
   num_of_pixels=(a*exp((-a)*z))*W*H;
    for j=1:num_of_pixels
        x = floor(rand(1, 1)*W)+1;
        y = floor(rand(1, 1)*H)+1;
        img(x, y) =img(x, y)+j;    
    end
end
new_img=uint8(img);
end

