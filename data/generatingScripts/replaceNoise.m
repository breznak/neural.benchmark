function data = replaceNoise(data, amplitude, ~)
%% generate noise (white gaussian) and replace the data with it
% data = replaceNoise(data, power)
% amplitude should be around 1 if low noise needed
% TODO: should amplitude be a percentage? (of mean/std,...)

    N = size(data,1);
    noise = wgn(N,1,-25);
    data(:,2) = noise*amplitude;
    data(noise ~= 0, 4) = 1; %TODO: improvement, rather than a matrix, use cell {} and name the fields: data.signal, data.period, ...

end

