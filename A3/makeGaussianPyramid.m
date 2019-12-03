function gaussianPyramid=makeGaussianPyramid(I,N)
% gaussianPyramid=[];
for i=0:N-1
    sigma=2^i;

    g=imgaussfilt(I,sigma);
    g=imresize(g,2^(-1*i));
 
    gaussianPyramid{i+1}=g;
end
    
    
