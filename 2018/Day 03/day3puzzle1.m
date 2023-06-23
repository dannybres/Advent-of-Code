%% day3puzzle1 - Daniel Breslan - Advent Of Code 2018
data = readlines("input.txt");

out = regexp(data,"#\d+ @ (\d+),(\d+): (\d+)x(\d+)", 'tokens');

sz = 1000;
% sz = 2000;
check = zeros(sz,sz);

for idx = 1:numel(out)
    info = double(out{idx}{1});
    [r,c] = meshgrid(1:info(4), 1:info(3));
    r = r + info(2);
    c = c + info(1);

    check(sub2ind(size(check),r,c)) = check(sub2ind(size(check),r,c)) + 1;

end

day3puzzle1result = sum(check > 1,"all")
