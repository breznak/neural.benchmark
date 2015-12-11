%% This script creates anomaly datasets.
% Author:       Michal Najman
%               Czech Technical University in Prague
% Semester:     autumn 2015
% Supervisor:   Ing. Marek Otahal

%% First, we have to set general values.
clc; clear; close all
samplesPerSecond = 30; % 1/s

% We change this for a tiny bit because we want the ratino fs/f to be far
% from a natural number - to avoid simple repetitive sequence of (say 30)
% numbers instead of (all) function values. 
% See https://github.com/breznak/ML.benchmark/issues/12 for more details.
functionsFrequency = 1.001; % 1/s

% % Change the dataset times (length) and names here:
% datasetLength = 60*60; % 1 hour ~ 108 000 samples
% % File names suffix
% suffix = '_1hour.csv';
% functionsFrequency = 1.001; % 1/s

% datasetLength = 60*10; % 10 minute
% % File names suffix
% suffix = '_niceratio_10minute.csv';
% functionsFrequency = 1; % 1/s

datasetLength = 60*10; % 10 minute
% File names suffix
suffix = '_10minute.csv';
functionsFrequency = 1.001; % 1/s

% Note that in neat data all values are within the interval from -1 to 1. 
amplitude = 1; % units unspecified

% Will be useful later when naming csv files.
vname=@(x) inputname(1);

% setup the 3 main functions (sine, constant, spike-train), useful in other
% sections
constantSet = constant(amplitude, samplesPerSecond, datasetLength);
spikeTrainSet = spikeTrain(amplitude, functionsFrequency, samplesPerSecond, datasetLength);
sineSet = sine(amplitude, 2*pi*functionsFrequency, samplesPerSecond, datasetLength);

%% 1. Generate simple neat data

path = 'synthetic/clean/';

% Constant
constantSet = constant(amplitude, samplesPerSecond, datasetLength);
save2csv(constantSet, strcat(path, vname(constantSet), suffix));

% Spike train
spikeTrainSet = spikeTrain(amplitude, functionsFrequency, samplesPerSecond, datasetLength);
save2csv(spikeTrainSet, strcat(path, vname(spikeTrainSet), suffix));

% Sine 
sineSet = sine(amplitude, 2*pi*functionsFrequency, samplesPerSecond, datasetLength);
save2csv(sineSet, strcat(path, vname(sineSet), suffix));

% %plots
% plotDataset(constantSet, 'data - const');
% plotDataset(spikeTrainSet, 'data - spiketrain');
% plotDataset(sineSet, 'data - sine');

%% 2. Generate corrupted data - Point anomaly in amplitude
% Here, the density of an anomaly is considered as probability p that an anomaly
% would occur in a sample. The general density, say in a period, has
% bionomial distribution with a parameter p. Since it is computationally
% costly to work with bionomial distribution, we decided to use a
% probability of a single error instead.

% Now, we are going to corrupt the datasets and create point anomalies in amplitude.
path = 'synthetic/anomalyPoint/amplitude/';

% Corrupted constant - we will increase randomly an amplitude of the constant function for 20 % with density 0.05. 
constantPointAnomalyHighDensitySet = pointAnomalyRandom(constantSet, 0.05, .2*amplitude, 1);
save2csv(constantPointAnomalyHighDensitySet, strcat(path, vname(constantPointAnomalyHighDensitySet), suffix));

% Corrupted constant - same parameters, but density 0.001. 
constantPointAnomalyLowDensitySet = pointAnomalyRandom(constantSet, 0.0005, .2*amplitude, 1);
save2csv(constantPointAnomalyLowDensitySet, strcat(path, vname(constantPointAnomalyLowDensitySet), suffix));

% Corrupted spike train - same parameters, but density 0.1. 
spikeTrainPointAnomalySet = pointAnomalyRandom(spikeTrainSet, 0.1, .2*amplitude, 1);
save2csv(spikeTrainPointAnomalySet, strcat(path, vname(spikeTrainPointAnomalySet), suffix));

% Corruptes sine - same parameters, but density 0.2. 
sinePointAnomalySet = pointAnomalyRandom(sineSet, 0.1, .1*amplitude);
save2csv(sinePointAnomalySet, strcat(path, vname(sinePointAnomalySet), suffix));

