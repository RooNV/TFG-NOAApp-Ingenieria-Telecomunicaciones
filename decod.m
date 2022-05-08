 %% Decodificador de la señal wav

function img = decoder(file_name)
    %% SEÑAL DE AUDIO 
    file = file_name;
    
    True_Fs = 11025;
    [y,Fs] = audioread(file);
    info = audioinfo(file);
    
    if info.SampleRate ~= True_Fs
        [y_resampled, Fs_resampled, t_resampled] = resample_audio(y,Fs);
    else
        y_resampled = y;
        Fs_resampled = Fs;
        t_resampled = 0:seconds(1/Fs):seconds(info.Duration);
    end
    audiowrite('NewAudioFile.wav',y_resampled,Fs_resampled);
    
    [y,Fs] = audioread('NewAudioFile.wav');
    
    %% IMAGEN COMPLETA APT sin sincronización
    y_h = abs(hilbert(y));
    frame_width = round(0.5*Fs);
    frame_hight = fix(length(y_h)/frame_width);

    i = 1;
    for py=1:1:frame_hight
        for px=1:1:frame_width
            matriz(py,px) = y_h(i);
            i = i + 1;
        end
    end
    
    %% Resample
    sz = size(matriz);
    xg = 1:sz(1);
    yg = 1:sz(2);
    F = griddedInterpolant({xg,yg},double(matriz));

    rs = length(yg)/2080;
    xq = xg;
    yq = (0:rs:sz(2))';
    yq = yq(2:end,1);
    matriz_rs = double(F({xq,yq}));

    %% Iámgen sin sicnronizar, tamaño 2080x1674
%     figure()
%     imshow(matriz_rs)
%     imwrite(matriz_rs, 'Imagen_completa.jpg')

    %% Sincronización, diferentes métodos:
    img = sinc_linea(matriz_rs);
%     img = sinc_trama(matriz_rs);
%     img = sinc_unico(matriz_rs);
   
%     img = sin_telemetria(img);

% Mejora de la imagen con el filtrado wiener
    img = wiener2(img, [3 3]); 
    img = im2uint8(img);
%     figure()
%     imshow(img)
%     imwrite(img, 'Imagen_Con_Sincro.jpg')
end








