function data = addNoise(data, amplitude, ~)
% data = addNoise(data, power)
% amplitude should be around 1 if low noise needed

    N = size(data,1);
    noise = wgn(N,1,-25);
    noise(abs(noise) < 0.01) = 0;
    data(:,2) = data(:,2) + noise*amplitude;
    
    data(noise ~= 0, 4) = 1;

end

