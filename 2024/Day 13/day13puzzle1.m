%% day13puzzle1 - Daniel Breslan - Advent Of Code 2024
data = readlines("input.txt");
day13puzzle1result = 0;
for idx = 1:4:numel(data)
    nums = double([data(idx).extractBetween("X",",") data(idx).extractAfter("Y") data(idx+1).extractBetween("X",",") data(idx+1).extractAfter("Y") data(idx+2).extractBetween("X=",",") data(idx+2).extractAfter("Y=")]);
    presses = nums([1 3;2 4]) \ nums([5 6])';
    if all(abs(presses - round(presses)) < 1e-3)
        day13puzzle1result = day13puzzle1result + sum(presses .* [3;1]);
    end
end
day13puzzle1result 