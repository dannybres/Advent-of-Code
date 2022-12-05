%% day10puzzle2 - Daniel Breslan - Advent Of Code 2021
data = readlines("input.txt");
illegal = ["(","<","[","{"] + [")",">","]","}"]';
illegal(logical(eye(size(illegal)))) = "";
illegal = reshape(illegal,1,[]);
illegal(illegal == "") = [];
lastlength = 0;

reducedData = data;
while lastlength ~= reducedData.join.strlength
    lastlength = reducedData.join.strlength;
    reducedData = reducedData.erase("()").erase("[]").erase("<>").erase("{}");
end

incompleteData = reducedData(~reducedData.contains(illegal));
format long g
day10puzzle2result = median(arrayfun(@processLine,incompleteData))
format short

function score = processLine(in)
    in = in.split("");
    in = in(2:end-1);
    in = flipud(in);
    score = 0;
    for idx = in'
        score = score * 5;
        score = score + sum((idx == ["(","[","{","<"]) .* (1:4),2);
    end
end
