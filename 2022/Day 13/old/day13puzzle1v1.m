%% day13puzzle1 - Daniel Breslan - Advent Of Code 2022
data = readlines("inputDemo.txt").join(";").split(";;");

clc

for idx = 1:numel(data)
    pairStr = data(idx).split(";");
    pair = cell(2,1);
    for pidx = 1:numel(pairStr)
        pair(pidx) = processPair(pairStr(pidx));
    end

    warning("Pair: " + idx)
    disp(pair{1})
    disp(pair{2})

end


day13puzzle1result = 0;

function out = processPair(pairStr)
pidx = 1;
pair(pidx) = {pairStr(pidx).extractBefore(...
    strlength(pairStr(pidx))).extractAfter(1)};
[st, en] = regexp(pair{pidx},"^[\d,]+");
if ~isempty(st)
    startChars = pair{pidx}.extractBetween(st,en);
    if startChars.extract(strlength(startChars)) == ","
        startChars = startChars.extractBefore(...
            strlength(startChars));
    end
    pair{pidx} = pair{pidx}.eraseBetween(st,en);
    if pair{pidx} == ""
        pair{pidx} = cellstr(startChars.split(","))';
    else
        pair{pidx} = [cellstr(startChars.split(","))' pair(pidx)];
    end
end
if strlength(pair{pidx}{end}) ~= 1
    [st, en] = regexp(pair{pidx}{end},"[\d,]+$");
    if ~isempty(st)
        endChars = pair{pidx}(end);
        if class(endChars) == "cell"
            endChars = endChars{:};
        end
        endChars = endChars.extractBetween(st,en);
        if endChars.extract(1) == ","
            endChars = endChars.extractAfter(1);
        end
        finalPart = pair{pidx}(end);
        if class(finalPart) == "cell"
            finalPart = finalPart{:};
        end
        valueWithoutEnd = finalPart.eraseBetween(st,en);
        if class(pair{pidx}) == "string"
            pair{pidx} = valueWithoutEnd;
        else
            pair{pidx}{end} = valueWithoutEnd;
        end

        if pair{pidx}{end} == ""
            pair{pidx} = cellstr(endChars.split(","))';
        else
            pair{pidx} = [pair{pidx} cellstr(endChars.split(","))'];
        end
    end
end
if class(pair{1})  == "string"
    pair{1} = cellstr(pair{1});
end
out = pair;
if any(cellfun(@(x) string(x).contains("["),out{:}))
    disp(out{:}{cellfun(@(x) string(x).contains("["),out{:})})
end
end