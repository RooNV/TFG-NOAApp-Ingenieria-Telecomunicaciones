%% RESAMPLE DE LA SEÑAL DE AUDIO

function [y_resampled, Fs_resampled, t_resampled] = resample_audio(y, Fs)
% Rational Factor 
    Fs_resampled = 11025;
    [L,M] = rat(Fs_resampled/Fs);
    
% Lowpass filter with Kaiser window
    f_cutOff = Fs/2;
    f = f_cutOff*min(1/L,1/M);
    d = designfilt('lowpassfir', ...
        'PassbandFrequency',0.9*f,'StopbandFrequency',1.1*f, ...
        'PassbandRipple',2,'StopbandAttenuation',50, ...
        'DesignMethod','kaiserwin','SampleRate',Fs);
    h = L*20*tf(d);

%     Filtrado and resample
    y_resampled = upfirdn(y,h,L,M);
    t_resampled = (0:(length(y_resampled)-1))/Fs;
end