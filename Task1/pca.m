function [ eigenval, eigenvec] = pca( D )
% Performs the PCA
%   D .... Matrix (dim x n)
%   eigenval ... eigenvalues in decreasing order
%   eigenvec ... eigenvectors of the eigenvalues

covmatrix = ourCov(D);
[eigenvec, eigenval] = eig(covmatrix);

% meanVec = zeros(1,size(D,1));
% for i = 1:size(D,1)
%     meanVec(i) = mean(D(i,:));
% end
% meanVec = meanVec';

%% sort
%1 get diagonal vector of matrix -> vector
%2 sort them in descend order -> vector
%3 create diagonal matrix of sorted vector -> matrix
%val_sorted = diag(sort(diag(eigenval),'descend'));
[val_sorted, I] = sort(diag(eigenval),'descend'); 
vec_sorted = eigenvec(:,I);
eigenval = val_sorted;
eigenvec(:,1) = vec_sorted(:,1)/norm(vec_sorted(:,1));
eigenvec(:,2) = vec_sorted(:,2)/norm(vec_sorted(:,2));

% projection = (D - repmat(meanVec,1,size(D,2),1))' * eigenvec;
% 
% projection = (D)' * eigenvec;
% reconstruction = projection * eigenvec' +  repmat(meanVec,1,size(D,2),1)';
% 
% 
% %plot PCA
% if size(D,1) == 2
%     plot2DPCA(D', meanVec, reconstruction, eigenvec, eigenval, 1, 1);
% elseif size(D,1) == 3
%     plot3DPCA(D', meanVec', eigenvec, eigenval, 1, 1)
% else
%     fprintf('No plotting for this matrix dimension available.'); 
% end
% 
end

