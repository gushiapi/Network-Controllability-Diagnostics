function partition = robustCom(B, N)
% B is a cell array of networks, we generate uni robust community structure
% considering the combination of all the elems
T = 50;
K = numel(B);
partitions = zeros(N, T*K);
for i = 1:K
    for j = 1:T
        [partitions(:,(i-1)*T + j), ~] = genlouvain(B{i});
    end
end
[S2, ~, ~, ~] = consensus_comm_wei(partitions');
partition = round(mean(S2));
end