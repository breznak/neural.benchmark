%% This script creates anomaly datasets.
% Author:       Michal Najman
%               Czech Technical University in Prague
% Semester:     autumn 2015
% Supervisor:   Ing. Marek Otahal

%% First, we have to set general values.
samplesPerSecond = 30; % 1/s

functionsFrequency = 1; % 1/s

datasetLength = 60*60; % 1 hour ~ 108 000 samples

% Note that in neat data all values are within the interval from -1 to 1. 
amplitude = 1; % units unspecified

% Will be useful later when naming csv files.
vname=@(x) inputname(1);

% File names suffix
suffix = '_1hour.csv';

%% 1. Generate simple neat data

path = 'neatData/synthetic/';

% Constant
constantSet = constant(amplitude, samplesPerSecond, datasetLength);
save2csv(constantSet, strcat(path, vname(constantSet), suffix));

% Spike train
spikeTrainSet = spikeTrain(amplitude, functionsFrequency, samplesPerSecond, datasetLength);
save2csv(spikeTrainSet, strcat(path, vname(spikeTrainSet), suffix));

% Sine 
sineSet = sine(amplitude, 2*pi*functionsFrequency, 0, samplesPerSecond, datasetLength);
save2csv(sineSet, strcat(path, vname(spikeTrainSet), suffix));

%% 2. Generate corrupted data - Point anomaly in amplitude
% Here, the density of an anomaly is considered as probability p that an anomaly
% would occur in a sample. The general density, say in a period, has
% bionomial distribution with a parameter p. Since it is computationally
% costly to work with bionomial distribution, we decided to use a
% probability of a single error instead.

% Now, we are going to corrupt the datasets and create point anomalies in amplitude.
path = 'corruptedData/pointAnomaly/amplitude/';

% Corrupted constant ? we will increase randomly an amplitude of the constant function for 20 % with density 0.05. 
constantPointAnomalyHighDensitySet = pointAnomalyRandom(constantSet, 0.05, .2*amplitude, 1);
save2csv(constantPointAnomalyHighDensitySet, strcat(path, vname(constantPointAnomalyHighDensitySet), suffix));

% Corrupted constant ? same parameters, but density 0.001. 
constantPointAnomalyLowDensitySet = pointAnomalyRandom(constantSet, 0.0005, .2*amplitude, 1);
save2csv(constantPointAnomalyLowDensitySet, strcat(path, vname(constantPointAnomalyLowDensitySet), suffix));

% Corrupted spike train ? same parameters, but density 0.1. 
spikeTrainPointAnomalySet = pointAnomalyRandom(spikeTrainSet, 0.1, .2*amplitude, 1);
save2csv(spikeTrainPointAnomalySet, strcat(path, vname(spikeTrainPointAnomalySet), suffix));

% Corruptes sine - same parameters, but density 0.2. 
sinePointAnomalySet = pointAnomalyRandom(sineSet, 0.2, .1*amplitude);
save2csv(sinePointAnomalySet, strcat(path, vname(sinePointAnomalySet), suffix));

%% 3. Generate corrupted data - Point anomaly in faze
!!! TODO !!!
% Now, we are going to corrupt the datasets and create anomalies in faze.
path = 'corruptedData/pointAnomaly/faze/';

% Spike train

% Sine

!!! TODO END !!!

%% 4. Generate corrupted data ? Section anomaly in amplitude
% Now, we are going to corrupt the datasets and create anomalies in whole sections.
path = 'corruptedData/sectionAnomaly/amplitude/';

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

%% 5. Generate corrupted data - Section anomaly in faze
!!! TODO !!!
path = 'corruptedData/sectionAnomaly/faze/';

% Spike train

% Sine

!!! TODO END !!!

%% 6. Generate corrupted data ? Noisy data

path = 'corruptedData/sectionAnomaly/noise/';

% Now, we will add noise data periodically. It follows the same pattern as
% previous case: 300 periods are noisy, 600 are anomaly free. However, the
% first third of samples is left unanomalied to let the alghoritm learn the
% pattern.
numOfPeriodsUnderAnomaly = 50;
% Noisy constant
constantNoisySet = anomalyPeriodically(constantSet,@addNoise,numOfPeriodsUnderAnomaly, 1,samplesPerSecond,functionsFrequency);
fileName = strcat(path, vname(constantNoisySet), '_', num2str(numOfPeriodsUnderAnomaly), 'periods', suffix);
save2csv(constantNoisySet, fileName);

% Noisy spike train
spikeTrainNoisySet = anomalyPeriodically(spikeTrainSet,@addNoise,numOfPeriodsUnderAnomaly, 1,samplesPerSecond,functionsFrequency, 1);
fileName = strcat(path, vname(spikeTrainNoisySet), '_', num2str(numOfPeriodsUnderAnomaly), 'periods', suffix);
save2csv(spikeTrainNoisySet, fileName);

% Noisy sine
sineNoisySet = anomalyPeriodically(sineSet,@addNoise,numOfPeriodsUnderAnomaly, 1,samplesPerSecond,functionsFrequency, 1);
fileName = strcat(path, vname(sineNoisySet), '_', num2str(numOfPeriodsUnderAnomaly), 'periods', suffix);
save2csv(sineNoisySet, fileName);

%% 7. Generate corrupted data - Robust noise

path = 'corruptedData/sectionAnomaly/robustness/';

% Here, we simulate data corrupted by robust noise.  In this case, an
% alghoritm should be able to create a robust model that is able to
% overcome losses in data. This can be thought of as a situation in which
% sensors produce nonsense data time to time, eg. temperature measurement,
% velocity measured by differentiating position and so on. Instead of
% aplying a low-pass filter which is not always aplicable, we rely on an
% alghoritm's properties.

% First, we create an anomaly vector with parametr 0.05 which roughly
% stands for probability of an anomaly in three consecutive samples.
% An anomaly vector is a vector which encapsulates positions (logical one)
% in which there shoudl be an anomaly occuring. However, we leave out the
% first third of samples so that an the alghoritm creates a model of the
% pattern.
anomalyVector = generateAnomalyVector(constantSet, 0.005);

% Constant with robust noise
constantRobustnessSet = applyAnomalyVector(constantSet, anomalyVector, @addNoise, 10);
fileName = strcat(path, vname(constantRobustnessSet), suffix);
save2csv(constantRobustnessSet, fileName);

% Spike train anomaly vector
anomalyVector = generateAnomalyVector(spikeTrainSet, 0.1);

% Spike with robust noise
spikeTrainRobustnessSet = applyAnomalyVector(spikeTrainSet, anomalyVector, @addNoise, 10, 1);
fileName = strcat(path, vname(spikeTrainRobustnessSet), suffix);
save2csv(spikeTrainRobustnessSet, fileName);


% Sine anomaly vector
anomalyVector = generateAnomalyVector(sineSet, 0.03);

% Sine robust noise
sineRobustnessSet = applyAnomalyVector(sineSet, anomalyVector, @addNoise, 10, 1);
fileName = strcat(path, vname(sineRobustnessSet), suffix);
save2csv(sineRobustnessSet, fileName);






















