function new_img=Rayleigh_noise( img,a,b )
[W,H] = size(img);
x=max(max(img));
for z = 1:double(x)
    if z>=a
        num_of_pixels=((2/b)*(z-a)*exp(((z-a)^2)/b))*H*W;
    else
        num_of_pixels=0;
    end
    for j=1:num_of_pixels
        x = ceil(rand(1, 1)*W);
        y = ceil(rand(1, 1)*H);
        img(x, y) =img(x, y)+j;
    end
end
new_img=img;
end

