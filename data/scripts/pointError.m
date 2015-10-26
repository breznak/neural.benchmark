function data = pointError(varargin)
%data = pointError (data, density, amplitude [, zeroExluded])
%Corrupts data so that it includes erros in points.
%   density ... rate of how many point errors there are in a second
    
    epsilon = 1e-15;

    if nargin == 4
        zeroExcluded = varargin{4};
    end
    data = varargin{1};
    density = varargin{2};
    amplitude = varargin{3};
    

    N = size(data, 1);
    dt = data(2,2) - data(1,2);

    error = zero(N, 1);
    
    %TODO
    
    
    
    if zeroExcluded == 1
        condition = abs(data(:,2)-0) < epsilon;
        error(condition) = 0;
    end
    
    data(:,2) = data(:,2) + error;


end

