function [ data ] = pointAnomaliesVector(varargin)
%Makes errors at 'whereToMakeAnomaly' indeces. If 'whereToMakeAnomaly' is shorter than data, 'whereToMakeAnomaly'
%is replicated.
%data = pointAnomaliesVector(data, whereToMakeAnomaly, [zeroExcluded])
    
    epsilon = 1e-15;

    if nargin == 4
        zeroExcluded = varargin{4};
    else
        zeroExcluded = 0;
    end
    data = varargin{1};
    whereToMakeAnomaly = varargin{2};
    amplitude = varargin{3};

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
        whereToMakeAnomaly = whereToMakeAnomaly && isNotZero;
    end
    
    data(whereToMakeAnomaly,2) = data(whereToMakeAnomaly,2) + amplitude;


end

