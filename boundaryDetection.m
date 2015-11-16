function[ind, newPart1, newPart2] = boundaryDetection(network, subIndex, thresholdRatio)
% FUNCTION:
%        This function bipartitionate the sub-network into two parts using the
%        Fieldler vector.
% INPUT:
%        network  : the whole network
%        subIndex : the subnetwork index
%        thresholdRatio : the threshold ratio to detect boundary points
% OUTPUT: 
%        ind : the index of the detected boundary points
%        newPart1: the index of the points in group-1
%        newPart2: the index of the points in group-2
subNetwork = network(subIndex, subIndex);
threshold = max(subNetwork(:))* thresholdRatio;

if ((size(subNetwork,1) == 1))
   ind = subIndex;
   newPart1 = [];
   newPart2 = [];
   return;
end

L = diag(sum(subNetwork)) - subNetwork;
[V, ~]  = svd(L);
fV = V(:, end-1);
ind1 = find(fV >=0);
ind2 = find(fV <0);
if(isempty(ind1) || isempty(ind2))
    midNum = floor((1+length(fV))/2);
    ind1 = 1: midNum;
    ind2 = (midNum+1) : length(fV);
end
newPart = zeros(1, numel(fV));
for j = 1 : numel(ind1)
    lala = sum(subNetwork(ind1(j), ind2));
    if ( lala >= threshold)
        newPart(ind1(j)) = 1;
    end
end

for j = 1 : numel(ind2)
    lala = sum(subNetwork(ind2(j), ind1));
    if ( lala >= threshold)
        newPart(ind2(j)) = 1;
    end
end

ind = subIndex(newPart == 1);
newPart1 = subIndex(ind1);
newPart2 = subIndex(ind2);

end