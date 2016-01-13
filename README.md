# Machine Learming benchmarks

Aiming to thouroughly benchmark and compare ML algorithms (with current focus on HTM), be designing specialized synthetic datasets that stress a single feature and can be well evaluated and understood. 

For users being able to decide where each algorithm has its strong/weak-spots and decide in application for real-world problems. 

This can also work as a benchmark to evaluate development impact in changes to the algorithms. 

![Zoom of anomaly results on data loss benchmark.](https://raw.githubusercontent.com/breznak/neural.benchmark/doc_goals/data/datasets/synthetic/anomalySection/dataLoss/results/zoom_results.png)

## Goals of this project

This repository should be a collection of
* datasets
 * real-world
 * synthetic
* papers
* algorithm implementations
 * (initially) focus on HTM from [NuPIC](https://github.com/numenta/nupic), gladly include any other algorithms/results.
* results
 * as CSV, image, ...
* collection of ideas in the Issues

### Current state

- [x] Anomalies classified in independent, significant categories -> [anomaly categorization](https://github.com/breznak/neural.benchmark/issues/2)
- [x] create synthetic benchmars/datasets for the anomaly categories:
 - [x] point anomalies
 - [x] interval/section anomalies
 - [x] "higher" trend (low freq. modulation) anomalies
 - [ ] [additional](https://github.com/breznak/neural.benchmark/labels/dataset)
- [x] HTM benchmars on the above datasets
 - [ ] Discussion of the results & suggested improvements
 - [ ] Comparison with other well known ML approaches

### Research interest

The topics of research interest are classified in Issue's labels, and are related to: [NuPIC](https://github.com/breznak/neural.benchmark/labels/nupic), [dataset creation](https://github.com/breznak/neural.benchmark/labels/dataset), [novel research ideas](https://github.com/breznak/neural.benchmark/labels/research), [cognitive modeling](https://github.com/breznak/neural.benchmark/labels/cognitive), and so on...


## How do I use/work with this repo?

* You can browse CSV and images in `data/datasets/*/results/` folders.
* To modify or regenerate new datasets, go to `datasets/generatingScripts/MAIN.m`, you'll need Matlab/R for that.
* To rerun (HTM/NuPIC) models, `python opf/anomaly_benchmark.py` NuPIC has to be installed.
* For visualizing data, use `plotResutls/plotDatasets.m` or interactive tool [nupic.visualizations](https://github.com/nupic-community/nupic.visualizations), which can be run [online](https://nupic-visualizations.firebaseapp.com/)


## Results

* Evaluation results on benchmarks are located in `results/` subfolders under respective paths and presented in form of CSV and image data. 
* See Hypotheses for ongoing results. 
* Ideas & findings from our work:
 - [x] Importance of noise/"non-integer f/fs sampling problem" for ease of learning and quality of abstraction in (artificial) benchmarks.
 - [x] NuPIC: `AdaptiveScalar` encoder is NOT suitable for streaming data, use `RDSE` instead. 
  - [x] How to compute `optimal resulution` for RDSE
 - [x] NuPIC: `Boosting` implementation is causing artificial disturbances in the predictions (and can be improved, or should be turned off)
 - NuPIC:
  - [x] good on `point` anomaly
  - [x] good on `interval` anomaly

### Open-research & hypothesis 

Warning: anything here may, or may not be true. It is under evaluation. We are raising the topics here to get your focus on the current issues and possible findings. 

- [ ] NuPIC: `AnomalyLikelihood` implementation is inferior to the "raw" `Anomaly`, esp. with combination of noisy data that distort the internal distribution model. 
- [ ] Impact of parameter optimization (`swarming`) on NuPIC's performance
- [ ] NuPIC: failing to abstract on `trend` data?

## Sources

1.	Hierarchical Temporal Memory, Numenta. Available at: http://numenta.org/resources/HTM_CorticalLearningAlgorithms.pdf

2.	Hawkins, Jeff (2004). On Intelligence, Times Books. ISBN 0805074562.

3.	Uhl, Christian (1999). Analysis of Neurophysiological Brain Functioning, Springer. ISBN 978-3-642-64219-7

4.	The Sicence of Anomaly Detection, Numenta. Available at: http://numenta.com/assets/pdf/whitepapers/Numenta%20White%20Paper%20-%20Science%20of%20Anomaly%20Detection.pdf

5.	Schmidhuber, Jürgen (2014). Deep Learning in Neural Networks: An Overview, The Swiss AI Lab IDSIA. Available at: http://arxiv.org/pdf/1404.7828v4.pdf

6.	Twitter, Anomaly Detection. Available at: https://blog.twitter.com/2015/introducing-practical-and-robust-anomaly-detection-in-a-time-series

7.	Skyline, Anomaly Detection. Available at: https://github.com/etsy/skyline

8.	Yahoo, Time Series Anomaly Detection. Available at: http://yahoolabs.tumblr.com/post/114590420346/a-benchmark-dataset-for-time-series-anomaly

### Related sources

* [Numenta Anomaly Benchmark/NAB](https://github.com/numenta/NAB) is a collection of streaming, real-time, real-world datasets and benchmarks.



## Acknowledgement

