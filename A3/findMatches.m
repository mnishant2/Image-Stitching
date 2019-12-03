function [indexPairs,matchmetric]= findMatches(features1,features2,matchType)
if matchType==0
    [indexPairs,matchmetric] = matchFeatures(features1,features2);
else
    indexPairs=[];
    matchmetric=[];
    threshold=0.15;
%     size(festures1)
    
    normalizedsiftVectors1=normalizeHist(features1);
    normalizedsiftVectors2=normalizeHist(features2);
    
%     localArea=150;
    for i =1:size(normalizedsiftVectors1,1)
%         maxVal=-5;
%         bestMatch=0;
        for j=1:size(normalizedsiftVectors2,1)
%             if abs(keyPoints2(j,1)-keyPoints1(i,1))<=floor(localArea/2) && abs(keyPoints2(j,2)-keyPoints1(i,2))<=floor(localArea/2)
            corr=bhattacharya(normalizedsiftVectors1(i,:),normalizedsiftVectors2(j,:));
            if corr<=threshold
                indexPairs=[indexPairs;[i,j]];
                matchmetric=[matchmetric; corr];
            end
        end
    end
end
end
%         end
% 
% %             if corr>=maxVal
% %                 maxVal=corr;
% %                 bestMatch=j;
% %             end
%         end
%         end
% %         if maxVal>=threshold
% %             matchOutput(i,1)=bestMatch;
% %             matchOutput(i,2)=maxVal;
% %         end
%     end
%     keyPoints2(:,1)=keyPoints2(:,1)+size(cropimg2,2);
%     figure(20);
%     imgfinal=[cropimg1,cropimg2];
%     % montage([cropimg1,cropimg2]);
%     imshow(imgfinal);
%     hold on;
% 
%     drawCircles(keyPoints1);
%     drawCircles(keyPoints2);
%     drawLines(keyPoints1,keyPoints2,matchOutput);
%     title("Matched Features");
%     annotation('textbox',[.60 .8 .3 .2],'String','Press any key to continue','EdgeColor','none')
%     hold off;
%     pause;
%     close all;
            
        