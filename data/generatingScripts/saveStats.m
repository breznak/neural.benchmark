function saveStats(statistic, directory)

    [pathstr,name,~] = fileparts(directory);
    
    if exist(pathstr, 'dir') == 0 && isempty(pathstr) == 0
        mkdir(pathstr);
    end
        
    fid = fopen(directory, 'w');
    % Header
    fprintf(fid, 'Statistic of data %s \n\n', name);
    fprintf(fid, 'Tresh hold: %2.4f\n', statistic.tresh_hold);
    %data
    fprintf(fid, 'False negatives: %d\n', statistic.FN');
    fprintf(fid, 'True negatives: %d\n', statistic.TN');
    fprintf(fid, 'False positives: %d\n', statistic.FP');
    fprintf(fid, 'True positives: %d\n', statistic.TP');
    
    fclose(fid);

end