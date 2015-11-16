function [ indxx ] = getTieredControlStatesSH( networks, threshold, gamma)
% FUNCTION: 
%           returns the indices of the input networks with share initial
%           partitions
% Input: 
%           networks{:}: cell array of the networks
%           threshold  : array of the thresholds, same length with
%           networks{}
%           gamma: paramter in the genlouvain algorithm
%% Compute Robust Shared Initial States
K = numel(networks);
for s = 1: K
    A = networks{s};
    k = full(sum(A));
    twom = sum(k);
    B{s} = @(i) A(:,i) - gamma*k'*k(i)/twom;
end
partitionInit = robustCom(B, size(A,1));
%% Compute TieredControlStates 
for s = 1:K
    % Initialize parameters, different A, same partition
    A = networks{s};
    Kset = zeros(1, size(A,1));
    I = eye(size(A,1));
    cardK = size(A,1);
    partition = partitionInit;
    
    communities = unique(partition);
    A = A./ max(A(:));
    for i = communities
        ind1 = find(partition == i);
        ind2 = (partition ~= i);
        for j = 1 : numel(ind1)
            lala = sum(A(ind1(j), ind2));
            if ( lala >= threshold)
                Kset(ind1(j)) = 1;
            end
        end
    end
    
    while (sum(Kset>0) < cardK)
        sum(Kset > 0)
        uniPVal = unique(partition);
        eigVals = zeros(1, numel(uniPVal));
        for i = 1 : numel(uniPVal)
            if all(Kset(partition == uniPVal(i)))
                eigVals(i) = Inf;
            else
                [~, eigVals(i)] = Gramian(A, I(:, (partition == uniPVal(i))));
            end
        end
        if (all(eigVals == Inf))
            break;
        end
        [~, l] = min(eigVals);
        
        indL = find(partition == uniPVal(l));
        [boundInd, newPart, ~] = boundaryDetection(A, indL, threshold);
        if(sum(boundInd) > 0)
            Kset(Kset > 0) = Kset(Kset > 0) + 1;
            Kset(boundInd) = 1;
        end
        if (numel(newPart > 0))
            partition(newPart) = max(uniPVal) + 1;
        end
    end
    ind = Kset;
    M = max(Kset);
    for i = 1:M
        ind(Kset == i) = sum(Kset <= i);
    end
    
    indxx{s} = ind;
end

