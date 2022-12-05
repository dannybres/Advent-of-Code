%% day3puzzle1 - Daniel Breslan - Advent Of Code 2019
data = readlines("input.txt");
matchStr = ["L","R","D","U"];

for idx = 1:numel(data)
    d = data(idx).split(",");
    d = [d.extractBefore(2) d.extractAfter(1)];
    route = (d(:,1) == matchStr) * [-1 0;1 0;0 -1;0 1];
    path{idx} = []; 
    for iidx = 1:size(route,1)
        path{idx} = [path{idx}; repmat(route(iidx,:),d(iidx,2).double(),1)];
    end
    path{idx} = cumsum(path{idx});
end

r = ismember(path{1},path{2},'rows');
day3puzzle1result = min(sum(abs(path{1}(r,:)),2)) %#ok<NOPTS> 