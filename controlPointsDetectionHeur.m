function [controlVal, ind ] = controlPointsDetectionHeur(A, cardK)
% FUNCTION:
%           return the index of the control points 
% INPUT: 
%           A: network/adjacient matrix
%           cardK: number of control points

[U, T] = schur(A,'real');
eigVals = diag(T);
N = size(A,1);
phi = zeros(N,1);
ind = zeros(N,1);
for i = 1 : N
    phi(i) = (U(i,:).^2) * (1 - eigVals.^2);
end
[~, fullIdx] = sort(phi,'descend');
controlVal = phi;
ind(fullIdx(1:cardK)) = 1;