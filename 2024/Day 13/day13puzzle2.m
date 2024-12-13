%% day13puzzle2 - Daniel Breslan - Advent Of Code 2024
ddata = readlines("input.txt");
day13puzzle2result = 0;
for idx = 1:4:numel(data)
    nums = double([data(idx).extractBetween("X",",") data(idx).extractAfter("Y") data(idx+1).extractBetween("X",",") data(idx+1).extractAfter("Y") data(idx+2).extractBetween("X=",",") data(idx+2).extractAfter("Y=")]);
    nums(5:6) = nums(5:6) + 10000000000000;
    presses = nums([1 3;2 4]) \ nums([5 6])';
    if all(abs(presses - round(presses)) < 1e-3)
        day13puzzle2result = day13puzzle2result + sum(presses .* [3;1]);
    end
end
day13puzzle2result 