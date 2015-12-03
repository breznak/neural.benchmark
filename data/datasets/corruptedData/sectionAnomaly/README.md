# Corrupted data - section anomaly

This is applied in two steps.

1) First, we add anomaly for 50 periods.
2) We maintain anomaly silence for 100 periods.

Since we are aware of the fact that anomaly is deterministically created, we don't want the detection algorithm to learn what the anomaly looks like. Therefore we apply this process. It also gives as an advantage of knowing whether the algorithm is dealing the neat data well. 
