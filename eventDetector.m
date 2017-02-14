classdef eventDetector
    methods(Static)
        function detector(file)       
            eventTime = xlsread(file, 'A:A');
            eventName = xlsread(file, 'B:B');
            for i = 2:length(eventTime)-1
                eventIndex= duration(eventTime);    
            end    
            for j = 2 : length(evenTime)-1
                eventIndex(j)=(eventIndex(j)+eventIndex(j-1))*1000;
            end
            return table (eventIndex, eventName);
        end
    end
end