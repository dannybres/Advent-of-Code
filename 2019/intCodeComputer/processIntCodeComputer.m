function [outputs, data, nextMemoryAddress, terminated, relativeBase] = processIntCodeComputer(data,input,...
    numOutputs,nextMemoryAddress, relativeBase)
if nargin < 3
    numOutputs = Inf;
    nextMemoryAddress = 0;
    relativeBase = 0;
end
if class(data) == "double"
    data = dictionary(0:numel(data)-1,data');
end

outputs = nan;
inputIdx = 1;
terminated = false;

while 1
    autoIncrement = true;
    [opcode, modes, idxOfMemorySavePosition] = decryptInstruction(data(nextMemoryAddress));
    if opcode == 99
        terminated = true;
        break
    end
    parameters = zeros(1,numel(modes));
    for paraIdx = 1:numel(parameters)
        thisParameter = data(nextMemoryAddress + paraIdx);
        switch modes(paraIdx)
            case 0 % position
                if any(idxOfMemorySavePosition == paraIdx)
                    parameters(paraIdx) = thisParameter;
                else
                    if ~isKey(data,thisParameter)
                        data(thisParameter) = 0;
                    end
                    parameters(paraIdx) = data(thisParameter);
                end
            case 1 % immediate
                parameters(paraIdx) = thisParameter;
            case 2 %relative
                if any(idxOfMemorySavePosition == paraIdx)
                    parameters(paraIdx) = thisParameter + relativeBase;
                else
                    if ~isKey(data,thisParameter + relativeBase)
                        data(thisParameter + relativeBase) = 0;
                    end
                    parameters(paraIdx) = data(thisParameter + relativeBase);
                end
        end
    end
    switch opcode
        case 1 % sum
            data(parameters(3)) = sum(parameters(1:2));
        case 2 % prod
            data(parameters(3)) = prod(parameters(1:2));
        case 3 % input
            if inputIdx > numel(input)
                nextMemoryAddress = nextMemoryAddress + numel(modes) + 1;
                return
            end
            data(parameters) = input(inputIdx);
            inputIdx = inputIdx + 1;
        case 4 % output
            if isnan(outputs)
                outputs = parameters;
            else
                outputs = [outputs; parameters]; %#ok<AGROW>
            end
            if numel(outputs) == numOutputs
                nextMemoryAddress = nextMemoryAddress + numel(modes) + 1;
                return
            end
        case 5 % Jump if true
            if parameters(1) ~= 0
                nextMemoryAddress = parameters(2);
                autoIncrement = false;
            end
        case 6 % Jump if false
            if parameters(1) == 0
                nextMemoryAddress = parameters(2);
                autoIncrement = false;
            end
        case 7 % Less than
            data(parameters(3))  = parameters(1) < parameters(2);
        case 8 % equals
            data(parameters(3))  = parameters(1) == parameters(2);
        case 9
            relativeBase = relativeBase + parameters;
    end
    if autoIncrement
        nextMemoryAddress = nextMemoryAddress + numel(modes) + 1;
    end
end
end

function [opcode, modes, idxOfMemorySavePosition] = decryptInstruction(opcode)
opcodeString = string(opcode);
opcode = opcodeString.extractAfter(max(0,opcodeString.strlength-2)).double;
numberOfParametersOptions = [3 3 1 1 2 2 3 3 1];
idxOfMemorySavePositionOptions = [3 3 1 nan nan nan 3 3 nan];
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