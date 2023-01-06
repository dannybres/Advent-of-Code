function [outputs, data, idx, terminated] = processIntCodeComputer(data,input,...
    numOutputs,idx)
if nargin < 3
    numOutputs = Inf;
    idx = 0;
end

if class(data) == "double"
    data = dictionary(0:numel(data)-1,data');
end

idx = 0;
outputs = nan;
inputIdx = 1;
% relativeBase = 0;
terminated = false;

while 1
    autoIncrement = true;
    [opcode, modes, idxOfMemorySavePosition] = decryptInstruction(data(idx));
    if opcode == 99
        terminated = true;
        break
    end
    parameters = zeros(1,numel(modes));
    for paraIdx = 1:numel(parameters)
        thisParameter = data(idx + paraIdx);
        switch modes(paraIdx)
            case 0 % position
                if any(idxOfMemorySavePosition == paraIdx)
                    parameters(paraIdx) = thisParameter;
                else
                    parameters(paraIdx) = data(thisParameter);
                end
            case 1 % immediate
                parameters(paraIdx) = thisParameter;
        end
    end
    switch opcode
        case 1 % sum
            data(parameters(3)) = sum(parameters(1:2));
        case 2 % prod
            data(parameters(3)) = prod(parameters(1:2));
        case 3 % input
            data(parameters) = input(inputIdx);
            inputIdx = inputIdx + 1;
        case 4 % output
            if isnan(outputs)
                outputs = parameters;
            else
                outputs = [outputs; parameters]; %#ok<AGROW>
            end
        case 5 % Jump if true
            if parameters(1) ~= 0
                idx = parameters(2);
                autoIncrement = false;
            end
        case 6 % Jump if false
            if parameters(1) == 0
                idx = parameters(2);
                autoIncrement = false;
            end
        case 7 % Less than
            data(parameters(3))  = parameters(1) < parameters(2);
        case 8 % equals
            data(parameters(3))  = parameters(1) == parameters(2);
    end
    if autoIncrement
        idx = idx + numel(modes) + 1;
    end
end
end

function [opcode, modes, idxOfMemorySavePosition] = decryptInstruction(opcode)
opcodeString = string(opcode);
opcode = opcodeString.extractAfter(max(0,opcodeString.strlength-2)).double;
numberOfParametersOptions = [3 3 1 1 2 2 3 3 1];
idxOfMemorySavePositionOptions = [3 3 1 nan nan nan 3 3];
numberOfParameters = 0;
idxOfMemorySavePosition = 0;
if opcode < 10
    idxOfMemorySavePosition = idxOfMemorySavePositionOptions(opcode);
    numberOfParameters = numberOfParametersOptions(opcode);
end

modes = fliplr(char(pad(opcodeString.extractBefore(max(1,...
    opcodeString.strlength-1)),numberOfParameters,"left",'0')));
modes = string(modes).split("").double';
modes = modes(2:end-1);

end