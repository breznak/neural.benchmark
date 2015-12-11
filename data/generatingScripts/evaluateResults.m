function [statistic, vectors] = evaluateResults(anomaly, has_anomaly, tresh_hold)
% evaluateResults: [vectors statistics] = evaluateResults(anomaly, has_anomaly)
% anomaly ... float: obtained anomaly, computed by an algortihm [Nx1]
% has_anomaly ... bool: anotation of original data [Nx1]
% tresh_hold ... float: tresh hold to determind if anomaly(i) should be
%                 considered as anomaly or not.
% OUTPUTS:
% vectors.FP/.FN/.TP/.TN vectors of bools showing where those occured
% statistic.FP/.FN/.TP/.TN float,a percentage of the whole set
% statistic.tresh_hold 

assumed_anomaly = anomaly >= tresh_hold;

vectors.TP = (assumed_anomaly == 1) & (has_anomaly == 1);
vectors.TN = (assumed_anomaly == 0) & (has_anomaly == 0);
vectors.FP = (assumed_anomaly == 1) & (has_anomaly == 0);
vectors.FN = (assumed_anomaly == 0) & (has_anomaly == 1);

N = size(anomaly,1);

statistic.TP = sum(vectors.TP);
statistic.TN = sum(vectors.TN);
statistic.FP = sum(vectors.FP);
statistic.FN = sum(vectors.FN);
statistic.tresh_hold = tresh_hold;

end