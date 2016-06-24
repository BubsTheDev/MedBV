function [result, labels] = computeFeatures( image, mask )
%% result ... n_features x n_pixels matrix
% Zeilen: features:
%   Zeile 1     ... Grauwerte der Pixel
%   Zeile 2     ... Gradienten X
%   Zeile 3     ... Gradienten Y
%   Zeile 4     ... Gradientenstärke
%   Zeilen 5-24 ... Haar Like Features Grauwertbild
%   Zeile 25-44 ... Haar Like Features Gradientenstärke 
%   Zeile 45    ... x Koordinaten
%   Zeile 46    ... y Koordinaten
% Spalten: Pixel, reihenweise aus Matrix zusammengefügt
labels = [];

if nargin > 1
    img = zeros(size(image,1),size(image,2));
    randImg = img;
    
    img(mask==10) = image(mask==10);
    I = find(img);
    [row, col, v] = find(img);
    
    randImg(mask==0) = image(mask==0);
    rI = find(randImg);
    [rRow,rCol,rV] = find(randImg);
    [~, idx] = datasample(rV, length(v), 'Replace', false);
    
    pixels = cat(1, v, rV(idx));
    x = cat(1, col, rCol(idx));
    y = cat(1, row, rRow(idx));
    I = cat(1, I, rI(idx));
    labels = mask(I);
else
    I = find(image);
    [y, x, pixels] = find(image);
end



[Gmag, ~] = imgradient(image); %stärke des gradienten
[Gx,Gy] = imgradientxy(image); %gradienten x und y
greyscaleimg = mat2gray(image);
haarlikeGrey = computeHaarLike(greyscaleimg); %haar like features (grauwertbild)
haarlikeStrength = computeHaarLike(Gmag); %haar like features (gradientenstärke)

result = zeros(46,length(pixels));
result(1,:) = mat2gray(pixels'); % grauwerte
result(2,:) = Gx(I);
result(3,:) = Gy(I);
result(4,:) = Gmag(I);
result(5:24,:) = haarlikeGrey(:,I);
result(25:44,:) = haarlikeStrength(:,I);
result(45,:) = x';
result(46,:) = y';

end