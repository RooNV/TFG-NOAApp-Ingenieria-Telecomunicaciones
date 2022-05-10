%% SINCRONIZACIÓN DE LA IMAGEN: único valor de sincronización

function [img_sinc] = sinc_trama(matriz_rs);
    [syncA, syncB, syncT] = canales(); % Muestra del Canal A y Canal B de sincronización
    sz = size(matriz_rs);
    frame_width = sz(:,2);
    frame_hight = sz(:,1); 

    img_sinc = ones(frame_hight, frame_width);
    for i=1:1:frame_hight-1
        % Correlación línea por línea
        y_peaks = matriz_rs(i,:);
        [c, lags] = xcorr(y_peaks, syncA);
        [maxP, peak] = max(c);
        peaks(i) = peak - frame_width -1;
    end

    media = round(mean(peaks(200:1474)))
    for k=1:1:length(peaks)
       peaks(k) = media;
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