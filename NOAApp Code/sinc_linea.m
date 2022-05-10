%% SINCRONIZACIÓN DE LA IMAGEN: POR LÍNEA


function [img_sinc] = sinc_linea(matriz_rs);
    [syncA, syncB, syncT] = canales(); % Muestra del Canal A y Canal B de sincronización
    sz = size(matriz_rs);
    frame_width = sz(:,2);
    frame_hight = sz(:,1); %Para eliminar filas inferiores con ruido -258

    peaksA = zeros(frame_hight);
    img_sinc = ones(frame_hight, frame_width);
    
    for i=1:1:frame_hight-1
        % Correlación
        y_peaks = matriz_rs(i,:);
        [cA, lagsA] = xcorr(y_peaks, syncA);
        [maxA, peakA] = max(cA);
        
%         maximo de la correlacion
        peaksA(i) = peakA - frame_width + 3;
        
%         img_sinc es la nueva imagen
% introduzco todos los valores a partir del máximo de sincronización 
% hasta que se acaba la línea. Cogemos los valores de la siguiente 
% línea hasta llegar al límite de 2080 pixeles (el else)

        k = 1;
        for j=1:1:frame_width
            px = peaksA(i) + j;
            if px <= 0
                px = 1;
            end
            if px <= frame_width
                img_sinc(i,j) = matriz_rs(i, px);
            else
                img_sinc(i,j) = matriz_rs(i+1, k);
                k = k + 1;
            end
        end
    end
end