function [ vals, idx ] = topN(v, N )
% return the top N vals and idx of v
[sortV, sortIdx] = sort(v, 'descend');
vals = sortV(1:N);
idx = sortIdx(1:N);
end

