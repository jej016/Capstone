classdef eventDetector
    methods(Static)
        function detector(file)       
            eventTime = xlsread(file, 'A:A');
            eventName = xlsread(file, 'B:B');
            return table (eventTime, eventName);
        end
    end
end