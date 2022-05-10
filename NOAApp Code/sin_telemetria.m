%% CORTAR LA TELEMETRÍA DE LA IMAGEN


function [img_sin_tel] = sin_telemetria(imagen)
    sz = size(imagen);
    frame_hight = sz(:,1); 
    
    
    imagen = im2double(imagen);
    
    img_sin_tel = ones(frame_hight,1818);
    for i=1:1:frame_hight-1
        img_sin_tel(i, 1:909) = imagen(i, 79:987);
        img_sin_tel(i, 910:1818) = imagen(i, 1119:2027);
    end
end