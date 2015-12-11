function [ data ] = applyAnomalyVector(data, whereToMakeAnomaly, howMakeAnomalyFn, amplitude, zeroExcluded)
%% Makes errors at 'whereToMakeAnomaly' indices. 
% If 'whereToMakeAnomaly' is shorter than data, 'whereToMakeAnomaly'is replicated.
% data ... data to be modified
% whereToMakeAnomaly ... anomaly indices [logical] from
% generateAnomalyVector
% howMakeAnomalyFn ... anomaly generator (some noise for example)
% amplitude ... how many times to amplify the error
% zeroExcluded ... TODO why this functionality?
% Use: data = applyAnomalyVector(data, whereToMakeAnomaly, howMakeAnomalyFn, amplitide [,zeroExcluded])
% howMakeAnomalyFn = @(data, ampl [,ZeroExluded])
    
    epsilon = 1e-15;

    if nargin < 5
        zeroExcluded = 0;
    end

    K = size(whereToMakeAnomaly, 1);
    N = size(data, 1);
    
    % If too short or too long. 
    if K > N
        whereToMakeAnomaly = whereToMakeAnomaly(1:N);
    elseif K < N 
        howManytimesOver = N / K;
        whereToMakeAnomaly = repmat(whereToMakeAnomaly, fix(howManytimesOver), 1);
        leftover = uint8(K*(howManytimesOver - fix(howManytimesOver)));
        whereToMakeAnomaly = [whereToMakeAnomaly; whereToMakeAnomaly(1:leftover)];
    end
    
    if zeroExcluded == 1
        isNotZero = abs(data(:,2)-0) > epsilon;
        whereToMakeAnomaly = whereToMakeAnomaly & isNotZero;
    end
    
    whereToMakeAnomaly = find(whereToMakeAnomaly);
    
    error = howMakeAnomalyFn(data, amplitude, zeroExcluded);
    data(whereToMakeAnomaly,2) = error(whereToMakeAnomaly, 2);
    data(whereToMakeAnomaly,4) = error(whereToMakeAnomaly, 4);
end

