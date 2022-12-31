%% day5puzzle1 - Daniel Breslan - Advent Of Code 2019
% Instruction(instriction pointer) > opcode and 3 parameter
data = readlines("inputDemo.txt").split(",").double();
data(2:3) = [12 2];

day2puzzle1result = runIntcode(data) %#ok<NOPTS> 

function result = runIntcode(data)

idx = 1;
while 1

    data(idx)

    switch data(idx)
        case 1
            fun = @sum;
            numberOfParams = 3;
            destination = data(idx+3)+1;
            parameters = data(data(idx+(1:2))+1);
        case 2
            fun = @prod;
            numberOfParams = 3;
            destination = data(idx+3)+1;
            parameters = data(data(idx+(1:2))+1);
        case 3

        case 4

        case 99
            break
    end
    data(destination) = fun(parameters);
    idx = idx + numberOfParams + 1;
end
result = data(1);
end