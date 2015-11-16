function [ zMean, zVar] = zMeanVar( partitions )
% partitions is nxp matrix, where n is the number of nodes and p is the 
% number of partitions
n = size(partitions, 1);
p = size(partitions, 2);
zVals = zeros(p*(p-1)/2,1);
count = 0;
for i = 1:p
    for j = (i+1):p
        count = count + 1;
        zVals(count) = zrand(partitions(:,i), partitions(:,j));
    end
end
zMean = mean(zVals);
zVar = var(zVals);
