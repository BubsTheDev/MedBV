function shapeModel(shapes)
% Solves Task 5
% Solution based on:
% http://www.robots.ox.ac.uk/~jmb/lectures/InformaticsLecture6.pdf
% http://www.imm.dtu.dk/~aam/downloads/asmprops/node2.html
% Active Shapes Models Unleashed, Matthias Kirschner and Stefan Wesarg
%
% INPUT:
% shapes ..... matrix containing data of different shapes, NxMxD

rows = size(shapes,1);
cols = size(shapes,2);
depth = size(shapes,3);

shapesConcat = zeros(rows * cols, depth);

for x2 = 1:depth
    shapesConcat(1:2:end,x2) = shapes(:,1,x2);
    shapesConcat(2:2:end,x2) = shapes(:,2,x2);
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
    x1 = [];
    x2 = []; 
    x3 = [];
    x4 = [];
    for i = -3:3 % bi range
        
        if i == 0
            continue;
        end
        
        b(t) = i * stdDer;
        
        x = cat(1, x, generateShape(b, eigenVecs, meanVec,0,1,0,0)); %original shapes   
        x1 = cat(1, x1, generateShape(b, eigenVecs, meanVec,30,1,0,0)); %rotated  
        x2 = cat(1, x2, generateShape(b, eigenVecs, meanVec,0,1,40,50)); %translated 
        x3 = cat(1, x3, generateShape(b, eigenVecs, meanVec,0,0.2,0,0)); %scaled 
        x4 = cat(1, x4, generateShape(b, eigenVecs, meanVec,130,2,-20,-60)); % rotated, translated, scaled 
    end
    b(t) = 0;
    title = sprintf('%d. Mode In Range +-3*%.4f', t, stdDer);
    plotShape(x, meanVec, title);
    title = sprintf('[R 30°] %d. Mode In Range +-3*%.4f', t, stdDer);
    plotShape(x1, meanVec, title);
    title = sprintf('[T X=40 Y=50] %d. Mode In Range +-3*%.4f', t, stdDer);
    plotShape(x2, meanVec, title);
    title = sprintf('[S 0.2] %d. Mode In Range +-3*%.4f', t, stdDer);
    plotShape(x3, meanVec, title);
    title = sprintf('[R 130°; S 2; T X=-20 Y=-60] %d. Mode In Range +-3*%.4f', t, stdDer);
    plotShape(x4, meanVec, title);
end

end

function [result] = normalize(vectors)
% Normalizes the eigenvectors
%
% INPUT:
% vectors ..... matrix of column vectors to be normalized, (2NxM)

normVals = sqrt(dot(vectors, vectors,1));
result = vectors ./ repmat(normVals, [size(vectors,1) 1 1]);
end
