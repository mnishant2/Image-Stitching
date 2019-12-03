function normalizedfeatures= normalizeHist(siftVectors)
for i=1:size(siftVectors,1)
    siftVectors(i,:)=siftVectors(i,:)./double(sum(siftVectors(i,:)));
    normalizedfeatures=siftVectors;
end
end