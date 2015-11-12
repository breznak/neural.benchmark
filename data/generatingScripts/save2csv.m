function save2csv(data, filename)
    fid = fopen(sprintf('../datasets/%s',filename), 'w');
    % Header
    fprintf(fid, 'time,function,fazeState,anomaly\n');
    fprintf(fid, 'float,float,int,bool\n');
    fprintf(fid, ',,,\n');
    
    %data
    fprintf(fid, '%4.4f,%12.8f,%d,%d\n', data');
    
    fclose(fid);

end