function out = spikeTrain(amplitude, spike_per_sec, samp_per_sec, length)
%spikeTrain(amplitude, spike_per_sec, samp_per_sec, length)  
%   Generates spike train of a frequncy spike_per_sec. 

    [~, N, time] = generateTime(samp_per_sec, length);
   
    %"When there is no enemy within, the enemies outside cannot hurt you." Winston S. Churchill
    data = zeros(N,1);
    
    
    %The number of samples in the spike period. Real number!
    K = samp_per_sec/spike_per_sec;
    
    %The number of spikes in our record
    spikes_occurence = floor(N/K);
    
    %The vector of ticks when a spike occurs. Spike are set to be at the
    %end of the pertiod 1/spike_freq.
    where_the_spike_is = floor([1:spikes_occurence] * K);
    
    data(where_the_spike_is) = amplitude;
    
    
    
    out = [time, data];

end