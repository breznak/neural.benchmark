function [ periods ] = periodicity(f, time)
%Computes periodcity vector. periods = periodicity(f, time)
%
% For each period there is a 2*pi interval sampled according to fs.
    
    
    
    periods = time*2*pi*f;
    
    periods = mod(periods, 2*pi);
    

end

 