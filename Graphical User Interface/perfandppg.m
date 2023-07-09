Butterworth=butterworth
rawData=xlsread('Maxem.csv')
green=rawData(:,3)
[perf,PPG]=pre_process(Butterworth,green,64)
           
csvwrite('perfandppg.csv',[perf,PPG])

function [perf, PPG] = pre_process(fil,data,fs)
            perf=sgolayfilt(data,2,4*fs +1);
            PPG=data-perf;
            PPG=-1*PPG;
            PPG=filter(fil,PPG);
            PPG=normalize(PPG);
    
        end
function Hd = bfilter
%BUTTERWORTH Returns a discrete-time filter object.

% MATLAB Code
% Generated by MATLAB(R) 9.9 and Signal Processing Toolbox 8.5.
% Generated on: 03-Mar-2021 12:11:19

% Butterworth Bandpass filter designed using FDESIGN.BANDPASS.

% All frequency values are in Hz.
Fs = 64;  % Sampling Frequency

N   = 2;    % Order
Fc1 = 0.6;  % First Cutoff Frequency
Fc2 = 4;    % Second Cutoff Frequency

% Construct an FDESIGN object and call its BUTTER method.
h  = fdesign.bandpass('N,F3dB1,F3dB2', N, Fc1, Fc2, Fs);
Hd = design(h, 'butter');
end