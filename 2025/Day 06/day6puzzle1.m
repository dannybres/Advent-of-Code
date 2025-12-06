%% day6puzzle1 - Daniel Breslan - Advent Of Code 2025
data = strtrim(readlines("input.txt").replace("  "," ").replace("  "," ").replace("  "," ").replace("  "," ").replace("  "," ").replace("  "," ")).split(" ");

numbers = data(1:end-1,:).double();
operators = data(end,:);

functions = repmat({@sum},size(operators));
functions(operators == "*") = {@prod};

day6puzzle1result = 0;
for idx = 1:numel(functions)
    day6puzzle1result = day6puzzle1result + functions{idx}(numbers(:,idx));
end
day6puzzle1result