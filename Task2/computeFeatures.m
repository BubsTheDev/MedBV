function [result] = computeFeatures( image )
%% result ... n_features x n_pixels matrix
% Zeilen: features:
%   Zeile 1 ... Grauwerte der Pixel
%   Zeile 2 ... Gradienten
%   Zeile 3 ... Gradientenstärke
%   Zeilen 4-23 ... Haar Like Features Grauwertbild // Zeile 4 wenn 1 Feat
%   Zeile 24-43 ... Haar Like Features Gradientenstärke // Zeile 5
%   Zeile 44 ... x Koordinaten // Zeile 6
%   Zeile 45 ... y Koordinaten // Zeile 7
% Spalten: Pixel, reihenweise aus Matrix zusammengefügt

nfeat = 47; %45 if all Haar Like features
npix = size(image,1) * size(image,2);

pixels = reshape(image,1,[]); 
pixels = pixels'; % matrix now vector (1. row + 2. row + ... + n. row)
greyscaleimg = mat2gray(image);
result = zeros(nfeat,npix);

result(1,:) = mat2gray(pixels); % grauwerte
[Gmag, Gdir] = imgradient(image');
[Gx,Gy] = imgradientxy(image');
gx = reshape(Gx',1,[]);
gy = reshape(Gy',1,[]);
%gradients = reshape(Gdir',1,[]);
gradmag = reshape(Gmag',1,[]);
result(2,:) = gx; %gradienten x
result(3,:) = gy; %gradienten y
result(4,:) = gradmag; %stärke des gradienten
haarlike = computeHaarLike(greyscaleimg);
result(5:24,:) = haarlike; %haar like features (grauwertbild)
%result(4,:) = haarlike(1,:);
haarlike = computeHaarLike(Gmag');
result(25:44,:) = haarlike; %haar like features (gradientenstärke)
%result(5,:) = haarlike(1,:);

% x Koordinaten d. pixels
width = size(image,1);
height = size(image,2);
j=1;
for i=1:height 
   result(45,j:j+width) = i; 
   j=j+width;
end
result = result(:,1:npix);

% y Koordinaten d. pixels
j=1;
for i=1:npix
   result(46,i) = j;
   j = j+1;
   if(j==width+1)
       j=1;
   end
end

end

