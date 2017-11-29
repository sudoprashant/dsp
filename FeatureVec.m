function [STD,Mean,  CoV, average,  cwtmean, LOA, Skew,  ZCR, cwtvar] = FeatureVec(Window_x, Window_y, Window_z)
%FeatureVec Extracts features from a given window. 



StandardDeviationx = std(Window_x);% FOR STADARD DEVIATION
StandardDeviationy = std(Window_y);
StandardDeviationz = std(Window_z);

STD = (StandardDeviationx^2 + StandardDeviationy^2 + StandardDeviationz^2)^0.5;

calculatedMeanx = mean(Window_x);  %for mean 
calculatedMeany = mean(Window_y);
calculatedMeanz = mean(Window_z);

Mean = (calculatedMeanx^2 + calculatedMeany^2 + calculatedMeanz^2)^0.5;


CoVx = calculatedMeanx/StandardDeviationx;
CoVy = calculatedMeany/StandardDeviationy;      %COEFICIENT OF VARIATION
CoVz = calculatedMeanz/StandardDeviationz;  

CoV = (CoVx^2 + CoVy^2 + CoVz^2)^0.5;

magnitude = sqrt(Window_x.^2+Window_y.^2+Window_z.^2);


average = mean(magnitude);






% apply fast fourier transformation to the signal
% Next power of 2 from length of averaged rms acceleration
NFFT = 2 ^ nextpow2(length(Window_y)); 
freqAccel = fft(Window_y, NFFT) / length(Window_y);
f = linspace(0, 1, NFFT / 2 + 1);


amplitudeSpectrum = 2 * abs(freqAccel(1:NFFT / 2 + 1));%AMPLITUDE OF SPECTRUM
%cwtmean
cwtmx=imag(mean(mean(cwt(Window_x))));
cwtmy=imag(mean(mean(cwt(Window_y))));
cwtmz=imag(mean(mean(cwt(Window_z))));

cwtmean = (cwtmx^2 + cwtmy^2 + cwtmz^2)^0.5;
%[maxVal, maxIndx] = max(amplitudeSpectrum); % Find Peak
%maxFreq = f(maxIndx); %Freq. Feature 2


                                       
extWx = Window_x - mean(Window_x);
ext1Wx = extWx(1:9); ext2Wx = extWx(2:10); %Auto-Corelation
Loanx = sum(ext1Wx.*ext2Wx);
Loadx = sum(extWx.^2);
Loax = Loanx/Loadx;

extWy = Window_y - mean(Window_y);
ext1Wy = extWy(1:9); ext2Wy = extWy(2:10);
Loany = sum(ext1Wy.*ext2Wy);
Loady = sum(extWy.^2);
Loay = Loany/Loady;

extWz = Window_z - mean(Window_z);
ext1Wz = extWz(1:9); ext2Wz = extWz(2:10);
Loanz = sum(ext1Wz.*ext2Wz);
Loadz = sum(extWz.^2);
Loaz = Loanz/Loadz;

LOA = (Loax^2 + Loay^2 + Loay^3)^0.5;

%Skewness
extWx = Window_x - mean(Window_x);
extWxpow2 = extWx.^2;
extWxpow3 = extWx.^3;
Skewx = sum(extWxpow3)/(sum(extWxpow2))^1.5;

extWy = Window_y - mean(Window_y);
extWypow2 = extWy.^2;
extWypow3 = extWy.^3;
Skewy = sum(extWypow3)/(sum(extWypow2))^1.5;

extWz = Window_z - mean(Window_z);
extWzpow2 = extWz.^2;
extWzpow3 = extWz.^3;
Skewz = sum(extWzpow3)/(sum(extWzpow2))^1.5;

Skew = (Skewx^2 + Skewy^2 + Skewz^2)^0.5;



%Zero Crossing Rate
ZCRx = sum(abs(diff(Window_x>0)))/length(Window_x);
ZCRy = sum(abs(diff(Window_y>0)))/length(Window_y);
ZCRz = sum(abs(diff(Window_z>0)))/length(Window_z);

ZCR = (ZCRx^2 + ZCRy^2 + ZCRz^2)^0.5;


%cwtvar
cwtvx=mean(var(cwt(Window_x)));
cwtvy=mean(var(cwt(Window_y)));
cwtvz=mean(var(cwt(Window_z)));

cwtvar = (cwtvx^2 + cwtvy^2 + cwtvz^2)^0.5;

end