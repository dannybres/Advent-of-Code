%% day18puzzle1 - Daniel Breslan - Advent Of Code 2024
data = readlines("input.txt").split(",").double();
day18puzzle1result = steps(1024,data)

function distance = steps(to,bytes)
dim = 70;
q = nan(1e4,3);
q(1,:) = [0 0 0];
qidx = 1;
qiidx = 1;
while 1
if exist('distance','var'),break,end
item = q(qidx,:);
if isnan(item(1)), break,end
cl = item(2:3);
cc = item(1);
for d = [-1 0; 1 0; 0 -1; 0 1]'
    dir = d';
    nl = cl + dir;
    if any(nl < 0) || any(nl > dim), continue, end
    if any(all(nl == bytes(1:to,:),2)), continue, end
    if any(all(nl == q(1:qiidx,2:3),2)), continue, end
    if all(nl == [dim dim]),distance = cc+1; end
    qiidx = qiidx + 1;
    q(qiidx,:) = [cc + 1, nl];
end
qidx = qidx + 1;
end
end
