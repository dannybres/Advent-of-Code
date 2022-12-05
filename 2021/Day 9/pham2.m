%% Part 2
data = readlines("input.txt").split("");
data = double( data(:,2:end-1) );

basins = bwconncomp(data < 9, 4);
basinSize = cellfun(@numel,basins.PixelIdxList);
basinSize = sort(basinSize);
prod(basinSize(end-2:end))