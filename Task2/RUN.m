%addpath('../providedFunctions/');
addpath(genpath('/providedFunctions/'));
close all

data = struct2cell(load('handdata.mat'));

%% Task 1
shapes = data{1};
%shapeModel(shapes);

%% Task 2
image = data{2}{1};
features = cache(@computeFeatures,image);
clear;
