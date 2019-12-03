function [histogram,siftFeatures]= getSiftFeatures(gp,keyPoints,windowSize,bins)
n_points=size(keyPoints,1);
siftFeatures=zeros(n_points,bins+3);
histogram=zeros(n_points,bins);
for i= 1:size(keyPoints,1)
    weightedHist=zeros(1,bins);
    histbins=[1:bins];
    keypoint=keyPoints(i,:);
    [patch,gx,gy,gM,gO,gWM]=getGradients(gp,keypoint,windowSize);
    
    for k= 1:numel(gO)
        angle=gO(k);
        if angle>=0
            ind=floor(angle/10);
            weightedHist(ind+1)=weightedHist(ind+1)+gWM(k);
        elseif angle==-180
            ind=floor((180-angle)/10);
            weightedHist(ind)=weightedHist(ind)+gWM(k);
        else
            ind=floor((180-angle)/10);
            weightedHist(ind+1)=weightedHist(ind+1)+gWM(k);
        end
    end
    histogram(i,:)=weightedHist;
    [~,ma]=max(weightedHist);
    weightedHist1=circshift(weightedHist,1-ma);
    siftFeatures(i,:)=[keypoint weightedHist1];
end
end

    
    
    
    
