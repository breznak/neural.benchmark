function [ periods ] = periodicity(f, dt, N, delay)
%Computes periodciity vector.
% delay ... a ratio of how much with respecft to f is function shifted
%           delay = "phaze" / f;

    durationOfPhazeShift = fix(1 / (delay*f*dt)); %cut to lower value
    durationOfPeriod = uint8(1/(f*dt)); %very close to natural number
    k = fix((N - durationOfPhazeShift)/durationOfPeriod);
    durationOfLeftover = N - k * durationOfPeriod - durationOfPhazeShift;
    
    shift = durationOfPeriod - durationOfPhazeShift + 1 : durationOfPeriod;
    single = 1 : durationOfPeriod;
    leftover = 1 : durationOfLeftover;
    
    periods = [shift; repmat(single, k ,1); leftover];

end

 