% Top channel- venous pressure recording in an ear vein
% Middle channel- venous pressure recording in one of the limbs
% Bottom channel- arterial pressure recording with a piezo electric pressure sensor near the neck of the animal
% Select which LabChart (.adicht) file to use
f = adi.readFile;
% Display general information about the data stored in the file
disp(f);
% Store channels and display information specific to each channel
ch1 = f.getChannelByName('Channel 1');
disp(ch1);
ch2 = f.getChannelByName('Channel 2');
disp(ch2);
ch3 = f.getChannelByName('Channel 3');
disp(ch3);
% I am not sure what channel 4 is
% ch4 = f.getChannelByName('Channel 4');
% disp(ch4);
% Store the data from each channel
data1 = ch1.getData(1);
data2 = ch2.getData(1);
data3 = ch3.getData(1);
% I am not sure what channel 4 is
% data4 = ch4.getData(1);
% The hold command allows you to plot multiple charts on the same graph
% Enter the hold command again to only plot a single chart
hold;
% Figure allows you to create and view seperate graphs at the same time
figure(1)
% Plot the data from each of the signals
plot(data1)
plot(data2)
plot(data3)
% Apply FFT to each of the data signals
fft1 = fft(data1);
fft2 = fft(data2);
fft3 = fft(data3);
% Create new figure for FFT
figure(2);
% Graph the FFT of the data channels
hold;
plot(fft1)
plot(fft2)
plot(fft3)
% Apply IIR (Chebyshev Type II) lowpass filter to the data with 8th order, .04*PI
% cutoff frequency, and stopband attenuation of 20 dB
N_Low = 8;
F3dB_Low = .04;
d = fdesign.lowpass('N,F3dB',N_Low,F3dB_Low);
%HbutterLow = design(d,'butter','SystemObject',true);
Ast_Low = 20;
setspecs(d,'N,F3dB,Ast',N_Low,F3dB_Low,Ast_Low);
Hcheby2Low = design(d,'cheby2','SystemObject',true);
data3Low = Hcheby2Low(data3);
N_High = 8;
F3dB_High = .2;
e = fdesign.highpass('N,F3dB',N_High,F3dB_High);
%HbutterHigh = design(e,'butter','SystemObject',true);
Ast_High = 1;
setspecs(e,'N,F3dB,Ast',N_High,F3dB_High,Ast_High);
Hcheby2High = design(e,'cheby2','SystemObject',true);
data3High = Hcheby2High(data3);
data3Filt = Hcheby2High(Hcheby2Low(data3));
% Create new figure for filtered data
figure(3);
% Graph the filtered data
hold;
plot(data3(5000000:5001000))
plot(data3High(5000000:5001000))
plot(data3Low(5000000:5001000))
plot(data3Filt(5000000:5001000))
legend('Raw','Low','High','Both')
% Apply FFT to filtered data
fft3_prime = fft(data3Low);
% Create new figure for filtered FFT
figure(4);
% Graph the filtered fft
hold;
plot(fft3)
plot(fft3_prime)