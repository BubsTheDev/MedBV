function [ result ] = generateShape( b, eigenVec, meanVec, r, s, x, y)
% Generates shapes.
% Part of Task 5a
%
% INPUT:
% b      ... parameter vector with length = number of eigenvectors
% r      ... rotation
% s      ... scale
% x,y    ... translation
% result ... generated shape

translation = [1,0,x;0,1,y;0,0,1];
rotation = [cosd(r),-sind(r),0;sind(r),cosd(r),0; 0,0,1];
scale = [s,0,0;0,s,0;0,0,1];

result = meanVec + eigenVec * b;

x = result(1:2:end);
y = result(2:2:end);
w = ones(length(x),1);

res = [x y w];

% S * R * T
transformation = scale * rotation * translation

res = transformation * res';
result = zeros(length(res) * 2, 1);
result(1:2:end) = res(1,:);
result(2:2:end) = res(2,:);
%result = res';
end