% %plots
% plotDataset(constantPointAnomalyHighDensitySet, 'data - const');
% plotDataset(constantPointAnomalyLowDensitySet, 'data - const');
% plotDataset(spikeTrainPointAnomalySet, 'data - spiketrain');
% plotDataset(sinePointAnomalySet, 'data - sine');

%% 3. Generate corrupted data - Point anomaly in phase

path = 'synthetic/anomalyPoint/phase/';

% We shift phase for 'pi' in randomly chosen four
% consecutive samples with probability p = 0.7.

% Constant function. It is not possible work with phase here.

% Spike train. Does not make sense to create point anomaly in the spike
% train set because it would not be observable since the data set is only
% either zeros or a spike. We we leave this one out for the section
% anomaly.

% Point anomaly in phase for sine function.
sinePointPhaseChangeSet = changePhase(sineSet, 0.07, samplesPerSecond, functionsFrequency);
save2csv(sinePointPhaseChangeSet, strcat(path, vname(sinePointPhaseChangeSet), suffix));

% %plot
% plotDataset(sinePointPhaseChangeSet, 'data - const');


%% 4. Generate corrupted data - Section anomaly in amplitude
% Now, we are going to corrupt the datasets and create anomalies in whole sections.
path = 'synthetic/anomalySection/amplitude/';

% First third of data is anomaly free. Then, each
% 3*'numOfPeriodsUnderAnomaly' periods: first 'numOfPeriodsUnderAnomaly'
% periods are corrupted by gaussian amplitide increase followed by two
% lengths in samples of unanomalied data. Then repeated.
numOfPeriodsUnderAnomaly = 50;

% Gaussian amplitude increase in a constant function. 
constantGaussianAmplitudeIncreaseSet = anomalyPeriodically(constantSet,@amplModulGauss,numOfPeriodsUnderAnomaly,1,samplesPerSecond,functionsFrequency);
fileName = strcat(path, vname(constantGaussianAmplitudeIncreaseSet), '_', num2str(numOfPeriodsUnderAnomaly), 'periods', suffix);
save2csv(constantGaussianAmplitudeIncreaseSet, fileName);

% Gaussian amplitide increase in  spike train. Same parameters, but zeros are
% excluded. 
spikeTrainGaussianAmplitudeIncreaseSet = anomalyPeriodically(spikeTrainSet,@amplModulGauss,numOfPeriodsUnderAnomaly,1,samplesPerSecond,functionsFrequency, 1);
fileName = strcat(path, vname(spikeTrainGaussianAmplitudeIncreaseSet), '_', num2str(numOfPeriodsUnderAnomaly), 'periods', suffix);
save2csv(spikeTrainGaussianAmplitudeIncreaseSet, fileName);

% Gaussian amplitide increase in sine. Same parameters, zeros included
sineGaussianAmplitudeIncreaseSet = anomalyPeriodically(sineSet,@amplModulGauss,numOfPeriodsUnderAnomaly,1,samplesPerSecond,functionsFrequency, 1);
fileName = strcat(path, vname(sineGaussianAmplitudeIncreaseSet), '_', num2str(numOfPeriodsUnderAnomaly), 'periods', suffix);
save2csv(sineGaussianAmplitudeIncreaseSet, fileName);

% %plots
% plotDataset(constantGaussianAmplitudeIncreaseSet, 'data - const');
% plotDataset(spikeTrainGaussianAmplitudeIncreaseSet, 'data - spiketrain');
% plotDataset(sineGaussianAmplitudeIncreaseSet, 'data - sine');


%% 5. Generate corrupted data - Section anomaly in phase
% !!! TODO !!! hmm :) What should corrupted data be?
% path = 'synthetic/anomalySection/phase/';

% Spike train

% Sine

% !!! TODO END !!!

%% 6. Generate corrupted data - Noisy data
% TODO What is the Noisy data?
path = 'synthetic/anomalySection/noise/';

% Now, we will add noise data periodically. It follows the same pattern as
% in the previous case: 50 periods are noisy, 100 are anomaly free.
numOfPeriodsUnderAnomaly = 50;
NOISE_AMPL = 1; % small noise

% Noisy constant
constantNoisySet = anomalyPeriodically(constantSet,@addNoise,numOfPeriodsUnderAnomaly, NOISE_AMPL,samplesPerSecond,functionsFrequency);
fileName = strcat(path, vname(constantNoisySet), '_', num2str(numOfPeriodsUnderAnomaly), 'periods', suffix);
save2csv(constantNoisySet, fileName);

