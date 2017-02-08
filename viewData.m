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
% Store the data from each channel
data1 = ch1.getData(1);
data2 = ch2.getData(1);
data3 = ch3.getData(1);
% Plot the data from each of the signals
GraphData.graph(data1, data2, data3);
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
figure(3)
result = FilterData.filter(data3, 8, .04, 20, 8, .2, 1);
plot (result)
% Apply FFT to filtered data
fft3_prime = fft(result);
% Create new figure for filtered FFT
figure(4);
% Graph the filtered fft
hold;
plot(fft3)
plot(fft3_prime)
