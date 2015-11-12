1) Generate data using generating function. Keep in mind that Sampling
Theorem (fs >= 2 * f) must be followed, otherwise the data would be corrupted. 
    
    Example: 
        % generating
        data = constant(10, 10, 10);
        % creating anomaly
        data = amplModulGauss(data, 10);
        
2) Save the data into csv file which will be generated in the datasets folder.
        
    Example: 
        save2csv(data, 'constant.csv')
        
        