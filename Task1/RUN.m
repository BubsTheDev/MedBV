clear;

daten = struct2cell(load('daten.mat'));
daten3d = struct2cell(load('daten3d.mat'));
shapes = struct2cell(load('shapes.mat'));

%% 1.b
numElems = size(daten,1);
covMatrices = cell(1, numElems);
for i=1:numElems
   data = daten{i};
   covMatrices{i} = ourCov(data);
   
   % plot
%    fprintf('Kovarianzmatrix data%d:\n',i);
%    disp(covMatrices{i});
%    figure;
%    plot(data(1,:), data(2,:));
%    axis equal;
end

%% 2.a
eigenValues = cell(1, numElems);
eigenVectors = cell(1, numElems);
meanVectors = cell(1, numElems);
for i=1:numElems
    [eigenValues{i}, eigenVectors{i}] = pca(daten{i});
    meanVectors{i} = mean(daten{i},2);
    meanMatrix = repmat(meanVectors{i},1,size(daten{i},2),1);
    
    %plot
    projection = (daten{i} - meanMatrix)' * eigenVectors{i};
    reconstruction = projection * eigenVectors{i} + meanMatrix';
    plot2DPCA(daten{i}', meanVectors{i}', reconstruction, eigenVectors{i}, eigenValues{i}, 1, 1);
end




   %% 2a)
%    [eigenval eigenvec] = pca(daten{i});
%  
%    %% 3a) TODO: Projizieren
%    if(i == 3)
%        eigenval_d3 = eigenval;
%        eigenvec_d3 = eigenvec;
%    end
% 
% %% 4a)
% pca3d = pca(daten3d{1});
