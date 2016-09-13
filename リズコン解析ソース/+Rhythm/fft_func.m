function[f,pwr] =fft_func(fft_data,fs) 

n_data = length(fft_data);
% fft_data= zeros(n_data,4);
% for i=1:n_data
%     fft_data(i,1)=Pul(i);
%     fft_data(i,2)=avt(i,2);
%     fft_data(i,3)=avt(i,3);
%     fft_data(i,4)=dist(i);
% end

n_fft=2^nextpow2(n_data);
FFT=fft(fft_data,n_fft);
f = (0:n_data-1)*(fs/n_data);
pwr = abs(FFT).^2 /n_fft;
%pwr = abs(FFT) /n_fft;
%pwr = 20*log10(abs(FFT));