function panorama=stitchImage(images)
I = images{1};
gray=single(rgb2gray(I));
% Initialize features for I(1)

[keypoints,features] = sift(gray,'Levels',4,'PeakThresh',5);


numImages = numel(images);
tforms(numImages) = projective2d(eye(3));

% Initialize variable to hold image sizes.
imageSize = zeros(numImages,2);

% Iterate over remaining image pairs
for n = 2:numImages
    
    % Store points and features for I(n-1).
    keypointsPrevious = keypoints;
    featuresPrevious = features;
        
    % Read I(n).
    I = images{n};
    gray=single(rgb2gray(I));
    
    % Save image size.
    imageSize(n,:) = size(gray);
    
   
    [keypoints,features] = sift(gray,'Levels',4,'PeakThresh',5);
  
    % Find correspondences between I(n) and I(n-1).
    [indexPairs,matchmetric]=findMatches(features',featuresPrevious',0);
       
    matchedPoints = keypoints(1:2,indexPairs(:,1))';
    matchedPointsPrev = keypointsPrevious(1:2,indexPairs(:,2))';
    plotMatches(matchedPointsPrev,matchedPoints,images{n-1},images{n});
    [homography,consensusSet]=ransacHomography(matchedPoints,matchedPointsPrev,500,0.5,4);
    tforms(n)=homography;
    newmatches1=matchedPoints(consensusSet,:);
    newmatches2=matchedPointsPrev(consensusSet,:);
    plotMatches(newmatches2,newmatches1,images{n-1},images{n});

    % Compute T(n) * T(n-1) * ... * T(1)
    tforms(n).T = tforms(n).T * tforms(n-1).T;
end
for i = 1:numel(tforms)           
    [xlim(i,:), ylim(i,:)] = outputLimits(tforms(i), [1 imageSize(i,2)], [1 imageSize(i,1)]);    
end
avgXLim = mean(xlim, 2);

[~, idx] = sort(avgXLim);

centerIdx = floor((numel(tforms)+1)/2);

centerImageIdx = idx(centerIdx);
Tinv = invert(tforms(centerImageIdx));

for i = 1:numel(tforms)    
    tforms(i).T = tforms(i).T * Tinv.T;
end
for i = 1:numel(tforms)           
    [xlim(i,:), ylim(i,:)] = outputLimits(tforms(i), [1 imageSize(i,2)], [1 imageSize(i,1)]);
end

maxImageSize = max(imageSize);

% Find the minimum and maximum output limits 
xMin = min([1; xlim(:)]);
xMax = max([maxImageSize(2); xlim(:)]);

yMin = min([1; ylim(:)]);
yMax = max([maxImageSize(1); ylim(:)]);

% Width and height of panorama.
width  = round(xMax - xMin);
height = round(yMax - yMin);

% Initialize the "empty" panorama.
panorama = zeros([height width 3], 'like', I);
blender = vision.AlphaBlender('Operation', 'Binary mask', ...
    'MaskSource', 'Input port');  

% Create a 2-D spatial reference object defining the size of the panorama.
xLimits = [xMin xMax];
yLimits = [yMin yMax];
panoramaView = imref2d([height width], xLimits, yLimits);

% Create the panorama.
for i = 1:numImages
    
    I = images{i};   
%     I=single(rgb2gray(I));
    % Transform I into the panorama.
    warpedImage = imwarp(I, tforms(i), 'OutputView', panoramaView);
                  
    % Generate a binary mask.    
    mask = imwarp(true(size(I,1),size(I,2)), tforms(i), 'OutputView', panoramaView);
    
    % Overlay the warpedImage onto the panorama.
    panorama = step(blender, panorama, warpedImage, mask);
end

figure
panorama=uint8(panorama);
imshow(panorama)
pause;
close all;