%load given datasets,vertical or horizontal
folder1='assign3Datasets\horizontal\';
format='.png';
givenimg=loadImages(folder1,format,0,0);
%load my datasets,vertical or horizontal
folder2='myDatasets\horizontal\';
format2='.jpg';
myimg=loadImages(folder2,format2,1,1);
%take two images for Q1 and Q2
rgb1=givenimg{2};
rgb2=givenimg{3};
image1 = single(rgb2gray(givenimg{2}));
image2 = single(rgb2gray(givenimg{3}));

%compute sift keypoints using provided implementation
[keypoints1,features1] = sift(image1,'Levels',4,'PeakThresh',5);
[keypoints2,features2] = sift(image2,'Levels',4,'PeakThresh',5);
%q1 visualize features for both cases
size(features1)
subplot(1,2,1)
imshow(rgb1);hold on;
size(keypoints1)
keypoints1(1:2,:);
drawCircles1(keypoints1');

% get sift features using assignment 2 implementation and display
gp=makeGaussianPyramid(image1,7);
lp=makeLaplacianPyramid(gp);
keyPoints=findKeyPoints(lp,5,1);
numberKeyPoints = size(keyPoints);
numberKeyPoints = numberKeyPoints(1);
disp(numberKeyPoints);
[histogram,siftFeatures]= getSiftFeatures(gp,keyPoints,17,36);
subplot(1,2,2)
imshow(rgb1);
hold on;
drawCircles(keyPoints);
hold off;
pause;
close all;
%visualize histograms for two matching keypoints in a 5*5 roi
points=[804, 190.7;461,348];
visualizehist(points,features1',128,keypoints1');
visualizehist(points,siftFeatures(:,4:end),36,keyPoints);

% Q2 find matches, use 1 as the last argument of findMatches for using bhattacharya
% distance or 0 to use matchFeatures
features1=double(features1);
features2=double(features2);
[indexPairs,matchmetric]=findMatches(features1',features2',0);
matchedPoints1 = keypoints1(1:2,indexPairs(:,1))';
matchedPoints2 = keypoints2(1:2,indexPairs(:,2))';
plotMatches(matchedPoints1,matchedPoints2,rgb1,rgb2);

%Q3 COMPUTE HOMOGRAPHY USING RANSAC, it plots feature matches before and
%after RANSAC 500 iterations
[homography,consensusSet]=ransacHomography(matchedPoints1,matchedPoints2,500,0.5,4);
newmatches1=matchedPoints1(consensusSet,:);
newmatches2=matchedPoints2(consensusSet,:);
plotMatches(newmatches1,newmatches2,rgb1,rgb2);
%images to pass for stitching
myimages=myimg(1:end);
givenimages=givenimg(1:3);
% Q4 running image stitching on given data
panorama=stitchImage(myimages);
% Q4 running image stitching on my own data
panorama=stitchImage(givenimages);
