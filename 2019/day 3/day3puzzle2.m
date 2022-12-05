%% day3puzzle2 - Daniel Breslan - Advent Of Code 2019
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
    path{idx} = [path{idx} (1:length(path{idx}))'];
end

r1 = ismember(path{1}(:,1:2),path{2}(:,1:2),'rows');
r2 = ismember(path{2}(:,1:2),path{1}(:,1:2),'rows');


d1 = path{1}(r1,:);
d2 = path{2}(r2,:);
[~,si1] = sort(d1(:,2));
[~,si2] = sort(d2(:,2));
d1 = d1(si1,:);
d2 = d2(si2,:);

[~,si1] = sort(d1(:,1));
[~,si2] = sort(d2(:,1));
d1 = d1(si1,:);
d2 = d2(si2,:);

distances = d1(:,3) + d2(:,3);

min(distances)