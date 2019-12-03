% Finds the Extremas in Space and in Scale for a given Images' Laplacian Pyramid with N Levels.
function keyPoints = findKeyPoints(lp, nsize, threshold)

% Key-Points.
keyPoints = [];
% Number of Key-Points.
% Ni = 0;
[z,N]=size(lp);
% Iterate over the N-Scale Spaces.
for k = 2 : (N - 1)
    % Extract the Image at Scale Level k.
    I = lp{k};
    % Extract the Image at Scale Level (k - 1) and downsample.
    Iup = lp{k - 1};
    Iup = imresize(Iup, 0.5);
    % Extract the Image at Scale Level (k + 1) and upsample.
    Idown = lp{k + 1};
    Idown = imresize(Idown, 2);
%     sz = size(I);
    % Iterate over the Image.
%     % For a Kernel Size of hsize * hsize.
    I=padarray(I,[floor(nsize / 2),floor(nsize / 2)],0,'both');
    Iup=padarray(Iup,[floor(nsize / 2),floor(nsize / 2)],0,'both');
    Idown=padarray(Idown,[floor(nsize / 2),floor(nsize / 2)],0,'both');
    sz = size(I);
    for i = (floor(nsize / 2) + 1) : (sz(1) - 2*floor(nsize / 2))
        for j = (floor(nsize / 2) + 1):(sz(2) - 2*floor(nsize / 2))
            % Find Extrema in Space.
            % Search for Extrema in a Local Neighbourhood.
            localI=I(i-floor(nsize / 2):i+floor(nsize / 2),j-floor(nsize / 2):j+floor(nsize / 2));
            localIup=Iup(i-floor(nsize / 2):i+floor(nsize / 2),j-floor(nsize / 2):j+floor(nsize / 2));
            localIdown=Idown(i-floor(nsize / 2):i+floor(nsize / 2),j-floor(nsize / 2):j+floor(nsize / 2));
            
            values= [localI(:); localIup(:); localIdown(:)]; 
%             disp(size(values));
            sortedvalues=sort(values);
%             [sortedvalues(1) sortedvalues(end)]
            if (sortedvalues(1)==I(i,j) && abs(sortedvalues(1)-sortedvalues(2))>=threshold) || ...
                    (sortedvalues(end)==I(i,j) && abs(sortedvalues(end)-sortedvalues(end-1))>=threshold)
                scale=2^(k-1);
                keyPoints=[keyPoints;[j * scale,i * scale,k]];
            end
        end
    end
end
end
