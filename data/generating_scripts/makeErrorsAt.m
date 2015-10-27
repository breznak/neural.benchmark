function [ data ] = makeErrorsAt(varargin)
%Makes errors at 'changes' indeces. If 'where' is shorter than data, 'where'
%is replicated.
%data = makeErrorsAt(data, where, [zeroExcluded])
    
    epsilon = 1e-15;

    if nargin == 4
        zeroExcluded = varargin{4};
    end
    data = varargin{1};
    whereToMakeError = varargin{2};
    amplitude = varargin{3};

    K = size(whereToMakeError, 1);
    N = size(data, 2);
    
    if K > N
        whereToMakeError = whereToMakeError(1:N);
    elseif K < N
        
        howManytimesOver = N / K;
        
        whereToMakeError = repmat(whereToMakeError, fix(howManytimesOver), 1);
        leftover = uint8(K*(howManytimesOver - fix(howManytimesOver)));
        whereToMakeError = [whereToMakeError; whereToMakeError(1:leftover)];
    end
    
    
    
    if zeroExcluded == 1
        isNotZero = abs(data(:,2)-0) > epsilon;
        whereToMakeError = whereToMakeError && isNotZero;
    end
    
    data(whereToMakeError,2) = data(whereToMakeError,2) + amplitude;


end

