function [ tieredVals ] = moduMeasTieredVals( A )
A = A./(1+svds(A,1));
[U, T, V] = svd(A);
eigVals = diag(T);
N = size(A,1);
phi = zeros(N,1);
for i = 1 : N
    phi(i) = (U(i,:).*V(i,:)) * (1 - eigVals.^2);
end
[~, idx1] = sort(phi,'descend');
[~, idx2] = sort(idx1,'ascend');
tieredVals = (1 + size(A,1)) - idx2;
end

