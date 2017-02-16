classdef eventDetector
    methods(Static)
        function result = detector(file)
            eventTime = datestr( xlsread(file, 'A:A'), 'HH:MM:SS' );
            [~, eventName] = xlsread(file, 'B:B');
            eventHour = hour(eventTime);
            eventMinute = minute(eventTime);
            eventIndex = zeros(37,1);
            eventIndex(1) = 1;
            for i = 2:length(eventTime)
                eventIndex(i) = (((eventHour(i) - eventHour(1)) * 60 * 60) + ((eventMinute(i) - eventMinute(1)) * 60)) * 1000;    
            end
            result = table(eventIndex, eventName);
        end
    end
end