classdef eventDetector
    methods(Static)
        function result = detector(file)
            % read in data from excel file
            eventTime = datestr( xlsread(file, 'A:A'), 'HH:MM:SS' );
            [~, eventName] = xlsread(file, 'B:B');
            eventName = strcat(eventName, '- ', eventTime);
            
            % separate hours and minutes from time
            eventHour = hour(eventTime);
            eventMinute = minute(eventTime);
            
            % preallocate eventIndex array
            eventIndex = zeros(37,1);
            
            % convert time to index
            eventIndex(1) = 1;
            for i = 2:length(eventTime)
                eventIndex(i) = (((eventHour(i) - eventHour(1)) * 60 * 60) + ((eventMinute(i) - eventMinute(1)) * 60)) * 1000;    
            end
            
            % return table of index and name
            result = table(eventIndex, eventName);
        end
    end
end