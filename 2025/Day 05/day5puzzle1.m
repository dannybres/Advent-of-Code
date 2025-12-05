%% day5puzzle1 - Daniel Breslan - Advent Of Code 2025
data = readlines("input.txt");
splitIdx = find(data == "");
database = data(1:splitIdx-1).split("-").double();
ingredients = reshape(data(splitIdx+1:end).double(),1,1,[]);
day5puzzle1result = sum(squeeze(any(ingredients >= database(:,1) & ingredients <= database(:,2))))