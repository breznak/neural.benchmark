function [dt, N, time] = generateTime(fs, length)


    dt = 1/fs;
    
    %For each complete period in interval <0,length>, there is a sample.
    N = floor(fs*(length-dt)) + 1;
     
    time = [0:dt:length-dt]';

    assert(size(time,1) == N, 'The size of the time and N are not the same.');


end

