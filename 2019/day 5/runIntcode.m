function [outputs, data, idx, terminated] = runIntcode(data,input,...
    numOutputs,idx)
if nargin < 3
    numOutputs = Inf;
    idx = 0;
end
if class(data) == "double"
    data = dictionary(0:numel(data)-1,data');
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
    parameters = zeros(1,numel(modes));
    for paraIdx = 1:numel(parameters)
        thisParameter = data(idx + paraIdx);
        switch modes(paraIdx)
            case 0 % position
                memoryAddress = thisParameter;
                if ~isKey(data, memoryAddress)
                    data(memoryAddress) = 0;
                end
                if paraIdx == numel(parameters) && opcode ~= 4 && opcode ~= 9
                    parameters(paraIdx) = memoryAddress;
                else
                    parameters(paraIdx) = data(memoryAddress);
                end
            case 1 % imediate
                parameters(paraIdx) = thisParameter;
            case 2 % relative
                memoryAddress = relativeBase + thisParameter;
                if memoryAddress < 0
                    error("negative memory address")
                end
                if ~isKey(data, memoryAddress)
                    data(memoryAddress) = 0;
                end
                if paraIdx == numel(parameters) && opcode ~= 4 && opcode ~= 9
                    parameters(paraIdx) = memoryAddress;
                else
                    parameters(paraIdx) = data(memoryAddress);
                end
        end
%         if (opcode == 1 || opcode == 2 || opcode == 3 || opcode == 7 || opcode == 8) && paraIdx == numel(parameters) && modes(paraIdx) ~= 1
%             parameters(paraIdx) = memoryAddress;
%         end
    end

    autoIncrement = true;
    switch opcode
        case 1 % adds
            data(parameters(end)) = sum(parameters(1:2));
        case 2 % product
            data(parameters(end)) = prod(parameters(1:2));
        case 3 % input
            data(parameters(end)) = input(inputIdx);
            inputIdx = inputIdx + 1;
        case 4 % output
            if isnan(outputs)
                outputs = parameters;
            else
                outputs = [outputs; parameters]; %#ok<AGROW>
            end
            if numel(outputs) == numOutputs
                idx = idx + numel(modes) + 1;
                return
            end
        case 5 % jump if true
            if parameters(1) ~= 0
                idx = parameters(end);
                autoIncrement = false;
            end
        case 6 % jump-if-false
            if parameters(1) == 0
                idx = parameters(end);
                autoIncrement = false;
            end
        case 7 % less than
            data(parameters(end))  = parameters(1) < parameters(2);
        case 8 % equal
            data(parameters(end))  = parameters(1) == parameters(2);
        case 9 % relativeBase change
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