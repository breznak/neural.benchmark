function out = changePhase(data, p, fs ,f, zeroExluded)
% Generate sine with phaze shifts with probability p
% out = changePhase(data, probability, fs ,f)
% p: scalar - stands for probability an anomaly would occure
%             in several consecutive samplea. Good value is around 0.005
    if nargin < 5
        zeroExluded = 0;
    end

    anomalyVector = generateAnomalyVector(data, p);
    
    % Create a data stream which is delayed for a half a period.
    shiftedPhase = data(:,2);
    periodN = floor(fs/2*f);
    shiftedPhase = wshift('1D', shiftedPhase, periodN);
    
    % If set, do not apply anomaly to zero values
    if zeroExluded == 1
        anomalyVector = anomalyVector & (data(:,2) ~= 0);
    end
    
    % Combine the two vectors = shift the function where intended.
    data(anomalyVector,2) = shiftedPhase(anomalyVector);
   
    % Add anomaly anotation
    data(anomalyVector,4) = 1;
   
    
    out = data;
end