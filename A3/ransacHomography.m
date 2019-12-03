function [homography,consensusSet]=ransacHomography(match1,match2,iterations,threshold,n)

consensusSet=[];
maxcset=0;
for i=1:iterations
    consensusSetTemp=[];
    randrows=randperm(size(match1,1));
%     randrows(1:n)
    randpoints1=match1(randrows(1:n),:);
    randpoints2=match2(randrows(1:n),:);
%     size(randpoints1)
    homography=getHomography(randpoints1,randpoints2);
    homography=homography./homography(3,3);
    homography=homography';
    
    for i=1:size(match1,1)
        projection=homography*[match1(i,:) 1]';
        projection=projection./projection(end);

        err=norm(projection(1:2)-match2(i,:)');
        if err<threshold
            consensusSetTemp=[consensusSetTemp i];
        end
    end
    if numel(consensusSetTemp)>maxcset
        maxcset=numel(consensusSetTemp);
        consensusSet=consensusSetTemp;
    end
end
ransacmatches1=match1(consensusSet,:);
ransacmatches2=match2(consensusSet,:);
homography=getHomography(ransacmatches1,ransacmatches2);
homography=homography./homography(3,3);
% homography=homography';
end
        
        
        
        
    
    
