function visualizehist(pts,features,bins,keypoints)
display = 1;
bins = 1:1:bins;
win=10;
for j=1:2
    for i = 1:size(keypoints,1)
        if (keypoints(i, 1) >= pts(j,1)-win) && (keypoints(i, 1) <= pts(j,1)+win) && (keypoints(i, 2) <= pts(j,2)+win) && (keypoints(i, 2) >= pts(j,2)-win)
            disp(keypoints(i,:));
            
            figure(i + 102);
            title('Feature Histograms');
            bar(bins, features(i, :), 0.8);
            pause;
            close all;
        end
    end
end
