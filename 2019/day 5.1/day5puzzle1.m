%% day5puzzle1 - Daniel Breslan - Advent Of Code 2019
% Instruction(instriction pointer) > opcode and 3 parameter
data = readlines("input.txt").split(",").double();
data(2:3) = [12 2];

day2puzzle1result = runIntcode(data) %#ok<NOPTS> 

function result = runIntcode(data)
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
result = data(1);
end