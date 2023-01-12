%% day17puzzle1 - Daniel Breslan - Advent Of Code 2019
addpath("../intCodeComputer/")
data = readlines("inputDemo.txt").split(",").double();
out = processIntCodeComputer(data);
sizeOfRow = find(out == 10,1) -1;
out(out == 10) = [];
out = reshape(out,sizeOfRow,[]);
map = repmat(' ',size(out));
map(out == 35) = '#';
map(out == 94) = 'X';
map = map';
gauge = zeros(3);
gauge([2 4 5 6 8]) = 1;
intersects = conv2(map == '#',gauge,"same") == 5;
map(intersects) = 'O';
[r,c] = ind2sub(size(map),find(intersects));
day17puzzle1result = sum((r - 1) .* (c - 1)) %#ok<NOPTS> 