% 1.a
function [ C ] = ourCov( D )
% Calculates covariance matrix of a dim dimensional matrix
%   D .... Matrix (dim x n)
%   C .... calculated covariance matrix

    n = size(D,2);
    meanVec = zeros(1,size(D,1));
    for i = 1:size(D,1)
        meanVec(i) = mean(D(i,:));
    end
    meanVec = meanVec';
    C = zeros(size(D,1));
    for i = 1:n 
        C = C + (D(:,i) - meanVec) * (D(:,i) - meanVec)';     
    end
    
    C = C /(n-1);
    
    %% TODO: PLOT
%    figure;
%    plot(D(:,1), D(:,2));
%    axis equal;
end

