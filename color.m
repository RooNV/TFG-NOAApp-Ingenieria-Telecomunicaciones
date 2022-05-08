% Dicha función transfroma la imagen en blanco y negro recibida del
% satelite NOAA, a una imagen RGB

function flow = color(img, nubes, flora, agua);

    if nargin > 4
      error('Wrong number of arguments.');
    end
    
%     falso_color_agua = 37;
%     falso_color_veg = 69;
%     falso_color_nubes = 81;

    falso_color_agua = agua;
    falso_color_veg = flora;
    falso_color_nubes = nubes;
    
    sz = size(img);
    frame_width = sz(:,2)/2
    frame_hight = sz(:,1)-1
    
    img_der = img(:,frame_width:end);
    
    for i=1:1:frame_hight
        for j=1:1:frame_width
            if img(i,j) < falso_color_agua 
%               Identifica el agua de la imagen 
                red(i,j) = 22.0 + img(i,j) * 0.4;
                green(i,j) = 23.0 + img(i,j) * 1.0;
                blue(i,j) = 38.0 + img(i,j) * 0.75;
            elseif img_der(i,j) > falso_color_nubes
%               Identifica las nubes de la imagen. 
%               Tambien puede captar la nieve o el hielo
                red(i,j) = (img_der(i,j) + img(i,j)) * 0.5; 
                green(i,j) = red(i,j);
                blue(i,j) = red(i,j);
            elseif img(i,j) < falso_color_veg
%               Identifica la vegetación de la imagen
                red(i,j) = 0.5 + img(i,j) * 0.89;
                green(i,j) = 11 + img(i,j) * 0.9;
                blue(i,j) = 0.5 + img(i,j) * 0.79;
            elseif img(i,j) <= falso_color_nubes
%               Identifica la tierra/desierto de la imagen
                red(i,j) = 1+img(i,j) * 0.93;
                green(i,j) = 0.6 + img(i,j) * 0.92;
                blue(i,j) = 0.6 + img(i,j) * 0.69;
            else
%               Captura los datos no identificados anterioremente
                red(i,j) = img(i,j);
                green(i,j) = img(i,j);
                blue(i,j) = img(i,j);
            end
        end
    end

    flow(:,:,1) = round(red);
    flow(:,:,2) = round(green);
    flow(:,:,3) = round(blue);
    flow = imadjust(flow, stretchlim(flow));
end


