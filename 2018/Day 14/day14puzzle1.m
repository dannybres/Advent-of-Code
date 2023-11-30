%% day14puzzle1 - Daniel Breslan - Advent Of Code 2018

n = 170641;
r = [3 7];
e = [1 2];
while numel(r) < n + 10
    new = string(sum(r(e))).split("").double()';
    r = [r new(2:end-1)];
    e = mod(e + r(e) + 1,numel(r));
    e(e == 0) = numel(r);
end

day14puzzle1result = string(r(n+1:n+10)).join("").double();
