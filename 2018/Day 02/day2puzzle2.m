%% day2puzzle2 - Daniel Breslan - Advent Of Code 2018
data = readlines("input.txt").split("");


data = data(:,2:end-1);
for idx = 1:size(data,1) % loop though all lines

searchPhrase = data(idx,:); % get one to search from

poolToSearch = data; % get rest by clone and remove the searchPhase
poolToSearch(idx,:) = [];

results = searchPhrase == permute(poolToSearch,[2,3,1]);
% make the pool columns (1 per page)
ind = sub2ind(size(results), ...
    repmat(1:numel(searchPhrase),1,size(results,3)), ...
    repmat(1:numel(searchPhrase),1,size(results,3)), ...
    repelem(1:size(results,3),1,numel(searchPhrase))); % extract diags/page
oneOffIndex = sum(reshape(results(ind),[],size(poolToSearch,1))) ==...
    numel(searchPhrase) - 1; % find bool where all but 1 match.
if any(oneOffIndex) % if found, stop looking
    break 
end
end

day2puzzle2result = searchPhrase(searchPhrase ==...
    poolToSearch(oneOffIndex,:)).join("") 
% find result by removing the diff char