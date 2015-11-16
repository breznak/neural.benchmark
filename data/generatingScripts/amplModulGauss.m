function data = amplModulGauss(data, ~, zeroExcluded)
%amplModulGauss(data, ~, [zeroExluded])
%   Amplifies data in the middle of data's length. Derivations at the ends
%   remain the same.
%   
%   
%       data ... second column is fed with data, others not considered
%       amplitude ... amplitude of the gaussian
%       zeroExluded ... if 1, then don't shift zero values, else shift
%                      everything
    
    epsilon = 1e-15;

    if nargin < 3
        zeroExcluded = 0;
    end
    
    amplitude = 0.1; %magic
    
    
    n = size(data,1);
    
    mu = floor(n/2); %middle
    % Following is set to fit exactly the data vector from begging to
    % end and to keep marginal derivations unchanged.
    sigma = mu/3; %magic
   
    gauss = amplitude  *  exp(-([1:n]' - mu).^2/(2*sigma*sigma));
    
    if zeroExcluded == 1
        condition = abs(data(:,2)-0) < epsilon;
        gauss(condition) = 0;
    end
    
    data(:,2) = data(:,2) .* (gauss+1);
    
    gaussCondition = gauss ~= 0;
    
    data(gaussCondition,4) = 1; 
end