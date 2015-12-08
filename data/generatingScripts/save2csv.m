function save2csv(data, filename)
    %IF NEEDED, CHANGE THE PATH HERE.
    name = sprintf('../datasets/%s',filename);
    
    [pathstr,~,~] = fileparts(name);
    
    if exist(pathstr, 'dir') == 0
        mkdir(pathstr);
    end
        
    fid = fopen(name, 'w');
    % Header
    fprintf(fid, 'timestamp,function,phase,has_anomaly\n');
    fprintf(fid, 'float,float,int,bool\n');
    fprintf(fid, ',,,\n');
    
    %data
    fprintf(fid, '%4.4f,%12.8f,%d,%d\n', data');
    
    fclose(fid);

end