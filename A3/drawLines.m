function drawLines(keypoints1,keypoints2,matchOutput)
for i=1:size(matchOutput,1)
    if matchOutput(i,1)~=0
        j=matchOutput(i,1);
%         j
        corr=matchOutput(i,2)
        point1=[keypoints1(i,1), keypoints2(j,1)];
        point2=[keypoints1(i,2), keypoints2(j,2)];
        if corr>=0.95
            color=[1 1 0];
            width=1.5;
        elseif corr>= 0.9
            color=[1 0 0];
            width=1;
        else
            color=[0 1 1];
            width=0.5;
        end
        line(point1,point2,'LineWidth',width, 'Color',color);
    end
end
end