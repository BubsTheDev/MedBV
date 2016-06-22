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

nfeat = 7; %45 if all Haar Like features
npix = size(image,1) * size(image,2);

pixels = reshape(image',1,[]); % matrix now vector (1. col + 2. col + ... + n. col)
greyscaleimg = mat2gray(image);
result = zeros(nfeat,npix);

result(1,:) = mat2gray(pixels); % grauwerte
[Gmag, Gdir] = imgradient(image);
gradients = reshape(Gdir',1,[]);
gradmag = reshape(Gmag',1,[]);
result(2,:) = gradients; %gradienten
result(3,:) = gradmag; %stärke des gradienten
haarlike = computeHaarLike(greyscaleimg);
%result(4:23,:) = haarlike; %haar like features (grauwertbild)
result(4,:) = haarlike(1,:);
haarlike = computeHaarLike(Gmag);
%result(24:43,:) = haarlike; %haar like features (gradientenstärke)
result(5,:) = haarlike(1,:);

% x Koordinaten d. pixels
j=1;
for i=1:size(image,1) 
   result(6,j:j+143) = i; %%44 is all Haar like features
   j=j+143;
end
result = result(:,1:npix);

% y Koordinaten d. pixels
j=1;
for i=1:npix
   result(7,i) = j; %45 if all Haar Like features
   j = j+1;
   if(j==144)
       j=1;
   end
end



imagesc(result);

end

