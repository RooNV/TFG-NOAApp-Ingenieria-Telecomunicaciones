% Dicha función recogerá la línea de muestra para sincronizarse al canal A 
% y al canal B de la imagen APT.
% Una línea contiene 2080 píxeles y dura 0.5 segundos. Por tanto, cada
% píxel dura 1/4160 segundos.

function [syncA, syncB, syncT] = canales();

    if nargin > 1
      error('Wrong number of arguments.');
    end
    
    % Muestra del Canal A de sincronización
    syncA = [1 1 0 0 1 1 0 0 1 1 0 0 1 1 0 0 1 1 0 0 1 1 0 0 1 1 ...
        0 0 0 0 0 0 0 0 0 0] - 0.5;
    % Muestra del Canal B de sincronización
    syncB = [1 1 1 0 0 1 1 1 0 0 1 1 1 0 0 1 1 1 0 0 1 1 1 0 0 1 ...
        1 0 0 1 1 1 0 0 0 0] - 0.5;

    % Muestra del Canal A trama
    syncT = [0 0 0 0 1 1 0 0 1 1 0 0 1 1 0 0 1 1 0 0 1 1 0 0 1 1 0 0 1 1 ...
        0 0 0 0 0 0 0 0 0 0, 1 1 1 1 1 1 1 1 1 1] - 0.5;
     
end