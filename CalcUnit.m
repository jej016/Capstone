classdef CalcUnit %defines the class for the calc unit that will interface with the main class
    methods (Static)
        function study(data1, data2, data3) %operations will be performed 
            %on the three input arrays: data1, data2, data3
            
            %operations to be performed on each data signal will be: mean,
            %median, standard deviation, variance, min and max
            avgSig1 = mean(data1);
            medSig1 = median(data1);
            stdvSig1 = std(data1);
            varSig1 = stdvSig1^2;
            minSig1 = min(data1);
            maxSig1 = max(data1);
            
            avgSig2 = mean(data2);
            medSig2 = median(data2);
            stdvSig2 = std(data2);
            varSig2 = stdvSig2^2;
            minSig2 = min(data2);
            maxSig2 = max(data2);
            
            avgSig3 = mean(data3);
            medSig3 = median(data3);
            stdvSig3 = std(data3);
            varSig3 = stdvSig3^2;
            minSig3 = min(data3);
            maxSig3 = max(data3);
            
            %operations to be performed on all data signals as a whole
            dataAll = [data1; data2; data3];
            
            avgAll = mean(dataAll);
            medAll = median(dataAll);
            stdvAll = std(dataAll);
            varAll = stdvAll^2;
            minAll = min(dataAll);
            maxAll = max(dataAll);
            
            %each variable will be saved to a .mat file to be able to be
            %referenced later
            save('t1.mat', 'avgSig1', 'medSig1', 'stdvSig1', 'varSig1', 'minSig1', 'maxSig1', 'avgSig2', 'medSig2', 'stdvSig2', 'varSig2', 'minSig2', 'maxSig2', 'avgSig3', 'medSig3', 'stdvSig3', 'varSig3', 'minSig3', 'maxSig3', 'avgAll', 'medAll', 'stdvAll', 'varAll', 'minAll', 'maxAll');
        end
    end
end