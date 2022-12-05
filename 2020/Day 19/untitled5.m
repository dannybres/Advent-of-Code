a = [1 3 5 3 1]
up(a)

function out = up(a)
index = 1:numel(a);
newidx = movmean(index,2,'Endpoints','discard');
newa = movmean(a,2,'Endpoints','discard');
[~,idx] = sort([index newidx]);
out = [a newa];
out = out(idx);
end