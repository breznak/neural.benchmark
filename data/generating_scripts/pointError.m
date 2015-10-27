function data = pointError(varargin)
%data = pointError (data, density, amplitude [, zeroExluded])
%Corrupts data so that it includes erros in points.
%   probability ... probability of error ocurring in a sample
%               good value is around 0.1 ? 0.3
    
    epsilon = 1e-15;

    if nargin == 4
        zeroExcluded = varargin{4};
    end
    data = varargin{1};
    probability = varargin{2};
    amplitude = varargin{3};
    

    N = size(data, 1);

    % Pseudorandom number (!), therefore, theoreticaly, HTM could learn this.
    whereToMakeError = rand(N, 1) >= probability;

    
    if zeroExcluded == 1
        isNotZero = abs(data(:,2)-0) > epsilon;
        whereToMakeError = whereToMakeError && isNotZero;
    end
    
    data(whereToMakeError,2) = data(whereToMakeError,2) + amplitude;


end

