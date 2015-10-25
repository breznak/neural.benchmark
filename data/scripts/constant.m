function out = constant(amplitude, samp_per_sec, length)
% generate constant(amplitude, samp_per_sec, length (seconds))
    [~, N, time] = generateTime(samp_per_sec, length);

    func = repmat(amplitude,N,1);
    
    period = ones(N,1);
    anomaly = zeros(N,1);
    out = [time,func,period,anomaly];
end
