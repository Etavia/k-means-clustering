function [labels, C, cnt] = k_means_cluster(X, k, max_iter)
% Author: Tuomas Du-Ikonen
% This function performs k-means clustering on data in X using k clusters
% INPUT
% X: NxD matrix. Each row is a point of a D-dimensional vector space, N
%    points in total
% k: number of clusters (positive integer)
% max_iter: (optional) maximum number of iterations
%
% OUTPUT
% labels: Nx1 column vector, containing values in the range 1:k. Each
%         element tells the cluster of the corresponding row in X, e.g. if
%         labels(i)==3 then X(i,:) belongs to the third cluster
%
% C: kxD matrix containing the centroids of the clusters, one per row.
%    For example C(1,:) corresponds to the centroid of the first cluster
%
% cnt: number of iterations done (can be useful for debugging)

if nargin < 3
    max_iter = 500; % use maximum 500 iterations by defaults
end

C = X(ceil(rand(k,1)*size(X,1)),:); % kxD matrix containing the centroids of the clusters, one per row.
Cprev = X(ceil(rand(k,1)*size(X,1)),:); % Cluster centroid array copy to check if there's changes in iteration
auxarr01 = zeros(size(X,1),k+2); % Distances and labels
labels = zeros(size(X,1),1); % Labels

cnt = 1; % Iteration counter
a = 1; % Check if iteration is necessary. 1 = continue, 0 = stop.

while (cnt < max_iter & a == 1)
        
    for i = 1:size(X,1) % Iterate through all point in X
        for j = 1:k % Iterate through cluster centroids  
            auxarr01(i,j) = norm(X(i,:) - C(j,:));      
        end
        [dist, auxvar01] = min(auxarr01(i,1:k));                
        auxarr01(i,k+1) = auxvar01;                                 
        labels(i,1) = auxvar01;
        auxarr01(i,k+2) = dist;                          
    end
   
    for i = 1:k % Iterate through cluster centroids
        A = (auxarr01(:,k+1) == i);                          
        C(i,:) = mean(X(A,:));                       
        if sum(isnan(C(:))) ~= 0                     
            auxvar02 = find(isnan(C(:,1)) == 1);            
            for Ind = 1:size(auxvar02,1)
                C(auxvar02(Ind),:) = X(randi(size(X,1)),:);
            end
        end
    end
   
   % Test if continuing iteration is necessary
    if cnt > 0 & C == Cprev
        a = 0;
    else
        Cprev = C;
    end
    
    cnt = cnt + 1;
end
end