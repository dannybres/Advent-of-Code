%% day23puzzle1 - Daniel Breslan - Advent Of Code 2024
data = readlines("input.txt").split("-");
nodes = unique(data(:));
parties = repmat("",1e5,3);
iidx = 1;
for n = nodes'
    o = data(any(n == data,2),:);
    o = o(:);
    o(o == n) = [];
    o = o + "-" + o';
    o = o (:);
    o = o(ismember(o(:),data.join("-")),:);
    if ~isempty(o)
        h = height(o);
        parties(iidx:iidx + h - 1,:) = ...
            [repmat(n,h,1), reshape(o.split("-"),[],2)];
        iidx = iidx + h;
    end
end
day23puzzle1result = nnz(any(unique(sort(...
    parties(1:iidx-1,:),2),'row').startsWith("t"),2))