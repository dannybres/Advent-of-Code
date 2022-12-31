%% day2puzzle1 - Daniel Breslan - Advent Of Code 2019
data = readlines("input.txt").split(",").double();

data(2:3) = [12 2];

for idx = 1:4:numel(data)
    switch data(idx)        
        case 1
            fun = @sum;
        case 2
            fun = @prod;
        case 99
            break
    end
    data(data(idx+3)+1) = fun(data(data(idx+(1:2))+1));
end

day2puzzle1result = data(1) %#ok<NOPTS> 