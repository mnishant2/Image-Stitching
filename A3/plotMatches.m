function plotMatches(matchPoints1,matchPoints2,img1,img2)
% matchedPoints21=matchedPoints2;
matchPoints2(:,1)=matchPoints2(:,1)+size(img1,2);
radii=ones(size(matchPoints1,1),1);
% keyPoints2(:,1)=keyPoints2(:,1)+size(cropimg2,2);
figure(20);
imgfinal=[img1,img2];
% montage([cropimg1,cropimg2]);
imshow(imgfinal);
hold on;
viscircles(matchPoints1,radii,'color','g');
scatter(matchPoints2(:,1),matchPoints2(:,2),radii.*20,'g','+');
line([matchPoints1(:,1),matchPoints2(:,1)]',[matchPoints1(:,2),matchPoints2(:,2)]','LineWidth',0.5, 'Color',[0 1 0]);
title("Matched Features");
hold off;
pause;
close all;