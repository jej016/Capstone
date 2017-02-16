classdef FFTData
    methods (Static)
        function result = FastFourier(ch1, ch2, ch3, index)
            ff1 = Fourier.FFourier(ch1, index);
            ff2 = Fourier.FFourier(ch2, index + 1);
            ff3 = Fourier.FFourier(ch3, index + 2);
            result = table(ff1, ff2, ff3);
        end
    end
end