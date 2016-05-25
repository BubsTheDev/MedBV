function Bsp5(shapes)
% Solves Task 5
% Solution based on:
% http://www.robots.ox.ac.uk/~jmb/lectures/InformaticsLecture6.pdf
% http://www.imm.dtu.dk/~aam/downloads/asmprops/node2.html
% Active Shapes Models Unleashed, Matthias Kirschner and Stefan Wesarg
%
% INPUT:
% shapes ..... matrix containing data of different shapes, NxMxD

% 5.a
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
[eigenVals, I] = sort(diag(eigenVals),'descend'); % vectors
vecs_sorted = eigenVecs(:,I); 
eigenVecs = normalize(vecs_sorted); % matrix

% 5.b
b = zeros(length(eigenVals),1);
for t = 1:12 % 12 modes
    stdDer = sqrt(eigenVals(t));
    x = [];
    for i = -3:3 % bi range
        
        if i == 0
            continue;
        end
        
        b(t) = i * stdDer;
        
        x = cat(1, x, generateShape(b, eigenVecs, meanVec));        
    end
    b(t) = 0;
    title = sprintf('%d. Mode In Range +-3*%.4f', t, stdDer);
    plotShape(x, meanVec, title);
end

% 5.c
b = randn(1, size(eigenVecs,2)) .* std(eigenVals);

% main eigenvector
createAndPlotShape(b, eigenVecs, meanVec, 1, 'Main Eigenvector');

% side eigenvector
createAndPlotShape(b, eigenVecs, meanVec, 2, 'Side Eigenvector', 2);

% first 2 eigenvectors
createAndPlotShape(b, eigenVecs, meanVec, 2, 'First 2 Eigenvectors');

titleTemplate = '%d%% Of Total Variance = %d Eigenvecs';

% 100%
t = getRestriction(eigenVals, 1);
createAndPlotShape(b, eigenVecs, meanVec, t, sprintf(titleTemplate, 100, t));

% 95%
t = getRestriction(eigenVals, 0.95);
createAndPlotShape(b, eigenVecs, meanVec, t, sprintf(titleTemplate, 95, t));

% 90%
t = getRestriction(eigenVals, 0.9);
createAndPlotShape(b, eigenVecs, meanVec, t, sprintf(titleTemplate, 90, t));

% 80%
t = getRestriction(eigenVals, 0.8);
createAndPlotShape(b, eigenVecs, meanVec, t, sprintf(titleTemplate, 80, t));

end

function [t] = getRestriction(variances, th)
% Computes the number of eigenvectors to be use for shape generation
%
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

function createAndPlotShape(b, eigenVecs, meanVec, t, title, start)
% Generates a shape and plots it
%
% INPUT:
% b         ..... weight vector with random values, 1xN
% eigenVecs ..... matrix of column eigenvectors, NxN
% meanVec   ..... vector with average of all shapes, Nx1
% t         ..... number of eigenvectors to be used, scalar
% start     ..... optional: scalar
% title     ..... optional: title of figure

if nargin < 6
   start = 1;
end

if(nargin < 5)
   title = 'Random Shapes';
else
    title = ['Random Shapes' ':' title];
end

bTmp = zeros(size(b))';
bTmp(start:t) = b(start:t);
x = generateShape(bTmp, eigenVecs, meanVec);
plotShape(x, meanVec, title);

end

function [result] = normalize(vectors)
% Normalizes the eigenvectors
%
% INPUT:
% vectors ..... matrix of column vectors to be normalized, (2NxM)

normVals = sqrt(dot(vectors, vectors,1));
result = vectors ./ repmat(normVals, [size(vectors,1) 1 1]);
end
