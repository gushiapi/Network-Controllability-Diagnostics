function [tieredVals ] = degTieredVals(A)
% FUNCTION: 
%          return the tiered values of the Degree
% INPUT: 
%         A is the input ajaciency matrix
% OUTPUT: 
%         tieredVals is the calculated tiered values
degVals = zeros(size(A,1),1);
for i = 1: numel(degVals)
   degVals(i) = sum(A(:,i)); 
end
[~, idx1] = sort(degVals,'descend');
[~, idx2] = sort(idx1,'ascend');
tieredVals = (1 + size(A,1)) - idx2;