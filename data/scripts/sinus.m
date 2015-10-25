function out = sinus(amplitude, omega, phaze, samp_per_sec, length)
% generate sinus (amplitude, omega, phaze, samp_per_sec, length (seconds))
    
    [ ~, ~, time] = generateTime(samp_per_sec, length);
    
    
    func = amplitude * sin(omega*time + phaze);
    out = [time,func];
end