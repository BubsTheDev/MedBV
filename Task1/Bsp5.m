function Bsp5(shapes)
% INPUT:
% shapes ..... matrix containing data of different shapes, NxMxD

rows = size(shapes,1);
cols = size(shapes,2);
depth = size(shapes,3);

shapesConcat = zeros(rows * cols, depth);

for z = 1:depth
    shapesConcat(1:2:end,z) = shapes(:,1,z);
    shapesConcat(2:2:end,z) = shapes(:,2,z);
end

% mean
meanVec = sum(shapesConcat,2)/(depth - 1); % col vector

% cov
diff = shapesConcat - repmat(meanVec, [1 depth 1]);
cov = (diff * diff') / (depth - 1);

% eigen vecs and vals
[eigenVecs, eigenVals] = eig(cov);
[eigenVals, I] = sort(diag(eigenVals),'descend'); 
vecs_sorted = eigenVecs(:,I);
eigenVecs = normalize(vecs_sorted);
%normieren?

% generate shapes
% for i = 1:depth
%     b = eigenVecs' * (shapesConcat(:,i) - meanVec);
%     b(2:end) = 0;
%     
%     x = generateShape(b, eigenVecs, meanVec);
%     figure;
%     plotShape(x, meanVec);
% end

% 5.c
b = randn(1, size(eigenVecs,2)) .* std(eigenVals);

% main eigenvector
createAndPlotShape(b, eigenVecs, meanVec, 1);

% side eigenvector
createAndPlotShape(b, eigenVecs, meanVec, 2, 2);

% first 2 eigenvectors
createAndPlotShape(b, eigenVecs, meanVec, 2);

% 100%
t = getRestriction(eigenVals, 1);
createAndPlotShape(b, eigenVecs, meanVec, t);

% 95%
t = getRestriction(eigenVals, 0.95);
createAndPlotShape(b, eigenVecs, meanVec, t);

% 90%
t = getRestriction(eigenVals, 0.9);
createAndPlotShape(b, eigenVecs, meanVec, t);

% 80%
t = getRestriction(eigenVals, 0.8);
createAndPlotShape(b, eigenVecs, meanVec, t);

end

function [t] = getRestriction(variances, th)
% INPUT
% variances ..... vector containing the eigenvalues = variances
% th        ..... threshold for the calculation in [0 1]

totalVar = sum(variances);
sumVar = 0;
t = 0;
while(sumVar < totalVar * th)
    t = t + 1;
    sumVar = sumVar + variances(t);
end

end

function createAndPlotShape(b, eigenVecs, meanVec, t, start)
% INPUT:
% b         ..... weight vector, 1xN
% eigenVecs ..... matrix of column eigenvectors, NxN
% meanVec   ..... vector with average of all shapes, Nx1
% t         ..... number of eigenvectors to be used, scalar
% start     ..... optional: scalar


if(nargin < 5)
    start = 1;
end

bTmp = zeros(size(b))';
bTmp(start:t) = b(start:t); 
x = generateShape(bTmp, eigenVecs, meanVec);
plotShape(x, meanVec);

end

function [result] = normalize(vectors)
% INPUT:
% vectors ..... matrix of column vectors to be normalized, (2NxM)

normVals = sqrt(dot(vectors, vectors,1));
result = vectors ./ repmat(normVals, [size(vectors,1) 1 1]);
end
