%% This script creates anomaly datasets.
% Author:       Michal Najman
%               Czech Technical University in Prague
% Semester:     autumn 2015
% Supervisor:   Ing. Marek Otahal

%% First, we have to set general values.
samplesPerSecond = 30; % 1/s

functionsFrequency = 2; % 1/s

datasetLength = 60*60; % 1 hour ~ 108 000 samples

% Note that in neat data all values are within the interval from -1 to 1. 
amplitude = 1; % units unspecified

%% Generate simple neat data

path = '../neatData/synthetic/simple/';

% Constant
constantSet = constant(amplitude, samplesPerSecond, datasetLength);
save2csv(constantSet, strcat(path, 'constant_1hout.csv'));

% Spike train
spikeTrainSet = spikeTrain(amplitude, functionsFrequency, samplesPerSecond, datasetLength);
save2csv(spikeTrain, strcat(path, 'spikeTrain_1hour.csv'));

% Sine 
sineSet = sine(amplitude, 2*pi*functionsFrequency, 0, samplesPerSecond, datasetLength);
save2csv(sineSet, strcat(path, 'sine_1hour.csv'));

%% Generate random anomalies
% Probability of an anomaly occuring in one sample is p = 0.1

randomAnomalySinus = pointAnomalyRandom(sinus, 0.1, 1);

% Real probability in data however is different. :/