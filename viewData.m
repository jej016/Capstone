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
dataTable = table(data1, data2, data3);
% Plot the data from each of the signals
GraphData.graph3(data1, data2, data3, 1);
% Apply FFT to each of the data signals
FourierTable = FFTData.FastFourier(data1, data2, data3, 2);
% Apply IIR (Chebyshev Type II) lowpass filter to the data with 8th order, .04*PI
% cutoff frequency, and stopband attenuation of 20 dB
result1 = FilterData.filter(data1, 8, .1, 20, 4, .1, .001);
result2 = FilterData.filter(data2, 8, .1, 20, 4, .1, .001);
result3 = FilterData.filter(data3, 8, .04, 20, 8, .2, 1);
FilterTable = table(result1, result2, result3);
GraphData.graph2(result1(5000000:5001000), data1(5000000:5001000), 5);
GraphData.graph2(result2(5000000:5001000), data2(5000000:5001000), 6);
GraphData.graph2(result3(5000000:5001000), data3(5000000:5001000), 7);
