function [H2, smeig ] = Gramian( W, B )
%GRAMIAN computes the H2/Gramian and smallest eigen values for given A,B
% with model x(t + 1) = Ax(t) + Bu(t),
% A is NxN ajaciency matrix, B is Nxk control matrix
% H2 = sqrt(trace(sum_k A^kBB^T(A^T)^k))
A = W / (1+eigs(W,1));
% H2 = trace(B*B');
[U, T] = schur(A,'real');
midMat = U' *(B*B')*U;
v = diag(T);
P = midMat ./(1 - v*v');
H2 = sqrt(trace(P));
eigValues = svd(P);
smeig = eigValues(end);
