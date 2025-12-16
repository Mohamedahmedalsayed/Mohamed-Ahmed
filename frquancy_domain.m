function frquancy_domain( img )
fi=fft2(img);
fabs=abs(fi);
fstretching=log(1+fabs);
fn=mat2gray(fstretching);
inverse1=ifft2(fi);

fshift=fftshift(fi);
fabs_shift=abs(fshift);
fstretching_shift=log(1+fabs_shift);
fn_sfift=mat2gray(fstretching_shift);
  

end

