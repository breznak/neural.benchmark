# Synthetic data
Artificial datasets designed to evaluate performance for atomic anomaly categories.

Contents: sine, a spike train and a constant function.

## Subfolders
- `clean` – an ideal training set, anomaly free.
- `anomaly*` - a set of data that were made from clean data by corrupting. For example: in points, in sections or noise was added. For more info browse in the subfolder.
 - `Point` - a change in signle point occured, point-anomaly.
 - `Section` - a whole (short) continuous section of the dataset has a changed characteristic.
