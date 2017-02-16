classdef Fourier
    methods (Static)
        function result = FFourier(X, index)
            Fs = 1000;            % Sampling frequency
            T = 1/Fs;             % Sampling period
            L = length(X);        % Length of signal
            t = (0:L-1)*T;        % Time vector
            
            Y = fft(X);
            P2 = abs(Y/L);
            P1 = P2(1:L/2+1);
            P1(2:end-1) = 2*P1(2:end-1);

            figure(index)
            f = Fs*(0:(L/2))/L;
            plot(f,P1)
            title('Single-Sided Amplitude Spectrum of X(t)')
            xlabel('f (Hz)')
            ylabel('|P1(f)|')
            
            result = P1;
        end
        function result = FFourier2(X)
            Fs = 1000;            % Sampling frequency
            T = 1/Fs;             % Sampling period
            L = length(X);        % Length of signal
            t = (0:L-1)*T;        % Time vector
            
            Y = fft(X);
            P2 = abs(Y/L);
            P1 = P2(1:L/2+1);
            P1(2:end-1) = 2*P1(2:end-1);
            
            result = P1;
        end
    end
end