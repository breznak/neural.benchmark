function [data, stat, stat_vec] = SHOWRESULTS(filename)
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

% Auto-generated by MATLAB on 2015/12/11 17:07:30

%% Initialize variables.
delimiter = ',';
tresh_hold = 0.5;
startRow = 2;
endRow = inf;


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

%% Post processing for unimportable data.
% No unimportable data rules were applied during the import, so no post
% processing code is included. To generate code which works for
% unimportable data, select unimportable cells in a file and regenerate the
% script.

%% Allocate imported array to column variable names
timestamp = dataArray{:, 1};
func = dataArray{:, 2};
func_phase = dataArray{:, 3};
has_anomaly = dataArray{:, 4};
anomaly_score = dataArray{:, 5};
anomaly_likelihood = dataArray{:, 6};


data = [timestamp, func, func_phase, has_anomaly, anomaly_score, anomaly_likelihood];
%% Plot results, compute statistics, save them
plotResults(timestamp, func, anomaly_score, anomaly_likelihood, has_anomaly);
[stat, stat_vec] = evaluateResults(anomaly_score, has_anomaly, tresh_hold);
saveStats(stat, strcat(pathstr, name, '.txt'));

end
