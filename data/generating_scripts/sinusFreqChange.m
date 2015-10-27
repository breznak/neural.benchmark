function out = sinusFreqChange(amplitude, omega, phaze, fs, length)
% generate sinus (amplitude, omega, phaze, sampPerSec, length (seconds))
%   omega ... vector of omegas, 
    
    [dt, N, time] = generateTime(fs, length);
    
    %normalize
    omega = 2*pi*normalizeFrequency(fs, omega/(2*pi));
    
    func = amplitude * sin(omega(time)*time + phaze);
    

    period = periodicity(omega/(2*pi), dt, N, phaze / omega);
    
    anomaly = zeros(N, 1);
    
    out = [time,func, period, anomaly];
end