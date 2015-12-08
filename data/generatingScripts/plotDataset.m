function plotDataset(data, name)
    time = data(:,1);
    func = data(:,2);
    fazeState = data(:,3);
    anomaly = data(:,4);
    
    if nargin < 2
        name = 'Function f(x)';
    end
    
  
    a1 = subplot(3,1,1);
        plot(time, func, 'b'); hold on
        plot(time(anomaly==1), func(anomaly==1), 'r.');
    a2 = subplot(3,1,2);      
        plot(time,  fazeState, '--r');
    
    a3 = subplot(3,1,3);
        plot(time, anomaly, 'o');
    
    title(a1, name);
    xlabel(a1, 'Time [s]');
    ylabel(a1, 'Function [-]');
    
    title(a2, strcat(name, ' - faze state'));
    xlabel(a2, 'Time [s]');
    ylabel(a2, 'Phase [-]');
    title(a3, strcat(name, ' - Anomaly'));
    xlabel(a3, 'Time [s]');
    ylabel(a3, 'Anomaly (1/0)');
    linkaxes([a1,a2,a3],'x');

end