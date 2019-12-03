% Subtracts 2 Images and returns the "Difference" Image.
function imageSub = subtractImages(I1, I2)

% Size of the original images.
sz = size(I1);
% disp(sz);

% Iterate over the images.
for x = 1:sz(1)
    for y = 1:sz(2)
        % Subtract the itensity values of both Images.
        imageSub(x, y) = abs(I1(x, y) - I2(x, y)); 
    end
end