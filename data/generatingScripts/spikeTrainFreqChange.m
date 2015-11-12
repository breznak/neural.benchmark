function out = spikeTrainFreqChange(amplitude, spikesPerSec, sampsPerSec, length)
%spikeTrain(amplitude, @(t) spikesPerSec(t), sampsPerSec, length)  
%   Generates spike train of a frequncy spike_per_sec(t). 

    [dt, N, time] = generateTime(sampsPerSec, length);
   
    %"When there is no enemy within, the enemies outside cannot hurt you." Winston S. Churchill
    data = zeros(N,1);
    
    % TODO : How to handle it here?
    %The number of samples in the spike period. Presumably natural number;
    K = sampsPerSec/spikesPerSec;
    
    period = ones(N,1);
    
    %The number of spikes in our record
    spikes_occurence = floor(N/K);
    
    %The vector of ticks when a spike occurs. Spike are set to be at the
    %end of the pertiod 1/spike_freq.
    where_the_spike_is = floor([1:spikes_occurence] * K);
    data(where_the_spike_is) = amplitude;
    
    anomaly = zeros(N,1);

    out = [time, data, period, anomaly];

end