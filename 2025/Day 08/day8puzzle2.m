%% day8puzzle2 - Daniel Breslan - Advent Of Code 2025
data = readlines("input.txt").split(",").double;

distances = triu(sqrt((data(:,1) - data(:,1)').^2 + (data(:,2) - data(:,2)').^2 + (data(:,3) - data(:,3)').^2));
distances(distances == 0) = nan;
[~, linearIdx] = sort(distances(:));
[rowIdx, colIdx] = ind2sub(size(distances), linearIdx);
links = {[rowIdx(1),colIdx(1)]};
for idx = 2:numel(colIdx)
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
    if numel(links{1}) == height(data)
        break
    end
end
format longg
day8puzzle2result = data(jb1,1) * data(jb2,1)

function includedIn = isItIn(cells,elements)
includedIn = nan(1,2);
for idx = 1:numel(cells)
    includedIn(any(elements == cells{idx}')) = idx;
end
end
