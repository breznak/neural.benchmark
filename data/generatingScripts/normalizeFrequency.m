function f = normalizeFrequency(fs, f)
%normilzes frequency so that fs = k * f, for k = 2, 3, ...
% Notice that we follow Sampling Theorem and exlude k = 1;
     k = round(fs/f);
    
    assert(k >= 2, 'Sampling theorem has been broken. Lower function frequency or increase sampling frequency.');
    
    % Now, the frequency is not normalized.
    
    % f = fs/k 
    
end

