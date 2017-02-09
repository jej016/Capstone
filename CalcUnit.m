classdef CalcUnit
    methods (Static)
        function study(data1, data2, data3)
            avg1 = mean(data1)
            med1 = median(data1)
            stdv1 = std(data1)
            var1 = stdv1^2
            
            avg2 = mean(data2)
            med2 = median(data2)
            stdv2 = std(data2)
            var2 = stdv2^2
            
            avg3 = mean(data3)
            med3 = median(data3)
            stdv3 = std(data3)
            var3 = stdv3^2
            
            save('data.mat', 'avg1', 'med1', 'stdv1', 'var1', 'avg2', 'med2', 'stdv2', 'var2', 'avg3', 'med3', 'stdv3', 'var3');
        end
    end
end