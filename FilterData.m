classdef FilterData
    methods (Static)
        function result = filter(dataRaw, N_Low, F3dB_Low, Ast_Low, N_High, F3dB_High, Ast_High)
            % Apply IIR (Chebyshev Type II) lowpass filter to the data with N order, F3dB*PI
            % cutoff frequency, and stopband attenuation of Ast dB
            d = fdesign.lowpass('N,F3dB',N_Low,F3dB_Low);
            setspecs(d,'N,F3dB,Ast',N_Low,F3dB_Low,Ast_Low);
            Hcheby2Low = design(d,'cheby2','SystemObject',true);
            e = fdesign.highpass('N,F3dB',N_High,F3dB_High);
            setspecs(e,'N,F3dB,Ast',N_High,F3dB_High,Ast_High);
            Hcheby2High = design(e,'cheby2','SystemObject',true);
            result = Hcheby2High(Hcheby2Low(dataRaw));
        end
    end
end