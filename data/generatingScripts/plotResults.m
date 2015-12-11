function plotResults(time, func, anomaly, anomaly_likelihood, has_anomaly, name)
    
    if nargin < 6
        name = 'Results for function f(x)';
    end
    
    % This is done in case time count was restarted after starting the
    % testing faze. However, we must be aware of the fact that we create a
    % rounding error here. 
    if (max(diff(time)) - (time(2) - time(1))) > 1e-8
        dt = median(diff(time));
        stopTime = size(time,1)*dt;
        time = time(1):dt:stopTime-dt;
    end
    
    a1 = subplot(3,1,1);
        plot(time, func, 'b'); hold on
        plot(time(has_anomaly==1), func(has_anomaly==1), 'r.');
        
    a2 = subplot(3,1,2);      
        plot(time,  anomaly, 'g'); hold on;
        plot(time, has_anomaly, 'o'); 
    
    a3 = subplot(3,1,3);
        plot(time, anomaly_likelihood, 'r');
    
    title(a1, name, 'FontSize', 14);
    xlabel(a1, 'Time [s]', 'FontSize', 12);
    ylabel(a1, 'Function [-]', 'FontSize', 12);

    title(a2, strcat(name, ' - Raw anomaly score'), 'FontSize', 14);
    xlabel(a2, 'Time [s]', 'FontSize', 12);
    ylabel(a2, 'Row anomaly [-]', 'FontSize', 12);

    title(a3, strcat(name, ' - Anomaly likelihood'), 'FontSize', 14);
    xlabel(a3, 'Time [s]', 'FontSize', 12);
    ylabel(a3, 'Anomaly likelihood [-]', 'FontSize', 12);
    
    linkaxes([a1,a2,a3],'x');

    set(a1, 'LineWidth', 3);
    set(a2, 'LineWidth', 3);
    set(a3, 'LineWidth', 3);

end