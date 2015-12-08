## General datasets creation

1) Run MAIN.m

2) Check, whether files were created in the folder datasets.

## Single data
1) Generate data using generating function. Keep in mind that the sampling
theorem (fs >= 2 * f) must be followed, otherwise the data would be corrupted. Also, consider if the fs/f ratio should be a real or a natural number.
    
    Example: 
        % generating
        data = constant(10, 10, 10);
        % creating anomaly
        dataAnomaly = amplModulGauss(data, 10);
        
2) Save the data into csv file which will be generated in the datasets folder.
        
    Example: 
        save2csv(data, 'constant.csv')
        
        