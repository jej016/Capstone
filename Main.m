classdef Main
    methods (Static)
        function result = Start()
            % Top channel- venous pressure recording in an ear vein
            % Middle channel- venous pressure recording in one of the limbs
            % Bottom channel- arterial pressure recording with a piezo electric pressure sensor near the neck of the animal
            % Select which LabChart (.adicht) file to use
            f = adi.readFile;
            
            % Store channels
            ch1 = f.getChannelByName('Channel 1');
            ch2 = f.getChannelByName('Channel 2');
            ch3 = f.getChannelByName('Channel 3');
            
            % Store the data from each channel
            data1 = ch1.getData(1);
            data2 = ch2.getData(1);
            data3 = ch3.getData(1);
            
            % Determine when events occour
            event = eventDetector.detector('Events');
            
            % Turn off warnings
            warning('off','all');
            
            info(length(event.eventIndex)) = struct();
            
            % Package data into a custom structure           
            for i = 1:length(event.eventIndex)
                index = event.eventIndex(i);
                info(i).name = event.eventName(i);
                info(i).index = event.eventIndex(i);
                info(i).filter1 = FilterData.filter(data1(index:index+30000), 8, .1, 20, 4, .1, .001);
                info(i).filter2 = FilterData.filter(data2(index:index+30000), 8, .1, 20, 4, .1, .001);
                info(i).filter3 = FilterData.filter(data3(index:index+30000), 8, .04, 20, 8, .2, 1);
                info(i).fourier1 = Fourier.FFourier2(data1(index:index+30000));
                info(i).fourier2 = Fourier.FFourier2(data2(index:index+30000));
                info(i).fourier3 = Fourier.FFourier2(data3(index:index+30000));
                calc = CalcUnit.study(data1(index:index+30000), data2(index:index+30000), data3(index:index+30000));
                info(i).max = calc.maxi;
                info(i).min = calc.mini;
                info(i).avg = calc.avrg;
                info(i).var = calc.vari;
                info(i).stdDev = calc.stdDev;
                info(i).med = calc.medi;
            end
            
            % Turn warnings on
            warning('on','all');
            
            % return struct array
            result = info;
        end
    end
end