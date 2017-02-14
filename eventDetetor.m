classdef eventDetetor
    methods(Static)
        function detector(file,target)       
            fid = fopen(file);
            tline = fgets(fid);
            int8 x=0;
            disp(x);
            while ischar(tline)
                tline = fgets(fid);
                if (num2str(tline)==target)
                    x=x+1;
                end
            end
            fclose(fid);
            
            save (target,x)
        end
    end
end