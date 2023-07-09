

fsavg=64  %Average Sampling Rate

data=xlsread('perf1andppg1.csv'); 
perf=data(:,1)


subplot(3,1,1)
time=(1:1:length(perf))
time=time/64
plot(time,perf)
title('Perfusion Waveform (Baseline Variation)')


%estimating breath rate . respiratory signal at 0.3 Hz
Resp_Signal=bandpass(perf,[0.25 0.35],64)
[pks, locs]=findpeaks(Resp_Signal,'MinPeakDistance',32) 
x_peaks = time(locs);
subplot(3,1,2)
plot(time,Resp_Signal,  x_peaks,pks,'o')

distance=[]
for i=1:length(pks)-1
    difference=locs(i+1)-locs(i)
    
    distance=[distance difference] % distance between each peak is breath rate in samples for total breaths
end
dis_mean=mean(distance)
BR=round((fsavg*60)/dis_mean) %breath rate in minutes

