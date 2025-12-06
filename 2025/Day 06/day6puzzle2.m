%% day6puzzle2 - Daniel Breslan - Advent Of Code 2025
data = char(readlines("input.txt"))';

number = [str2double(strtrim(string(data(:,1:end-1))));nan];
operators = string(data(:,end));

day6puzzle1result = 0;
for idx = 1:numel(number)
    if isnan(number(idx))
        day6puzzle1result = day6puzzle1result + soFar;
        continue
    end
    switch operators(idx)
        case "+"
            f = @sum; soFar = 0;
        case "*"
            f = @prod; soFar = 1;
    end
    soFar = f([soFar,number(idx)]);
end
format longg
day6puzzle1result