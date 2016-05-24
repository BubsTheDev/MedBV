function [ result ] = generateShape( b, eigenVec, meanVec)
% Generates shapes.
%   b ... parameter vector with length = number of eigenvectors
%   result ...

result = meanVec + eigenVec * b;


end

