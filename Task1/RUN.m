clear;
close all

daten = struct2cell(load('daten.mat'));
daten3d = struct2cell(load('daten3d.mat'));
shapes = struct2cell(load('shapes.mat'));

%% 1. Kovarianzmatrix
% 1.b
numElems = size(daten,1);
for i=1:numElems
    data = daten{i};
    covMatrix = ourCov(data);
    
    % plot
    fprintf('Kovarianzmatrix data%d:\n',i);
    disp(covMatrix);
    figure;
    plot(data(1,:), data(2,:), 'bo');
    axis equal;
end

%% PCA
% 2.abc
eigenValues = cell(1, numElems);
eigenVectors = cell(1, numElems);
meanVectors = cell(1, numElems);
for i=1:numElems
    [eigenValues{i}, eigenVectors{i}] = pca(daten{i});
    meanVectors{i} = mean(daten{i},2);
    meanMatrix = repmat(meanVectors{i},[1 size(daten{i},2) 1]);
    
    %plot
    projection = (daten{i} - meanMatrix)' * eigenVectors{i};
    reconstruction = projection * eigenVectors{i}' + meanMatrix';
    plot2DPCA(daten{i}', meanVectors{i}', reconstruction, eigenVectors{i}, eigenValues{i}, 1, 1);
end

% 2.d
projection = (daten{4})' * eigenVectors{4};
reconstruction = projection * eigenVectors{4}' + meanMatrix';
plot2DPCA(daten{4}', meanVectors{4}', reconstruction, eigenVectors{4}, eigenValues{4}, 1, 1);

%% 3 Unterraumprojektion
% 3.a
meanMatrix = repmat(meanVectors{3},[1 size(daten{3},2) 1]);
eigenVector = eigenVectors{3};
eigenVector = eigenVector(:,1); % main vector = eigenvector with biggest eigenvalue
projection = (daten{3} - meanMatrix)' * eigenVector; % dimension: nx1
reconstruction = projection * eigenVector' + meanMatrix'; % dimension: nx2
plot2DPCA(daten{3}', meanVectors{3}', reconstruction, eigenVectors{3}, eigenValues{3}, 1, 1);

% error
diff = (reconstruction - daten{3}');
meanAbsError = sum(sqrt(dot(diff, diff, 2))) / size(daten{3}', 1);
fprintf('Hauptvektor durchschnittlicher Fehler: %.10f%% \n', meanAbsError);

% 3.b
meanMatrix = repmat(meanVectors{3},[1 size(daten{3},2) 1]);
eigenVector = eigenVectors{3};
eigenVector = eigenVector(:,2); % side vector = eigenvector with smallest eigenvalue
projection = (daten{3} - meanMatrix)' * eigenVector; % dimension: nx1

figure;
plot(projection(:,1),'bo'); %Plot 1D projection data
title('Projection 3b');

reconstruction = projection * eigenVector' + meanMatrix'; % dimension: nx2
plot2DPCA(daten{3}', meanVectors{3}', reconstruction, eigenVectors{3}, eigenValues{3}, 1, 1);

% error
diff = (reconstruction - daten{3}');
meanAbsError = sum(sqrt(dot(diff, diff, 2))) / size(daten{3}', 1);
fprintf('Nebenvektor durchschnittlicher Fehler: %.10f%% \n', meanAbsError);


%% 4 Untersuchungen in 3D
% 4.a
data3D = daten3d{1};
[eigenVal, eigenVec] = pca(data3D);
meanVec = mean(data3D,2);
plot3DPCA(data3D', meanVec', eigenVec, eigenVal, 1, 0); %Plot data without reconstruction

% 4.b
meanMatrix = repmat(meanVec,[1 size(data3D,2) 1]);
eigenVector = eigenVec(:,1:2);
projection = (data3D - meanMatrix)' * eigenVector; % dimension: nx2

figure;
plot(projection(:,1),projection(:,2),'bo'); %Plot 2D projection data
title('Projection 4b');

reconstruction = projection * eigenVector' + meanMatrix'; % dimension: nx3
plot3DPCA(data3D', meanVec', eigenVec, eigenVal, 1, 1); %Plot data with reconstruction flag

%% 5 Shape Modell
shapes = shapes{1};
%5.a PCA der Shape Daten
% for i=1:size(shapes,3)
%     [eigenVal, eigenVec] = pca(shapes(:,:,i));
%     meanVec = mean(shapes(:,:,i),2);
%     meanMatrix = repmat(meanVec,[1 size(shapes(:,:,i),2) 1]);
%     projection = (shapes(:,:,i) - meanMatrix)' * eigenVec;
%     reconstruction = projection * eigenVec' + meanMatrix';
% end
Bsp5(shapes);