% Noisy spike train
spikeTrainNoisySet = anomalyPeriodically(spikeTrainSet,@addNoise,numOfPeriodsUnderAnomaly, NOISE_AMPL,samplesPerSecond,functionsFrequency, 1);
fileName = strcat(path, vname(spikeTrainNoisySet), '_', num2str(numOfPeriodsUnderAnomaly), 'periods', suffix);
save2csv(spikeTrainNoisySet, fileName);

% Noisy sine
sineNoisySet = anomalyPeriodically(sineSet,@addNoise,numOfPeriodsUnderAnomaly, NOISE_AMPL,samplesPerSecond,functionsFrequency, 1);
fileName = strcat(path, vname(sineNoisySet), '_', num2str(numOfPeriodsUnderAnomaly), 'periods', suffix);
save2csv(sineNoisySet, fileName);

% More noisy sine
NOISE_AMPL = 1.2; % bigger noise
sineNoisySet2 = anomalyPeriodically(sineSet,@addNoise,numOfPeriodsUnderAnomaly, NOISE_AMPL,samplesPerSecond,functionsFrequency, 1);
fileName = strcat(path, vname(sineNoisySet2), '_', num2str(numOfPeriodsUnderAnomaly), 'periods', suffix);
save2csv(sineNoisySet2, fileName);

% %plots
% plotDataset(constantNoisySet, 'data - const');
% plotDataset(spikeTrainNoisySet, 'data - spiketrain');
% plotDataset(sineNoisySet, 'data - sine');
% plotDataset(sineNoisySet2, 'data - sine - bigger noise');


%% 7. Generate corrupted data - Data loss
path = 'synthetic/anomalySection/dataLoss/';

% Here, we simulate data corrupted by robust noise.  In this case, an
% alghoritm should be able to create a robust model that is able to
% overcome losses in data. This can be thought of as a situation in which
% sensors produce nonsense data from time to time, eg. temperature measurement,
% velocity measured by differentiating position and so on. Instead of
% aplying a low-pass filter which is not always aplicable, we rely on an
% alghoritm's properties. 

% First, we create an anomaly vector with probability 0.004 which roughly
% stands for a probability of an anomaly in three consecutive samples.
% An anomaly vector is a vector which encapsulates positions (logical one)
% in which there shoudl be an anomaly occuring.

NOISE_AMPL = 1.2;

% Constant with robust noise
anomalyVector = generateAnomalyVector(constantSet, 0.004);
constantDataLossSet = applyAnomalyVector(constantSet, anomalyVector, @replaceNoise, NOISE_AMPL);
fileName = strcat(path, vname(constantDataLossSet), suffix);
save2csv(constantDataLossSet, fileName);

% Spike with robust noise
anomalyVector = generateAnomalyVector(spikeTrainSet, 0.08);
spikeTrainDataLossSet = applyAnomalyVector(spikeTrainSet, anomalyVector, @replaceNoise, NOISE_AMPL, 1);
fileName = strcat(path, vname(spikeTrainDataLossSet), suffix);
save2csv(spikeTrainDataLossSet, fileName);

% Sine robust noise
anomalyVector = generateAnomalyVector(sineSet, 0.02);
sineDataLossSet = applyAnomalyVector(sineSet, anomalyVector, @replaceNoise, NOISE_AMPL, 1);
fileName = strcat(path, vname(sineDataLossSet), suffix); %TODO create fn save(path, data) and combine the 2
save2csv(sineDataLossSet, fileName); % -||-

% Sine robust noise - frequent (10% noise)
anomalyVector = generateAnomalyVector(sineSet, 0.1); %from 0.02
sineDataLossSetHf = applyAnomalyVector(sineSet, anomalyVector, @replaceNoise, NOISE_AMPL, 1);
fileName = strcat(path, vname(sineDataLossSetHf), suffix); %TODO create fn save(path, data) and combine the 2
save2csv(sineDataLossSetHf, fileName); % -||-

%plots
plotDataset(constantDataLossSet, 'data - const');
plotDataset(spikeTrainDataLossSet, 'data - spiketrain');
plotDataset(sineDataLossSet, 'data - sine');
plotDataset(sineDataLossSetHf, 'data - sine Hf');
%figure; plot(sineDataLossSet(:,2));


