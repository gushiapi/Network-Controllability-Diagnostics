function [ ind ] = controlPointsDetectionH2(A, cardK)
% FUNCTION:
%           return the index of the control points 
% INPUT: 
%           A: network/adjacient matrix
%           cardK: number of control points

I = eye(size(A,1));
W = A;
gram = zeros(1,size(A,1));
for j = 1:size(I,1)
    [gram(j), ~] = Gramian(W, I(:, j));
end
[~,idxGram] = sort(gram,'descend');
ind = zeros(1, size(A,1));
ind(idxGram(1:cardK)) = 1;
end

