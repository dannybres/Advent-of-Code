function [outputs, data, idx, terminated] = runIntcode(data,input,...
    numOutputs,idx)
if nargin < 3
    numOutputs = Inf;
    idx = 1;
end



terminated = false;
inputIdx = 1;
outputs = nan;
relativeBase = 0;

while 1
    [opcode, modes] = decryptInstruction(data(idx));
    if opcode == 99
        terminated = true;
        break
    end

    parameters = data(idx+(1:numel(modes)));
    if max(parameters(0 == modes)+1) > numel(data)
        data(max(parameters(0 == modes)+1)) = 0;
    end
    parameters(0 == modes) = data(parameters(0 == modes)+1);

    if sum(modes == 2) > 0
        parameters(2 == modes) = data(parameters(2 == modes) + ...
            relativeBase + 1);
    end
%     disp("idx:" + idx + ", opcode:" + opcode + ", modes:" + string(modes).join(",") ...
%         + ", parameters:" + string(parameters).join(",") + ", relativeBase:" + string(relativeBase).join(","))

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
%             disp("outputoutputoutputoutputoutputoutputoutput is " + parameters)
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
            data(1 + parameters(3)) = parameters(1) < parameters(2);
        case 8
            data(1 + parameters(3)) = parameters(1) == parameters(2);
        case 9
            relativeBase = relativeBase + parameters;
    end

    if autoIncrement
        idx = idx + numel(modes) + 1;
    end

end
end

function [opcode, modes] = decryptInstruction(opcode)
opcodeString = string(opcode);
opcode = opcodeString.extractAfter(max(0,opcodeString.strlength-2)).double;
numberOfParametersOptions = [3 3 1 1 2 2 3 3 1];
numberOfParameters = 0;
if opcode < 10
    numberOfParameters = numberOfParametersOptions(opcode);
end

modes = fliplr(char(pad(opcodeString.extractBefore(max(1,...
    opcodeString.strlength-1)),numberOfParameters,"left",'0')));
modes = string(modes).split("").double';
modes = modes(2:end-1);

end