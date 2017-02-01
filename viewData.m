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
ch4 = f.getChannelByName('Channel 4');
disp(ch4);
% Store the data from each channel
data1 = ch1.getData(1);
data2 = ch2.getData(1);
data3 = ch3.getData(1);
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
% Apply moving average (lowpass) filter to the data with window size of 100
windowSize = 100;
b = (1/windowSize)*ones(1,windowSize);
a = 1;
% Apply the filter
data3_prime = filter(b,a,data3);
% Create new figure for filtered data
figure(3);
% Graph the filtered data
hold;
plot(data3)
plot(data3_prime)
% Apply FFT to filtered data
fft3_prime = fft(data3_prime);
% Create new figure for filtered FFT
figure(4);
% Graph the filtered fft
hold;
plot(fft3)
plot(fft3_prime)
