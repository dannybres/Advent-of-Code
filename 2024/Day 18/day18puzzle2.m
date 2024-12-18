%% day18puzzle2 - Daniel Breslan - Advent Of Code 2024
profile on
data = readlines("input.txt").split(",").double();
dim = 71;
n = height(data);
map = true(dim,dim,n);
for idx = 1:height(data)
    map(sub2ind(size(map),1+data(1:idx,1),1+data(1:idx,2),idx)) = false;
end
reachable = false(size(map,1),size(map,2),n);
reachable(1,1,:) = 1;
m = [0 1 0; 1 1 1; 0 1 0];
for idx = size(reachable,3):-1:1
    while true
        seen = nnz(reachable(:,:,idx));
        reachable(:,:,idx) = conv2(reachable(:,:,idx),m,'same') & map(:,:,idx);
        if seen == nnz(reachable(:,:,idx))
            break
        end
    end
    if reachable(end,end,idx)
        break
    end
end
day18puzzle2result = string(data(idx+1,:)).join(",")
profile viewer