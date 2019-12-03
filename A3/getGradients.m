function [patch,gx,gy,gM,gO,gWM]=getGradients(gp,keypoint,windowSize)

img=imresize(gp{keypoint(3)},2^(keypoint(3)-1));
% img=im2double(img);
[gradX,gradY]=imgradientxy(img);
[grad, orientation]=imgradient(img);
% grad=sqrt(gradX.^2+gradY.^2);
% orientation=atan2(gradY,gradX);
gradX=padarray(gradX,[floor(windowSize / 2),floor(windowSize / 2)],0,'both');
gradY=padarray(gradY,[floor(windowSize / 2),floor(windowSize / 2)],0,'both');
grad=padarray(grad,[floor(windowSize / 2),floor(windowSize / 2)],0,'both');
orientation=padarray(orientation,[floor(windowSize / 2),floor(windowSize / 2)],0,'both');
rmin=(keypoint(2));
rmax=(rmin+windowSize-1);
cmin=(keypoint(1));
cmax=(cmin+windowSize-1);
sigma=(windowSize-1)/4;
h = fspecial('gaussian',windowSize,sigma);
gM=grad(rmin:rmax,cmin:cmax);
gx=gradX(rmin:rmax,cmin:cmax);
gy=gradY(rmin:rmax,cmin:cmax);
img=padarray(img,[floor(windowSize / 2),floor(windowSize / 2)],0,'both');
patch=img(rmin:rmax,cmin:cmax);
gO=orientation(rmin:rmax,cmin:cmax);

gWM=gM.*h;
