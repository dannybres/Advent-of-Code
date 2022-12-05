%% day16puzzle2 - Daniel Breslan - Advent Of Code 2021
data = readlines("input.txt");

in = char(string(dec2bin(hex2dec(char(data)'))).join(""));
[op,~] = processBinary (in);
format long g
val = valueOfStruct(op)

function [op,remaining] = processBinary(in)
[op.ver, op.type, remaining] = getVerAndType(in);
if op.type == 4
    [op.child, remaining] = getLiteral(remaining);
else
    [op.lengthTypeID, remaining] = getLengthTypeID(remaining);
    [op.length, remaining] = getLength(remaining, op.lengthTypeID);
    if op.lengthTypeID % next 15 bits represents the total length in bits
        op.child = {};
        for idx = 1:op.length
            [op.child{end+1},remaining] = processBinary(remaining);
        end
    else % 11 bits represents the number of sub-packets immediately contained
        lengthBefore = numel(remaining);
        op.child = {};
        while lengthBefore - numel(remaining) < op.length
            [op.child{end+1},remaining] = processBinary(remaining);
        end
    end
end
end

function [ver, type, remaining] = getVerAndType(in)
ver = bin2dec(in(1:3));
type = bin2dec(in(4:6));
remaining = in(7:end);
end

function [child, remaining] = getLiteral(remaining)
out = string(reshape(char(padarray(double(remaining),[0 5*ceil(numel(remaining)/5) ...
    - numel(remaining)],double('0'),'post')),5,[])');
lasts = find(out.extractBefore(2) == "0");
used = lasts(1)*5;
child = bin2dec(out(1:lasts(1)).extractAfter(1).join(""));
remaining = remaining(used+1:end);
end

function [lengthTypeID, remaining] = getLengthTypeID(remaining)
lengthTypeID = str2double(remaining(1));
remaining = remaining(2:end);
end

function [length, remaining] = getLength(remaining, lengthTypeID)
if lengthTypeID == 0
    numbits = 15;
else
    numbits = 11;
end
length = bin2dec(remaining(1:numbits));
remaining = remaining(numbits+1:end);
end

function out = valueOfStruct(in)
while true
    if iscell(in.child)
        isBottomLevel = all(cellfun(@isnumeric, in.child));
        if isBottomLevel
            in.child = cell2mat(in.child);
        end
    end
    if isnumeric(in.child)
        switch in.type
            case 0
                out = sum(in.child);
            case 1
                out = prod(in.child);
            case 2
                out = min(in.child);
            case 3
                out = max(in.child);
            case 4
                out = in.child;
            case 5
                out = double(in.child(1)>in.child(2));
            case 6
                out = double(in.child(1)<in.child(2));
            case 7
                out = double(in.child(1)==in.child(2));
            otherwise

        end
        return
    else
        for idx = 1:numel(in.child)
            in.child{idx} = valueOfStruct(in.child{idx});
        end
    end
end
end