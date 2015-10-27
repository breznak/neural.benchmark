function [ data ] = makeErrorsAt(varargin)
%Makes errors at 'changes' indeces. If 'where' is shorter than data, 'where'
%is replicated.
%data = makeErrorsAt(data, where, [zeroExcluded])
    
    epsilon = 1e-15;

    if nargin == 4
        zeroExcluded = varargin{4};
    end
    data = varargin{1};
    where = varargin{2};
    amplitude = varargin{3};

    K = size(where, 1);
    N = size(data, 2);
    
    if K > N
        where = where(1:N);
    elseif K < N
        
        howManytimesOver = N / K;
        
        where = repmat(where, fix(howManytimesOver), 1);
        leftover = uint8(K*(howManytimesOver - fix(howManytimesOver)));
        where = [where; where(1:leftover)];
    end
    
    % TODO
    %make error from where
    
    
    if zeroExcluded == 1
        condition = abs(data(:,2)-0) < epsilon;
        error(condition) = 0;
    end
    
    data(:,2) = data(:,2) + error;


end

