function [ uniqStrs, labels ] = cellUniqueStr(cellArrayInput)
% This function returns the unique elements of a cell array and the labels
% according to the order in the uniqStrs
N = numel(cellArrayInput);
labels = zeros(N,1);
uniqNum = 0;
uniqStrs = {};
for j = 1:N
    idx = findLabel(uniqStrs, cellArrayInput{j});
    if idx == 0
        uniqNum = uniqNum + 1;
        uniqStrs{uniqNum} = cellArrayInput{j};
        labels(j) = uniqNum;
    else
        labels(j) = idx;
    end
end
end

function [idx] = findLabel(cellArray, currWord)
idx = 0;
for i = 1:numel(cellArray)
    if strcmp(cellArray{i}, currWord)
        idx = i;
        return;
    end
end
end
