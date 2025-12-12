%% day12puzzle1 - Daniel Breslan - Advent Of Code 2025
data = readlines("input.txt");
split = find(data.contains("x"),1)-1;

regionsData = data(split+1:end).extract(digitsPattern).double;

% do the 3x3 squares fit?
regionAreas = prod(regionsData(:,1:2),2);
numPieces = sum(regionsData(:,3:end),2);
day12puzzle1result = nnz(regionAreas >= numPieces * 9)

% do the number of hashes in the presents fit?
presentData = data(1:split-1);
presentData(presentData == "") = ",";
presentData = presentData.join("").split(",").count("#");
numHash = sum(regionsData(:,3:end) .* repmat(presentData',height(regionsData),1),2);
day12puzzle1result = nnz(regionAreas >= numHash)
