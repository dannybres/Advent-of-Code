%% day6puzzle1 - Daniel Breslan - Advent Of Code 2022
n = 4;
data = repmat(double(char(readlines("input.txt"))),n,1);

for idx = 2:n
data(idx,:) = circshift(data(1,:),idx-1);
end

foo = sum(mode(data) == data);
foo(1:n-1) = 0;

day6puzzle2result = find(foo == 1,1)