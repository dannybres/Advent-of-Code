%% day6puzzle1 - Daniel Breslan - Advent Of Code 2022
data = double(char(readlines("input.txt")));

n = 4;

a = repmat(1:size(data,2),n,1);
a = a - (0:size(a,1)-1)';
a(a<1) = 1;
setOfData = data(a);

foo = sum(mode(setOfData) == setOfData);
foo(1:n-1) = 0;

day6puzzle1result = find(foo == 1,1)