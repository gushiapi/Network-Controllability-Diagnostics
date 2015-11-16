function [ dataCells ] = xlsReader( fileName, sheetName, colRange )
% Return a cell matrix of the raw data for the given range
% eg: xlReader('myfile.xls','Sheet1','B2:C5')
[~,~, rawdata] = xlsread(fileName,sheetName);
[startPos, endPos] = findPosition(colRange);
dataCells = rawdata(startPos.row:endPos.row, startPos.col:endPos.col);
end



function[startPos, endPos] = findPosition(colRange)
ANUM = double('A');
tmp = textscan(colRange,'%s','delimiter', ':');
tmp = tmp{1};
startString = char(tmp{1});

tmpStartArray = isletter(startString);
numStart = sum(tmpStartArray)+1;
startPos.col = 0;
for i = 1:(numStart-1)
    startPos.col = startPos.col + (double(startString(i)) - ANUM + 1) * (26^(numStart-1-i));
end
startPos.row = str2num(startString(numStart:end));


endString = char(tmp{2});
tmpEndArray = isletter(endString);
numStart = sum(tmpEndArray)+1;
endPos.col = 0;
for i = 1:(numStart-1)
    endPos.col = endPos.col + (double(endString(i)) - ANUM + 1) * (26^(numStart-1-i));
end
endPos.row = str2num(endString(numStart:end));

end