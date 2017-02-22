classdef Fourier
    methods (Static)
        function result = FFourier(X, index)
            % how many samples per second
            size = length(X);
            
            % calculate fft
            fastf = fft(X);
            calc1 = abs(fastf/size);
            calc2 = calc1(1:size/2+1);
            calc2(2:end-1) = 2*calc2(2:end-1);

            % graph
            figure(index)
            plot(calc2)
            
            % return result
            result = calc2;
        end
        function result = FFourier2(X)
            % how many samples per second
            size = length(X);
            
            % calcultate fft
            fastf = fft(X);
            calc1 = abs(fastf/size);
            calc2 = calc1(1:size/2+1);
            calc2(2:end-1) = 2*calc2(2:end-1);
            
            % return result
            result = calc2;
        end
    end
end