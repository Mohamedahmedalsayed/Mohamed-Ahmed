function  [ni]=uniformNoise_rgb( RGB,p,a,b )
%figure,imshow(RGB),title('orignal');
R1=uniformNoise(RGB(:,:,1),p,a,b );
G1=uniformNoise(RGB(:,:,2),p,a,b);
B1=uniformNoise(RGB(:,:,3),p,a,b );
ni=cat(3,uint8(R1),uint8(G1),uint8(B1));
figure,imshow(ni),title('RGB high butterworth PASS FILTER');
end