clc;
clear all;
close all;

%%%%%%%%%%%Code for IEEE TIM paper
%%%if you use this work, please cite our paper as
%%%Pranjali Gajbhiye, Nopparada Mingchinda, Wei Chen, Subhas Chandra
%%%Mukhopadhyay, Theerawit Wilaiprasitporn, Rajesh Kumar Tripathy, "Wavelet Domain Optimized Savitzky-Golay Filter
%%for the Removal of Motion Artifacts from EEG Recordings", IEEE
%%Transactions on Instrumentation and Measurement, Vol. pp, 2021

load standing_sl07t01_ch2.mat; %%%change the signal from MOBI databse
fs=100;
x1=x1-mean(x1); %%%mean removal
x1=x1./max(abs(x1)); %%%amplitude normalization
% plot(x1);

 [xa, xd1, xd2, xd3, xd4, xd5]=waveletdecompose(x1); %%%%waavelet decomposition
 
order=1:10; %%%order grid
window=round(0.5*fs):round(0.1*fs):round(1.5*fs); %%%window grid
for i=1:length(window)
    if (rem(window(i),2)==0)
        window(i)=window(i)+1;
    else
        window(i)=window(i);
    end
end
window_nn=window;
for i=1:length(order)
    for j=1:length(window)  
xaf = sgolayfilt(xa,order(i),window(j)); %%%%SG filter
kk=xa-xaf;
xfn=kk+xd1+xd2+xd3+ xd4+xd5;
MAE_D=MAE_PSD(xfn, x1,fs);
    zz(i,j)=MAE_D;
    end
end
min_MAE=min(min(zz));
[mm,ll]=find(zz==min_MAE); %%%optimal window selection
figure
imagesc(window_nn,order,  zz)
 
 pa1=mm;%%%%need to change
pa2=ll;
xaf = sgolayfilt(xa,order(pa1),window(pa2));
kk=xa-xaf;
xfn=kk+xd1+xd2+xd3+ xd4+xd5;
xfn=xfn';
figure,
subplot(211),
plot(x1, 'r');
subplot(212),
plot(xfn);


MInfo=mi(x1',xfn)

MAE_D_final=MAE_PSD(xfn, x1,fs)







% Nfft=100; 
% window=kaiser(32,3);  
% noverlap=16;   
% [Pssa,fp]=pwelch(xfn,window,noverlap,Nfft,fs);
% [Pref,fp]=pwelch(x1,window,noverlap,Nfft,fs);
% 
% Pxxdbf=10*log10(Pssa);
% Pxxref=10*log10(Pref);
% 
% figure    
% plot(fp,10*log10(Pssa),'-r', fp,10*log10(Pref),'-k');  
% xlim([0 30])
% xlabel('Frequency (Hz)');ylabel('Power Spectrum (uV^2/Hz)');
% title('Power Spectrum of delta Rhythm'); grid on
% legend('WOSG filter output', 'Noisy signal');

