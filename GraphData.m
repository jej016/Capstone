classdef GraphData
    methods (Static)
        function graph(data1, data2, data3)
            % The hold command allows you to plot multiple charts on the same graph
            % Enter the hold command again to only plot a single chart
            hold;
            % Figure allows you to create and view seperate graphs at the same time
            figure(1)
            % Plot the data from each of the signals
            plot(data1)
            plot(data2)
            plot(data3)
        end
    end
end