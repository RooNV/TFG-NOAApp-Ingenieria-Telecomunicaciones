%% SINCRONIZACIÓN DE LA IMAGEN: POR TRAMA

function [img_sinc] = sinc_trama(matriz_rs);
    [syncA, syncB, syncT] = canales(); % Muestra del Canal A y Canal B de sincronización
    sz = size(matriz_rs);
    frame_width = sz(:,2);
    frame_hight = sz(:,1); 

    j = 1;
    img_sinc = ones(frame_hight, frame_width);
    for i=1:1:frame_hight-1
        % Correlar con la primera parte de la imagen
        y_peaksT = matriz_rs(i,1:2080);
        [cT, lagsT] = xcorr(y_peaksT, syncT);
        [maxT, peakT] = max(cT);
        
        % Máximos en la correlción
        if maxT >= 4
            trama(j) = i;
            j = j + 1;
        end
    
        % Correlación línea por línea
        y_peaks = matriz_rs(i,:);
        [c, lags] = xcorr(y_peaks, syncA);
        [maxP(i), peak] = max(c);
        peaks(i) = peak - frame_width -1;
    end
    
    % Resample de 1 de cada 2
    j = 1;
    for i=1:2:length(trama)
           trama_rs(j) = trama(i);
           j = j + 1;
    end
    
    % Función: sincronización por media o moda de la trama
    for i = 1:1:length(trama_rs)-1
%        media = round(mean(peaks(trama_rs(i):trama_rs(i+1))));
%        media = round(mode(peaks(trama_rs(i):trama_rs(i+1))));
       pesos = maxP(trama_rs(i):trama_rs(i+1));
       pesos = pesos/sum(pesos);
       valores = peaks(trama_rs(i):trama_rs(i+1));
       media = 0;
       for k=1:1:length(pesos)
           media = media + pesos(i)*valores(i);
       end
       
       if i == 1
            inicio = 1;
            final = trama_rs(1);
       else
           inicio = trama_rs(i-1);
           final = trama_rs(i);
       end
       
       % Nuevo desplazamiento: igual para cada trama
       for k=inicio:1:final
           peaks(k) = round(media);
       end
    end
    
    % Representación con la sincronización
    for i=1:1:frame_hight-1
       k = 1;
        for j=1:1:frame_width
            px = peaks(i) + j;
            if px <= 0
                px = 1;
            end
            if px < frame_width
                img_sinc(i,j) = matriz_rs(i, px);
            else
                img_sinc(i,j) = matriz_rs(i+1, k);
                k = k + 1;
            end
        end
    end
end