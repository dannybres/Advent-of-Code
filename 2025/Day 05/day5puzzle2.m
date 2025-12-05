%% day5puzzle2 - Daniel Breslan - Advent Of Code 2025
data = readlines("input.txt");
database = data(1:find(data == "")-1).split("-").double();

ranges = database(1,:);
for idx = 2:height(database)
    lowVal = database(idx,1); highVal = database(idx,2);
    overlap = lowVal <= ranges(:,2) & highVal >= ranges(:,1);
    if nnz(overlap)
        pool = [database(idx,:);ranges(overlap,:)];
        newR = [min(pool,[],'all'),max(pool,[],'all')];
        ranges(overlap,:) = [];
        ranges = [ranges; newR];
    else
        ranges = [ranges; database(idx,:)];
    end
end
format longg
day5puzzle2result = sum(ranges(:,2) - ranges(:,1) + 1)
