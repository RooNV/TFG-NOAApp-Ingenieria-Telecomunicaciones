% Dicha función aumenta el constrate de la imagen en blanco y negro recibida del
% satelite NOAA.
function img_contraste = contraste(img);

    if nargin > 1
      error('Wrong number of arguments.');
    end
    
%     Histograma ecualizado
%     imhist(img) 
    
%     img_contraste = histeq(img);
%     img_contraste = imadjust(img, [0.3 0.7], []);
    img_contraste = imadjust(img);
    
%     Histograma ecualizado
%     imhist(img_contraste)

end
