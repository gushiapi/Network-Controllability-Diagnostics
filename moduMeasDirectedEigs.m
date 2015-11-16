function [values ] = moduMeasDirectedEigs(A)
% FUNCTION: 
%          return the tiered values of the Modal Control
% INPUT: 
%         A is the input ajaciency matrix
% OUTPUT: 
%         values is the value of modal control
A = A./(1+svds(A,1));
[V,D] = eig(A);
D = diag(D);
N = size(A,1);
phi = zeros(N,1);
for i = 1 : N
    phi(i) = abs((V(i,:).* conj(V(i,:))) * (1 - D.*conj(D)));
end
values = phi;