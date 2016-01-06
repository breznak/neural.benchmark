function [data, stat, stat_vec] = SHOWRESULTS(filename, tresh_hold, plotting)
%IMPORTFILE Import numeric data from a text file as column vectors.
%   [TIMESTAMP,FUNCTION2,PHASE2,HAS_ANOMALY1,ANOMALY_SCORE1,ANOMALY_LIKELIHOOD1]
%   = IMPORTFILE(FILENAME) Reads data from text file FILENAME for the
%   default selection.
%
%   [TIMESTAMP,FUNCTION2,PHASE2,HAS_ANOMALY1,ANOMALY_SCORE1,ANOMALY_LIKELIHOOD1]
%   = IMPORTFILE(FILENAME, STARTROW, ENDROW) Reads data from rows STARTROW
%   through ENDROW of text file FILENAME.
%
% Example:
%   [timestamp,function2,phase2,has_anomaly1,anomaly_score1,anomaly_likelihood1]
%   = importfile('sinePointPhaseChangeSet_niceratio_10minute.csv',2,
%   36001);
%
%    See also TEXTSCAN.


%% Initialize variables.
delimiter = ',';
if nargin < 2
    tresh_hold = 0.5;
end
startRow = 2;
endRow = inf;

[pathstr,name,~] = fileparts(filename);

if nargin < 3
    plotting = 1;
end

%% Format string for each line of text:
%   column1: double (%f)
%	column2: double (%f)
%   column3: double (%f)
%	column4: double (%f)
%   column5: double (%f)
%	column6: double (%f)
% For more information, see the TEXTSCAN documentation.
formatSpec = '%f%f%f%f%f%f%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to format string.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, endRow(1)-startRow(1)+1, 'Delimiter', delimiter, 'EmptyValue' ,NaN,'HeaderLines', startRow(1)-1, 'ReturnOnError', false);
for block=2:length(startRow)
    frewind(fileID);
    dataArrayBlock = textscan(fileID, formatSpec, endRow(block)-startRow(block)+1, 'Delimiter', delimiter, 'EmptyValue' ,NaN,'HeaderLines', startRow(block)-1, 'ReturnOnError', false);
    for col=1:length(dataArray)
        dataArray{col} = [dataArray{col};dataArrayBlock{col}];
    end
end

%% Close the text file.
fclose(fileID);

%% Allocate imported array to column variable names
timestamp = dataArray{:, 1};
func = dataArray{:, 2};
func_phase = dataArray{:, 3};
has_anomaly = dataArray{:, 4};
anomaly_score = dataArray{:, 5};
anomaly_likelihood = dataArray{:, 6};

data = [timestamp, func, func_phase, has_anomaly, anomaly_score, anomaly_likelihood];

%% Plot results
if plotting
    fig = figure;
    [~, a2, ~, timestamp] = plotResults(timestamp, func, anomaly_score, anomaly_likelihood, has_anomaly, name);
end
%% Compute statistics
[stat, stat_vec] = evaluateResults(anomaly_score, has_anomaly, tresh_hold);

if plotting
    % tresh hold line
    plot(a2, [0, max(timestamp)], [tresh_hold tresh_hold], '--k');

    % info subplot
    a4 = subplot('Position', [0, 0.01, 1, 0.18]);
        set(a4, 'Visible', 'off');

        % Anotation
        str = ['Tresh hold: %4.2f \n' ...
           'Samples: %d\n'];
        stat_info = sprintf(str, stat.tresh_hold, stat.size);
        text(0.13, 1, stat_info, 'Parent', a4, 'FontSize', 12);

        % Positives and Negatives
        str = ['False negatives: %d\n' 'True negatives: %d\n' ...
               'False postives: %d\n' 'True positives: %d\n'];
        stat_info = sprintf(str, stat.FN, stat.TN, stat.FP, stat.TP);
        text(0.4, 0.9, stat_info, 'Parent', a4, 'FontSize', 12);

        % Statistics
        str = ['Precision: %4.2f\n' 'Recall: %4.2f\n' ...
               'F: %4.2f \n' 'Accuracy: %4.2f'];
        stat_info = sprintf(str, stat.precision, stat.recall, stat.F, stat.accuracy);
        text(0.75, 1, stat_info, 'Parent', a4, 'FontSize', 12);
end    
        
%% Save the statistics and the plot
if plotting
    saveStats(stat, strcat(pathstr, name, '.txt'));
    saveas(fig, strcat(name, '.png'));
    saveas(fig, name, 'epsc');
    savefig(fig, strcat(name, '.fig'));
end

end
