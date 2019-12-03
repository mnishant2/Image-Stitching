function drawCircles1(keyPoints)
numberKeyPoints = size(keyPoints,1);
for i = 1:numberKeyPoints
%     if keyPoints(i, 1)>=1024 || keyPoints(i, 2)>=1024
%         disp(keyPoints(i));
%     end
    % Center, i.e., KeyPoint Location.
    center = [keyPoints(i, 1), keyPoints(i, 2)];
    radius=keyPoints(i, 3);

    if 3>round(keyPoints(i, 3)) && round(keyPoints(i, 3))>=0

        viscircles(center, radius,'Color','b','LineWidth',1);
    elseif 6>round(keyPoints(i, 3)) && round(keyPoints(i, 3))>=3
        viscircles(center,radius,'Color','g','LineWidth',1); 
    elseif 12>round(keyPoints(i, 3)) && round(keyPoints(i, 3))>= 6
        viscircles(center, radius,'Color','y','LineWidth',1); 
    elseif round(keyPoints(i, 3))>12
        viscircles(center, radius,'Color','r','LineWidth',1);    
    end
end