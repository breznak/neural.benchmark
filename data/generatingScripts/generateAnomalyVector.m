function anomalyVector = generateAnomalyVector(data, p)
%% generateAnomalyVector(data, p)
% for given data vec and probability, generate signature vector where
% anomalies should occur
% p ... probability of error (uniform) [0,1]
% data ... data where we apply the error
% anomalyWidth ... how many times, consecutive, should the anomaly be
% repeated? Eg. for 2: '00100001' -> '01100011'
% return ... vector where desired error occurs

    d = data(:); % overcome v vs v' problem
    N = size(d,1);
    vec = (rand(N,1) <= p);
    
    %five times the same anomaly
    % TODO add param anomalyWidth and do this parametrically?
    anomalyVector = vec | [vec(2:end); 0] | [0; vec(1:end-1)] | [0 ; 0; vec(1:end-2)] ;
end

