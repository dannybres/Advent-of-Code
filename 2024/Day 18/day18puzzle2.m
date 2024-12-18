%% day18puzzle2 - Daniel Breslan - Advent Of Code 2024
data = readlines("input.txt").split(",").double();
dim = 71;

%% convolution approach
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


%% Binary search
lo = 1;
hi = height(data);

while hi > lo
    mid = floor((hi+lo)/2);
    if isConnected(mid,data)
        lo = mid + 1;
    else
        hi = mid;
    end
end
day18puzzle2result = string(data(lo,:)).join(",")

function connected = isConnected(to,bytes)
connected = false;
dim = 70;
q = nan(1e4,2);
q(1,:) = [0 0];
qidx = 1;
qiidx = 1;
while 1
if exist('distance','var'),break,end
item = q(qidx,:);
if isnan(item(1)), break,end
cl = item(1:2);
for d = [-1 0; 1 0; 0 -1; 0 1]'
    dir = d';
    nl = cl + dir;
    if any(nl < 0) || any(nl > dim), continue, end
    if any(all(nl == bytes(1:to,:),2)), continue, end
    if any(all(nl == q(1:qiidx,:),2)), continue, end
    if all(nl == [dim dim]),connected = true; return; end
    qiidx = qiidx + 1;
    q(qiidx,:) = nl;
end
qidx = qidx + 1;
end
end