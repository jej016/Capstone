classdef FFTData
    methods (Static)
        function FastFourier(ch1, ch2, ch3, index)
            Fourier.FFourier(ch1(5000000:5005000), index)
            Fourier.FFourier(ch2(5000000:5005000), index + 1)
            Fourier.FFourier(ch3(5000000:5005000), index + 2)
        end
    end
end