%% 8. Anomalies on Scale/zoom - low Hz function modulation
% A mediator function fM is modulated by "message", a function fL (lowHz)
% These conditions apply:
% freq. fM >> fL
% amplitude Fm << fL
% Expectations:
% locality vs globality, scaling/zoom/sampling problem, ...
% on a local scale, the function would always look as fM
% on a "correct" scale (what the human would see) we can recognize fL. 
% When frequencis of fM and fL become rather similar, the "message" is lost
% and the fL is undistinguishible. 
% For this task, even the "clean" data will be rather difficult! 
% See images for better understanding. 

%%%%%%%%%%
% 8.1 sine on a sigmoid
% train data - clean
path = 'synthetic/clean/';
fM = sine(amplitude, 2*pi*functionsFrequency, samplesPerSecond, datasetLength);
fL = tanh(-2.7:0.0003:2.7); % sigmoid = signal = long-term trend/change
fL = fL(1:end-1)'; % make same sizewith fM
signal = fM(:,2);
modulated = fL+signal;
%plot(modulated)
fM(:,2) = modulated;

% save
fileName = strcat(path, 'trendSineOnSigmoid', suffix);
save2csv(fM, fileName);

% anomaly with add noise
path = 'synthetic/anomalyTrend/';
anom = anomalyPeriodically(fM, @addNoise,numOfPeriodsUnderAnomaly, NOISE_AMPL,samplesPerSecond,functionsFrequency, 1);
%plot(anom)
fileName = strcat(path, 'testSineOnSigmoid-anomNoisy', suffix);
save2csv(fM, fileName);

% %plot
% plotDataset(fM, 'data - trend sine+sigmoid');

%%%%%%%%%
% 8.1.2 sine on a sigmoid BIG
% train data - clean
path = 'synthetic/clean/';
fM = sine(amplitude, 2*pi*functionsFrequency, samplesPerSecond, datasetLength);
fL = 10*tanh(-2.7:0.0003:2.7); % sigmoid = signal = long-term trend/change
fL = fL(1:end-1)'; % make same sizewith fM
signal = fM(:,2);
modulated = fL+signal;
plot(modulated)
fM(:,2) = modulated;

% save
fileName = strcat(path, 'trendSineOnSigmoidBig', suffix);
save2csv(fM, fileName);

% anomaly with add noise
path = 'synthetic/anomalyTrend/';
anom = anomalyPeriodically(fM, @addNoise,numOfPeriodsUnderAnomaly, NOISE_AMPL,samplesPerSecond,functionsFrequency, 1);
%figure;plot(anom)
fileName = strcat(path, 'testSineOnSigmoidBig-anomNoisy', suffix);
save2csv(fM, fileName);


% %plot
% plotDataset(fM, 'data - trend sine+sigmoid');

%%%%%%%%
% 8.2 sine on a sine

% train data - clean
path = 'synthetic/clean/';
fM = sine(amplitude, 2*pi*functionsFrequency, samplesPerSecond, datasetLength);
fL = sine(10*amplitude, 2*pi*functionsFrequency/100, samplesPerSecond, datasetLength); % = signal = long-term trend/change
fL = fL(:,2); % make same sizewith fM
signal = fM(:,2);
modulated = fL+signal;
%figure;plot(modulated)
fM(:,2) = modulated;

% save
fileName = strcat(path, 'trendSineOnSine', suffix);
save2csv(fM, fileName);

% anomaly with add noise
path = 'synthetic/anomalyTrend/';
anom = anomalyPeriodically(fM, @addNoise,numOfPeriodsUnderAnomaly, NOISE_AMPL,samplesPerSecond,functionsFrequency, 1);
%figure;plot(anom)
fileName = strcat(path, 'testSineOnSine-anomNoisy', suffix);
save2csv(fM, fileName);

% %plot
% plotDataset(fM, 'data - trend sine+sigmoid');

%%%%%%%%%%%%%
% 8.3 fn-noise cycle
% We periodically repeate function and noise cycles. 
%
% Expectations:
% (later) the model should abstract that the noise (even though random) is
% a part of the patter. And produce there low anomaly scores! 
% This is where likelihood anomaly should work better. 

nS = sineSet; % start with a sine (set)
anom = anomalyPeriodically(nS, @replaceNoise, 10, 10, samplesPerSecond,functionsFrequency, 1);
path = 'synthetic/anomalyTrend/';
%figure;plot(anom(:,2))
fileName = strcat(path, 'trainNoiseFnCycle', suffix);
save2csv(anom, fileName);

