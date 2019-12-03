% Generates a Laplacian Pyramid with N-1 levels.
function lp = makeLaplacianPyramid(gp)

% Save the original Image.
% Iorig = I;
% imageGP = makeGaussianPyramid(I,N)
[z,N]=size(gp);
% For N-levels in the Laplacian Pyramid
for i = 1:(N - 1)
    scale = 2 ;
    I=gp{i};
    Idown=imresize(gp{i+1},scale);

    
%     lp{i}=imsubtract(I,Idown);
    lp{i}=subtractImages(I,Idown);

end 
end


