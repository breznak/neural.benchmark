function [data] = anomalyPeriodically(data, funcHandler, numberOfPeriods, amplitude, fs, f, zeroExcluded) 
% data = anomalyPeriodically(data, funcHandler, numberOfPeriods, amplitude, fs, f [, zeroExcluded])
% funcHandler = function @(data, amplitude [, zeroExluded])

if nargin < 7
    zeroExcluded = 0;
end

% If numberOfPeriods = 10 then: We want funcHandler() to occur in 10 periods in a row. Then
% we want 20 periods break.
f = normalizeFrequency(fs, f);
T = 1/f;
samplesInCorruption = floor(T*numberOfPeriods*fs);



N = size(data,1);


L = floor(N /( 3 * samplesInCorruption)); %how many times we will serve. %FIXME what is the magic 3?

if L == 0
    return;
end

start = 1;



for i = 1:L
    data(start:start+samplesInCorruption, :) = funcHandler(data(start:start+samplesInCorruption, :), amplitude, zeroExcluded);
    start = start + 3 * samplesInCorruption;
end

