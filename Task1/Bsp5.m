function Bsp5(shapes)
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
eigenVecs = vecs_sorted;
%normieren?

% generate shapes
for i = 1:depth
    b = eigenVecs' * (shapesConcat(:,i) - meanVec);
    x = generateShape(b, eigenVecs, meanVec);
    figure;
    plotShape(x, meanVec);
end


end