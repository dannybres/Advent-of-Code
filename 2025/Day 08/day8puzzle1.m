%% day8puzzle1 - Daniel Breslan - Advent Of Code 2025
data = readlines("input.txt").split(",").double;

distances = triu(sqrt((data(:,1) - data(:,1)').^2 + (data(:,2) - data(:,2)').^2 + (data(:,3) - data(:,3)').^2));
distances(distances == 0) = nan;
[~, linearIdx] = sort(distances(:));
[rowIdx, colIdx] = ind2sub(size(distances), linearIdx);
links = {[rowIdx(1),colIdx(1)]};
pairsOfJunctionBoxes = 1000;
for idx = 1:pairsOfJunctionBoxes
    jb1 = rowIdx(idx); jb2 = colIdx(idx);
    includedIn = isItIn(links,[jb1,jb2]);
    switch nnz(~isnan(includedIn))
        case 0 % in none, add it
            links = [links;{[jb1,jb2]}];
        case 1 % in one, append it
            mergeWith = includedIn(~isnan(includedIn));
            links{mergeWith} = unique([links{mergeWith},jb1,jb2]);
        case 2 % in two, merge them
            if diff(includedIn) == 0, continue, end
            links{includedIn(1)} = unique([[links{includedIn}],jb1,jb2]);
            links(includedIn(2)) = [];
    end
end

lengths = sort(cellfun(@(x) numel(x),links) - 1,'descend')+1;
day8puzzle1result = prod(lengths(1:3))

function includedIn = isItIn(cells,elements)
includedIn = nan(1,2);
for idx = 1:numel(cells)
    includedIn(any(elements == cells{idx}')) = idx;
end
end