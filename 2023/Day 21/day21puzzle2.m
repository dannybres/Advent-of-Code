%% day21puzzle2 - Daniel Breslan - Advent Of Code 2023
clc
map = char(readlines("input.txt"));
w = size(map,1);
% n = 26501365
n = 131+131+65+131+131
afterFirst = n - floor(w/2)
nmore = afterFirst / w

map(map == 'S') = '.';
map = repmat(map,2*nmore+1,2*nmore+1);

map(ceil(numel(map)/2)) = 'S';
[rr, rc] = find(map == '#');
rr = [rr rc];
[gr,gc] = find(map == 'S');

g = [gr gc];

rqq = nan(numel(1:65 + w * nmore),1);

for idx = 1:65 + w * nmore
    g = pagetranspose(g + reshape([0 1 1 0 -1 0 0 -1],1,2,4));
    g = reshape(g,2,[],1)';
    g = unique(g,"rows");
    g = g(~ismember(g,rr,"rows"),:);
    rqq(idx) = height(g);
end

map(sub2ind(size(map),g(:,1),g(:,2))) = 'o';

rr = nan(2*nmore+1);
for ri = 1:size(rr,1)
    for ci = 1:size(rr,2)
        rr(ri,ci) = nnz(map((ri-1)*w+1:ri*w, (ci-1)*w+1:ci*w) == 'o');
    end
end

o = rr(5,5);
e = rr(5,4);
tl = rr(4);
tr = rr(2,7);
bl = rr(6);
br = rr(7,8);
itl = rr(3,3);
itr = rr(3,7);
ibl = rr(6,2);
ibr = rr(7,7);
t = rr(1,5);
b = rr(9,5);
l = rr(5,1);
r = rr(5,9);

n = 26501365
afterFirst = n - floor(w/2)
nmore = afterFirst / w

ne = nmore^2;
no = (nmore-1)^2;
sum(rr==itl,"all")
sum(rr==itr,"all")
day21puzzle2result = t + b + l + r + no * o + ne * e + nmore * (tr+tl+br+bl) + (nmore - 1) * (itr+itl+ibr+ibl) 
