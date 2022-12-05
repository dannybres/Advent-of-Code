%% day18puzzle1 - Daniel Breslan - Advent Of Code 2021
clear, clc
in = readlines("inputDemo.txt");
for idx = 1:numel(in)
    if ~exist('data','var')
        data = in(1);
        continue
    end
data = sumAndReduceMe(data + " + " + in(idx));
end
day18puzzle1result = magnitudeCalculator(data) %#ok<NOPTS> 

function data = sumAndReduceMe(data)
data = "[" + data.replace(" + ",",") + "]";
oldData = "";
while oldData ~= data
    oldData = data;
    d = data.split("");
    d = d(2:end-1);
    numIdx = all(d ~= ["[","]",","],2);
    numIdx = find(numIdx(1:end-1) & numIdx(2:end));
    d(numIdx) = d(numIdx) + d(numIdx+1);
    d(numIdx+1) = [];

    lettersToFind = ["[","]",","];

    t = array2table(d == lettersToFind,VariableNames=lettersToFind);
    t = [table(d,VariableNames={'char'}) t ...
        table(~any(t{:,:},2),VariableNames={'num'})]; %#ok<*AGROW> 
    t = [t table(cumsum(double(t.("["))) - ...
        cumsum(double(t.("]"))),VariableNames={'numBrack'})];
    t = [t table((1:height(t))',VariableNames={'idx'})];

    explodeIdx = find(t.numBrack>4 & t.num);
    clear explodeNum
    if numel(explodeIdx)>1
        for eidx = 1:numel(explodeIdx)-1
            if t.char(explodeIdx(eidx)+(-1:2:3)).join("") == "[,]" && explodeIdx(eidx+1) == explodeIdx(eidx)+2
                explodeNum = t.char(explodeIdx(eidx:eidx+1)).double();
                explodeIdx = explodeIdx(eidx:eidx+1);
                break
            end
        end
    end
    if exist('explodeNum','var')
        allnumbers = find(t.num);
        lhsIdx = allnumbers(allnumbers<explodeIdx(1));
        if numel(lhsIdx)>1
            lhsIdx = lhsIdx(end);
        end

        rhsIdx = allnumbers(allnumbers>explodeIdx(2));
        if numel(rhsIdx)>1
            rhsIdx = rhsIdx(1);
        end

        t.char(rhsIdx) = t.char(rhsIdx).double() + explodeNum(2);
        t.char(lhsIdx) = t.char(lhsIdx).double() + explodeNum(1);

        data = t.char;
        data(explodeIdx(1)-1) = 0;
        data(explodeIdx(1):explodeIdx(2)+1) = [];
        data = data.join("");
        continue
    end
    splits = [t{t.num,"char"}.double() t{t.num,"idx"}];
    splits = splits(splits(:,1)>9,:);
    if ~isempty(splits)
        splits = splits(1,:);
        newValue = "[" + floor(splits(1)/2) + "," + ceil(splits(1)/2) + "]";
        data = t.char;
        data(splits(2)) = newValue;
        data = data.join("");
    end
end
end

function out = magnitudeCalculator(in)
[st, en] = regexp(in,"\[\d+,\d+\]");
while ~isempty(st)
    for idx = numel(st):-1:1
        value = in.extractBetween(st(idx),en(idx)).erase(["[","]"]).split(",").double()';
        value = value * [3;2];
        in = in.eraseBetween(st(idx),en(idx)).insertAfter(st(idx)-1,string(value));
    end
    [st, en] = regexp(in,"\[\d+,\d+\]");
end
out = in.double();
end