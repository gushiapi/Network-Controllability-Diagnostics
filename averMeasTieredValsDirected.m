function [ tieredVals ] = averMeasTieredValsDirected( A )
% FUNCTION: 
%          return the tiered values of the Average Control
% INPUT: 
%         A is the input ajaciency matrix
% OUTPUT: 
%         tieredVals are the tiered values of average control

A = A/(1+eigs(A,1));
SeriesSum = dlyap(A,eye(size(A,1)));
Values = diag(SeriesSum);

[~, idx1] = sort(Values,'descend');
[~, idx2] = sort(idx1,'ascend');
tieredVals = (1 + size(A,1)) - idx2;

end