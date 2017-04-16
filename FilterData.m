classdef FilterData
    methods (Static)
        function result = filter(dataRaw, order_low, cutoff_low, stopband_low, order_high, cutoff_high, stopband_high)
            % Apply IIR (Chebyshev Type II) lowpass filter to the data
            low = fdesign.lowpass('N,F3dB',order_low,cutoff_low);
            setspecs(low,'N,F3dB,Ast',order_low,cutoff_low,stopband_low);
            Hcheby2Low = design(low,'cheby2','SystemObject',true);
            
            % Apply IIR (Chebyshev Type II) highpass filter to the data
            high = fdesign.highpass('N,F3dB',order_high,cutoff_high);
            setspecs(high,'N,F3dB,Ast',order_high,cutoff_high,stopband_high);
            Hcheby2High = design(high,'cheby2','SystemObject',true);
            result = Hcheby2High(Hcheby2Low(dataRaw));
        end
    end
end