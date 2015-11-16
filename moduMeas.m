function [values ] = moduMeas(A)
% FUNCTION: 
%          return the tiered values of the Modal Control
% INPUT: 
%         A is the input ajaciency matrix
% OUTPUT: 
%         values is the value of modal control
A = A./(1+svds(A,1));
[U, T] = schur(A,'real');
eigVals = diag(T);
N = size(A,1);
phi = zeros(N,1);
for i = 1 : N
    phi(i) = (U(i,:).^2) * (1 - eigVals.^2);
end
values = phi;