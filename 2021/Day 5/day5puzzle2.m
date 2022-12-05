function day5puzzle2()
%% day5puzzle2 - Daniel Breslan - Advent Of Code 2021
data = readtable("input.txt",Delimiter={',',' -> '});
data.Properties.VariableNames = ["x1","y1","x2","y2"];

sizes = max(table2array(data));
map = zeros(max(sizes([2 4]))+1,max(sizes([1 3]))+1);
for idx = 1:height(data)
    yIndexOfVent = (data{idx,"y1"}:data{idx,"y2"})+1;
    xIndexOfVent = (data{idx,"x1"}:data{idx,"x2"})+1;
    if isempty(xIndexOfVent)
            xIndexOfVent = (data{idx,"x1"}:-1:data{idx,"x2"})+1;
    end
    if isempty(yIndexOfVent)
            yIndexOfVent = (data{idx,"y1"}:-1:data{idx,"y2"})+1;
    end
    if size(xIndexOfVent,2) ~= 1 && size(yIndexOfVent,2) ~= 1
        indexOfVent = sub2ind(size(map),yIndexOfVent,xIndexOfVent);
        map(indexOfVent) = map(indexOfVent)+1;
    else
        map(yIndexOfVent, xIndexOfVent) = map(yIndexOfVent, xIndexOfVent)+1;
    end
end

day5puzzle1result = nnz(map > 1) %#ok<NOPTS>
end