function IF = Normalize_Fourier_Valid_To_Imshow( F )
%INVERSE_FOURIER_VALID_TO_IMSHOW Summary of this function goes here
%   Detailed explanation goes here
R = real(F);
Im = imag(F);

power = R.^2 + Im.^2;
Fabs = sqrt(power);

IF = uint8(Fabs);

end
