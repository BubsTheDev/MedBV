function plotShape( shape, meanShape, figureTitle)
% Plots the generated shapes in blue and the mean shape in red
%
% INPUT:
% shape       ..... single vector containing all shapes, aNx1
% meanShape   ..... vector containing the mean shape, Nx1
% figureTitle ..... optional: title of this figure

if nargin < 3
    figureTitle = 'Shapes Plot';
end

figure;
plot(shape(1:2:end), shape(2:2:end), 'b-', meanShape(1:2:end), meanShape(2:2:end), 'r-');
title(figureTitle);
legend('gen. shapes','mean shape');

end

