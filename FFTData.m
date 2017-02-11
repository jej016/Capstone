classdef FFTData
    methods (Static)
        function FastFourier(ch1, ch2, ch3, index)
            fft1 = fft(ch1);
            GraphData.graph1(fft1, index)
            fft2 = fft(ch2);
            GraphData.graph1(fft2, index + 1)
            fft3 = fft(ch3);
            GraphData.graph1(fft3, index + 2)
        end
    end
end