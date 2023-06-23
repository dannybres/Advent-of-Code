%% day3puzzle2 - Daniel Breslan - Advent Of Code 2018
data = readlines("input.txt");

out = regexp(data,"#(\d+) @ (\d+),(\d+): (\d+)x(\d+)", 'tokens');

sz = 1000;
% sz = 2000;
check = zeros(sz,sz);

for idx = 1:numel(out)
    info = double(out{idx}{1});
    [r,c] = meshgrid(1:info(5), 1:info(4));
    r = r + info(3);
    c = c + info(2);

    check(sub2ind(size(check),r,c)) = check(sub2ind(size(check),r,c)) + 1;

end

for idx = 1:numel(out)
    info = double(out{idx}{1});
    [r,c] = meshgrid(1:info(5), 1:info(4));
    r = r + info(3);
    c = c + info(2);

    thisClaim = check(sub2ind(size(check),r,c));

    if all(thisClaim == 1)
        break
    end
end

day3puzzle1result = info(1) %#ok<NOPTS> 

%% 98923 - too low



day3puzzle2result = 0;
