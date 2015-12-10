# Corrupted data - point anomaly in phase

An anomaly is added to an original clean data. In point anomalies we change the phaze in several (mostly four) consecutive samples for `pi`. This is aim to confuse the algorithm so that it quickly develops a false sense that the changed phase is the original anomaly free data. 

Here, in the point anomaly, only few consecutive samples are corrupted. Therefore, the algortihm should not lose the track what the original function was. 

![Example](./_OVERVIEW.png) 
![Example](./_EXAMPLE.png) 

## Parameters
- sampling frequency : 30 Hz
- functions frequency : 1.001 Hz (Why we do so is explained in data/README.md)
- functions frequency : if `neat`, then 1 Hz
- length : specified in a data file name
- anomaly : point anomaly
