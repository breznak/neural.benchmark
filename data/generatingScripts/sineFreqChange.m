function [out, om] = sineFreqChange(amplitude, omega, phaze, fs, length)
% generate sine (amplitude, @(x) omega(x), phaze, sampPerSec, length (seconds))
%   omega ... function of time returning omegas
%             very nice: @(x) sin(x/50)/50 + 0.3
    
    [dt, N, time] = generateTime(fs, length);
    
   
    om = omega(time);
    func = amplitude * sin(omega(time).*time + phaze);
    
    % TODO What is the meaning in here?
    %period = periodicity(omega/(2*pi), dt, N, phaze / omega);
    period = ones(N, 1);
    
    anomaly = ones(N, 1);
    
    out = [time,func, period, anomaly];
end