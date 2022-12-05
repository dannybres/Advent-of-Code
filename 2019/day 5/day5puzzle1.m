%% day5puzzle1 - Daniel Breslan - Advent Of Code 2019
clc

data = readlines("input.txt");
data = double(data.split(","));

numberOfParametersForIns = [3 3 1 1 2 2 3 3];

start = 1;
input = 5;

% disp(data')

while start < numel(data)
    clear mode
    stopAdvance = false;
    instruction = data(start);
    if instruction < 100
        opcode = instruction;
    else
        opcode = rem(instruction,100);
        mode = floor(instruction/100);
    end
    if opcode == 99
        return
    end
    lengthOfParam = numberOfParametersForIns(opcode);
    if ~exist("mode","var")
        indexes = data(start+1:start+min(2,lengthOfParam));
        parameters = data(indexes + 1);
    else
        immediate = num2str(mode) == '1';
        immediate = padarray(immediate',min(2,lengthOfParam) ...
            - numel(immediate),false,'pre')';
        immediate = fliplr(immediate);
        indexes = data(start+1:start+min(2,lengthOfParam));
        parameters = data(min(8,max(0,indexes)) + 1);
        parameters = indexes' .* immediate + ...
            parameters' .* ~immediate;
    end

    if opcode == 1
        data(data(start+3)+1) = sum(parameters);
    elseif opcode == 2
        data(data(start+3)+1) = prod(parameters);
    elseif opcode == 3
        data(indexes + 1) = input;
    elseif opcode == 4
        disp(parameters)
    elseif opcode == 5
        if parameters(1)
            start = parameters(2) + 1;
            continue
        end
    elseif opcode == 6
        if ~parameters(1)
            start = parameters(2) + 1;
            continue
        end
    elseif opcode == 7
        data(data(start+3)+1) = diff(parameters) > 0;
        stopAdvance = data(start+3)+1 == start;
    elseif opcode == 8
        data(data(start+3)+1) = diff(parameters) == 0;
        stopAdvance = data(start+3)+1 == start;
    else
        error('000')
    end

    if stopAdvance
        stopAdvance
    end

    start = start + lengthOfParam + 1;
%     disp(data')
end

day5puzzle1result = 0;
