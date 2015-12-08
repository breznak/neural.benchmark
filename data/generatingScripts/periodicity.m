function [ periods ] = periodicity(f, time)
%Computes periodcity vector. periods = periodicity(f, time)
%
% For each period there is a 2*pi interval sampled according to fs.
    
    
    
    periods = time*2*pi*f;
    
    for i=1:size(periods,1)        
        while periods(i) >= 2*pi
            periods(i) = periods(i) - 2*pi;
        end
    end
    

end

 