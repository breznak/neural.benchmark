function out = sine(amplitude, omega, fs, length)
% generate sine (amplitude, omega, sampPerSec, length (seconds))
    
    [~, N, time] = generateTime(fs, length);
    
    f = omega/(2*pi);
    
    %normalize
    omega = 2*pi*normalizeFrequency(fs, f);
    
    func = amplitude * sin(omega*time);
    

    period = periodicity(f, time);
    
    anomaly = zeros(N, 1);
    
    out = [time,func, period, anomaly];
end