% Author: Tuomas Du-Ikonen
% k-means clustering

clear all, close all, clc

% Read image
I = im2double(imread('butterfly.png'));

figure(1)
subplot(231)
imshow(I)
title("Original");

k = [2 3 4 5 8]; % Number of clusters

for ii = 1:size(k,2)
    % Create array X of size H*W x 3 from the image I
    X = reshape(I,[],size(I,3));

    [labels, C, cnt] = k_means_cluster(X, k(1,ii));

    % Reshape the labels vector into an image of size XxW
    L = reshape(labels,[size(I,1),size(I,2)]);
    % plotting
    J = label2rgb(L, C);

    subplot(2,3,ii+1)
    imshow(J)
    title("Clusters " + k(1,ii));
end