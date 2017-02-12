classdef GraphData
    methods (Static)
        function graph1(data1, index)
            % The hold command allows you to plot multiple charts on the same graph
            % Figure allows you to create and view seperate graphs at the same time
            figure(index)
            % Plot the data from each of the signals
            plot(data1)
        end
        function graph2(data1, data2, index)
            % Figure allows you to create and view seperate graphs at the same time
            figure(index)
            % The hold command allows you to plot multiple charts on the same graph
            % Enter the hold command again to only plot a single chart
            hold;
            % Plot the data from each of the signals
            plot(data1)
            plot(data2)
        end
        function graph3(data1, data2, data3, index)
            % Figure allows you to create and view seperate graphs at the same time
            figure(index)
            % The hold command allows you to plot multiple charts on the same graph
            % Enter the hold command again to only plot a single chart
            hold;
            % Plot the data from each of the signals
            plot(data1)
            plot(data2)
            plot(data3)
        end
    end
end