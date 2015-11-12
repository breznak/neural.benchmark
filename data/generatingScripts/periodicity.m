function [ periods ] = periodicity(f, dt, N, delay)
%Computes periodciity vector.
% delay ... delay in seconds such as func(t - delay) = 'initial value'

    durationOfPhazeShift = fix(delay / dt); %cut to lower value
    durationOfPeriod = round(1/(f*dt)); %very close to natural number
    k = fix((N - durationOfPhazeShift)/durationOfPeriod);
    
    durationOfLeftover = N - k * durationOfPeriod - durationOfPhazeShift;
    
    shift = durationOfPeriod - durationOfPhazeShift + 1 : durationOfPeriod;
    single = 1 : durationOfPeriod;
    leftover = 1 : durationOfLeftover;
    
    periods = [shift repmat(single, 1, k) leftover]';
    
   

end

 