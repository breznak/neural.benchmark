# Corrupted data - section anomaly

Unlike the point anomaly, in this category we focus on intervals where there is a lot of anomalies. 

Each interval is followed by an anomaly free interval. This is inteded to let the algorithm recognize the inserted anomaly and, consequently, to ensure that the algortihm will not learn hidden patterns in the anomaly when online learning is set on. 

Since we are aware of the fact that anomaly is deterministically created, we don't want the detection algorithm to learn what the anomaly looks like. In addition to that, it gives as an advantage of knowing whether the algorithm is dealing the neat data well at the same time. 

Look closely here:

![Example](./amplitude/_OVERVIEW.png) 

## How we insert the section anomaly?

As it was mentioned above, the section anomaly is, unlike the point anomaly, applied in two steps:
  
  1. First, we add anomaly for 50 periods.
  2. We maintain anomaly silence for 100 periods.


