function [ eigenval, eigenvec] = pca( D )
% Performs the PCA
%   D .... Matrix (dim x n)
%   eigenval ... eigenvalues in decreasing order
%   eigenvec ... eigenvectors of the eigenvalues
meanVec = zeros(1,size(D,1));
covmatrix = ourCov(D);
[eigenvec eigenval] = eig(covmatrix);

%% sort
val_sorted = diag(sort(diag(eigenval),'descend'));
[B, I] = sort(diag(eigenval),'descend'); 
vec_sorted = eigenvec(:,I); 
eigenval = val_sorted;
eigenvec = vec_sorted;

result = eigenvec' * D;

% plot
%plot2DPCA(D, meanVec, result, eigenvec, eigenval, 1, 1); % n x d or d x n?

end

