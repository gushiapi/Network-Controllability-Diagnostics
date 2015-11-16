function [values ] = averMeas(A)
% FUNCTION: 
%         return the tiered values of the Average Control
% INPUT: 
%         A is the input ajaciency matrix
% OUTPUT: 
%         values is the value of average control

A = A./(1+svds(A,1));
[U, T] = schur(A,'real');
midMat = (U.^2)';
v = diag(T);
P = repmat(diag(1 - v*v'),1,size(A,1));
values = sum(midMat./P)';
