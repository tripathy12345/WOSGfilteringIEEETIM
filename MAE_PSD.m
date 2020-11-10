function MAE_D=MAE_PSD(rec, x2,fs)
[Pxxf,freq]=psd_fft(rec, fs);
 Pxxdbf=10*log10(Pxxf);
 [Pxxn,freq]=psd_fft(x2, fs);
 Pxxdbn=10*log10(Pxxn);
%%PSD calculation for delta(0-4Hz)%%
for i=1:46
MAE_d(i)=abs(Pxxdbf(i)-Pxxdbn(i))./(46-0); %%%%delta information is present upto 46 bins, this will change for different sampling frequency
end
MAE_D=(sum(MAE_d)/(fs/2)); %%%%%formulae given in the paper
end