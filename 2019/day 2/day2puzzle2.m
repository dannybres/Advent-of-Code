%% day2puzzle2 - Daniel Breslan - Advent Of Code 2019
% Instruction(instriction pointer) > opcode and 3 parameter

dataOriginal = readlines("input.txt").split(",").double();
options = [repelem(0:99,1,99); repmat(0:99,1,99)];
for optIdx = options
    data = dataOriginal;
    data(2:3) = optIdx;
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
    if data(1) == 19690720
        break
    end
end
day2puzzle2result = sum(optIdx .* [100; 1]) %#ok<NOPTS> 