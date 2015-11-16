function anomalyVector = generateAnomalyVector(data, p)
% generateAnomalyVector(data, p)
% p ... probability of error

    N = size(data,1);
    

 
    
    vec = (rand(N,1) <= p);
    %triple the anomaly
    anomalyVector = vec | [vec(2:end); 1] | [1; vec(1:end-1)];


end

