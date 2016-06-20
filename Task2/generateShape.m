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

result = meanVec + eigenVec * b;

end