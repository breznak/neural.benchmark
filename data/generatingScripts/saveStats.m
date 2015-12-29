function saveStats(statistic, directory)

    [pathstr,name,~] = fileparts(directory);
    
    if exist(pathstr, 'dir') == 0 && isempty(pathstr) == 0
        mkdir(pathstr);
    end
        
    fid = fopen(directory, 'w');
    % Header
    fprintf(fid, 'Statistics of the data %s \n\n', name);
    fprintf(fid, 'Tresh hold: %2.4f\n', statistic.tresh_hold);
    fprintf(fid, 'Number of samples: %d\n\n', statistic.size);
    %data
    fprintf(fid, 'False negatives: %d\n', statistic.FN');
    fprintf(fid, 'True negatives: %d\n', statistic.TN');
    fprintf(fid, 'False positives: %d\n', statistic.FP');
    fprintf(fid, 'True positives: %d\n\n', statistic.TP');
    
    %statistic
    fprintf(fid, 'Precision: %2.4f\n', statistic.precision');
    fprintf(fid, 'F: %2.4f\n', statistic.F');
    fprintf(fid, 'Recall: %2.4f\n', statistic.recall');
    fprintf(fid, 'Accuracy: %2.4f\n', statistic.accuracy');
    fclose(fid);

end