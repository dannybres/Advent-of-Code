%% day14puzzle2 - Daniel Breslan - Advent Of Code 2018

n = string("170641").split("").double()';
n = n(2:end-1);
r = nan(1,25e6);
r(1:2) = [3 7];
next = 3;
e = [1 2];

while true
% for a = 1:15
    new = string(sum(r(e))).split("").double()';
    new = new(2:end-1);
    r(next:next+numel(new)-1) = new;
    next = next + numel(new);
    e = mod(e + r(e) + 1,next-1);
    e(e == 0) = next-1;
    if numel(n) < next - 1
        if all(r(next-numel(n):next-1) == n) || all(r(next-numel(n)-1:next-2) == n)
            break
        end
    end
end



if all(r(next-numel(n):next-1) == n)
    day14puzzle2result = next - 1 - numel(n) %#ok<NOPTS> 
else
    day14puzzle2result = next - 2 - numel(n) %#ok<NOPTS> 
end