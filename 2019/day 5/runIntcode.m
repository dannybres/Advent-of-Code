function [outputs, data, idx, terminated] = runIntcode(data,input,...
    numOutputs,idx)
if nargin < 3
    numOutputs = Inf;
    idx = 1;
end

terminated = false;
inputIdx = 1;
outputs = nan;
while 1
    [opcode, modes] = decryptInstruction(data(idx));

    if opcode == 9

        terminated = true;
        break
    end

    parameters = data(idx+(1:numel(modes)));
    parameters(~modes) = data(parameters(~modes)+1);

    autoIncrement = true;

    switch opcode
        case 1
            data(1 + data(idx+3)) = sum(parameters(1:2));
        case 2
            data(1 + data(idx+3)) = prod(parameters(1:2));
        case 3 % input and saves it
            data(1 + data(idx+1)) = input(inputIdx);
            inputIdx = inputIdx + 1;
        case 4 % outputs the value
%             disp("output is " + parameters)
            if isnan(outputs)
                outputs = parameters;
            else
                outputs = [outputs; parameters]; %#ok<AGROW> 
            end
            if numel(outputs) == numOutputs
                idx = idx + numel(modes) + 1;
                return
            end
        case 5
            if parameters(1) ~= 0
                idx = parameters(2)+1;
                autoIncrement = false;
            end
        case 6
            if parameters(1) == 0
                idx = parameters(2)+1;
                autoIncrement = false;
            end
        case 7
            data(1 + data(idx+3)) = parameters(1) < parameters(2);
        case 8
            data(1 + data(idx+3)) = parameters(1) == parameters(2);
    end

    if autoIncrement
        idx = idx + numel(modes) + 1;
    end

end
end

function [opcode, modes] = decryptInstruction(opcode)
opcodeString = string(opcode);
opcode = opcodeString.extractAfter(opcodeString.strlength-1).double;
numberOfParameters = [3 3 1 1 2 2 3 3 0];
numberOfParameters = numberOfParameters(opcode);

modes = fliplr(char(pad(opcodeString.extractBefore(max(1,...
    opcodeString.strlength-1)),numberOfParameters,"left",'0')) == '1');
end