function newImage=transImg(image,x0,y0,theta,s)
[imageHeight, imageWidth] = size(image);
centerX = floor(imageWidth/2+1);
centerY = floor(imageHeight/2+1);
dy = centerY-y0;
dx = centerX-x0;
% How much would the "rotate around" point shift if the 
% image was rotated about the image center. 
[phi, rho] = cart2pol(-dx,dy);
[newX, newY] = pol2cart(phi+theta*(pi/180), rho);
shiftX = round(x0-(centerX+newX));
shiftY = round(y0-(centerY-newY));
% Pad the image to preserve the whole image during the rotation.
padX = abs(shiftX);
padY = abs(shiftY);
padded = padarray(image, [padY padX]);
% Rotate the image around the center.
rot = imrotate(padded, theta, 'crop');
% Crop the image.
output = rot(padY+1-shiftY:end-padY-shiftY, padX+1-shiftX:end-padX-shiftX, :);
newImage=imresize(output,s);
