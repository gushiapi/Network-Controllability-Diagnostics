function [values ] = averMeasDirected(A)
% FUNCTION: 
%          return the tiered values of the Average Control
% INPUT: 
%         A is the input ajaciency matrix
% OUTPUT: 
%         values is the value of average control

A = A/(1+eigs(A,1));
SeriesSum = dlyap(A,eye(size(A,1)));
values = diag(SeriesSum);

end