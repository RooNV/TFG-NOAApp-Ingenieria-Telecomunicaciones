%% FILTRADO DE LA SEÑAL DE AUDIO


function [y_filt] = filtro(y, fs)
    
    FT = fft(y);
    plot(length(FT), FT);
    
    y_filt = lowpass(y,fs/2,fs)
end