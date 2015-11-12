function data = pointAnomalyRandom(varargin)
%data = pointAnomalyRandom (data, density, amplitude [, zeroExluded])
%Corrupts data so that it includes erros in points.
%   probability ... probability of error ocurring in a sample
%               good value is around 0.001 - 0.1
    
    epsilon = 1e-15;

    if nargin == 4
        zeroExcluded = varargin{4};
    else
        zeroExcluded = 0;
    end
    data = varargin{1};
    probability = varargin{2};
    amplitude = varargin{3};
    

    N = size(data, 1);

    % Pseudorandom number (!), therefore, in theory given a lot of time, HTM could learn this.
    whereToMakeError = rand(N, 1) <= probability;

    
    if zeroExcluded == 1
        isNotZero = abs(data(:,2)-0) > epsilon;
        whereToMakeError = whereToMakeError && isNotZero;
    end
    
    data(whereToMakeError,2) = data(whereToMakeError,2) + amplitude;


end

