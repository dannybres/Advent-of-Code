%% day5puzzle1 - Daniel Breslan - Advent Of Code 2019
% Instruction(instriction pointer) > opcode and 3 parameter
data = readlines("input.txt").split(",").double();

input = 1;

day2puzzle1result = runIntcode(data,input); %#ok<NOPTS> 

function result = runIntcode(data,input)

idx = 1;
while 1
    [opcode, modes] = decryptInstruction(data(idx));
    
    if opcode == 9
        break
    end
    
    parameters = data(idx+(1:numel(modes)));
    parameters(~modes) = data(parameters(~modes)+1);

    switch opcode
        case 1 
            data(1 + data(idx+3)) = sum(parameters(1:2));
        case 2
            data(1 + data(idx+3)) = prod(parameters(1:2));
        case 3 % input and saves it
            data(1 + data(idx+1)) = input;
        case 4 % outputs the value
            disp("output is " + parameters)
    end
    idx = idx + numel(modes) + 1;
    
end
result = data;
end

function [opcode, modes] = decryptInstruction(opcode)
   opcodeString = string(opcode);
   opcode = opcodeString.extractAfter(opcodeString.strlength-1).double;
   numberOfParameters = 3;
   if opcode > 2
       numberOfParameters = 1;
   end
   modes = fliplr(char(pad(opcodeString.extractBefore(max(1, ...
       opcodeString.strlength-1)),numberOfParameters,"left",'0')) == '1');
end
