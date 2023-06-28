%% day6puzzle1 - Daniel Breslan - Advent Of Code 2018
data = readlines("input.txt").split(", ").double();
t = array2table([(1:50)' data], VariableNames=["num","r","c"]);

res = zeros(400,400);

for r = 1:400 % double loop and find closest node
    for c = 1:400
        closest = find(abs(t.r - r) + abs(t.c - c) == min(abs(t.r - r) ...
            + abs(t.c - c)));
        if numel(closest) == 1
            res(r,c) = closest;
        end
    end
end

infzones = unique([res(:,1);...
    res(:,end);...
    res(1,:)';...
    res(end,:)'])'; % edges are infinite, fine node #

for idx = infzones
    res(res == idx) = 0; % 0 edge numbers
end

rc = categorical(res(:)); % count number of each node, use categorical
tc = table(categories(rc), countcats(rc));
tc = tc(2:end,:); % remove 0
tc = sortrows(tc,"Var2");

day6puzzle1result = tc.Var2(end) %#ok<NOPTS> 

%% Extras
imshow((flipud(uint8(255*res/50)))) % visualise it.
