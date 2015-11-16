function [S, Q, lAlambda] = multislice_static_unsigned(A,gplus)

% INPUTS
% A is the (weighted) connectivity matrix
% it is assumsed that all values of the connectivity matrix are positive
% Gplus is the resolution parameter. If unsure, use default value of 1.

% OUTPUTS
% S is the partition (or community assignment of all nodes to communities)
% Q is the modularity of the (optimal) partition
% lAlambda is the effective fraction of antiferromagnetic edges (see Onnela
% et al. 2011 http://arxiv.org/pdf/1006.5731v1.pdf)

% This code uses the Louvain heuristic

% DB 2012

Aplus=A; Aplus(A<0)=0;
kplus=sum(Aplus)';
P = (kplus*kplus'/sum(kplus));
B=A-P.*gplus;
lAlambda = numel(find((A./P)<gplus));
%[S, Q] = greedysparse(B);
% [S Q] = genlouvainrand(B);
[S, Q] = genlouvain(B);
%[S2,Q2]=newmanklB(S,B); IF YOU WANT ITERATIVE IMPROVEMENT
Q=Q/(sum(kplus));



