%% day1puzzle2 - Daniel Breslan - Advent Of Code 2023
data = readlines("input.txt");
for idx = 1:2
    data = data.replace(["one","two","three","four","five", ...
        "six","seven","eight","nine"],...
        ["o1e", "t2o", "t3e", "4", "5e", "6", "7n", "e8t", "9e"]);
end
nums = regexp(data,"\d",'match');
fun = @(x) x([1 end]).join("").double;
day1puzzle1result = sum(cell2mat(cellfun(fun,nums,UniformOutput=false))) %#ok<NOPTS> 