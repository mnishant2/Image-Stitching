function drawCircles(keyPoints)
numberKeyPoints = size(keyPoints,1);
for i = 1:numberKeyPoints
%     if keyPoints(i, 1)>=1024 || keyPoints(i, 2)>=1024
%         disp(keyPoints(i));
%     end
    % Center, i.e., KeyPoint Location.
    center = [keyPoints(i, 1)-3, keyPoints(i, 2)-3];
    radius=2^(keyPoints(i, 3)-1);
    if (keyPoints(i, 3) == 2)
        viscircles(center, radius,'Color','b','LineWidth',1);
    elseif (keyPoints(i, 3) == 3)
        viscircles(center,radius,'Color','g','LineWidth',1); 
    elseif (keyPoints(i, 3) == 4)
        viscircles(center, radius,'Color','y','LineWidth',1); 
    elseif (keyPoints(i, 3) == 5)
        viscircles(center, radius,'Color','r','LineWidth',1);    
    end
end