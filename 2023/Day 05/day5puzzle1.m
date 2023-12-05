%% day5puzzle1 - Daniel Breslan - Advent Of Code 2023
data = readlines("inputDemo.txt");
seeds = data(1).extract(digitsPattern).double;
data = data(3:end);
points = [[1;find(data == "")+1],[find(data == "")-1;numel(data)]];
loc = seeds;
for idx = 1:height(points)
    m = data(points(idx,1)+1:points(idx,2)).extract(digitsPattern).double;
    m(:,4) = m(:,2) + m(:,3) - 1;
    shift = diff(m(:,2:-1:1),[],2);
    tf = loc>=m(:,2)' & loc <=m(:,4)';
    loc = loc + tf * shift;
end
min(loc)

day5puzzle1result = 0;
