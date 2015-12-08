function anomalyVector = generateAnomalyVector(data, p)
% generateAnomalyVector(data, p)
% p ... probability of error

    N = size(data,1);
    

 
    
    vec = (rand(N,1) <= p);
    
    %five times the same anomaly
    anomalyVector = vec | [vec(2:end); 0] | [0; vec(1:end-1)] | [0 ; 0; vec(1:end-2)] ;


end

