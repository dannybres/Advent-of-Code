%% day13puzzle1 - Daniel Breslan - Advent Of Code 2022
clc
data = readlines("inputDemo.txt");
data(3:3:end) = [];

data = data(1:2*7);

pairs = cell(size(data));
for idx = 1:numel(data)
    res = jsondecode(data(idx));
    pairs{idx} = cell(numel(res),1);
    for ridx = 1:numel(res)
        pairs{idx}(ridx) = sortCell(res(ridx));
    end
end
% for idx = 1:numel(pairs)
%     pairs{idx}
% end
rightOrder = false(numel(pairs)/2,1);
for idx = 1:2:numel(pairs)
    L = pairs{idx};
    R = pairs{idx+1};
    rightOrder((idx-1)/2+1) = assesPair(L,R);
end
rightOrder

function rightOrder = assesPair(L,R)
rightOrder = false;
for cidx = 1:max(numel(L),numel(R))
    if cidx > numel(L) || isempty(vertcat(L{:}))
        rightOrder = true;
        return
    elseif cidx > numel(R) || isempty(vertcat(R{:}))
        return
    end
    if numel(L{cidx}) == 1 && numel(R{cidx}) == 1
        Lc = L{cidx}{:}
        Rc = R{cidx}{:}
        if isscalar(Lc) & isscalar(Rc) & isnumeric(Lc) & isnumeric(Rc)
            if Lc < Rc
                rightOrder = true;
                return
            elseif Lc > Rc
                return
            end
        else
            error("nor dealth with")
            disp(Lc),disp(Rc)
        end
    else
        Lc = L{cidx};
        Rc = R{cidx};
%         warning("nor dealth with")
%         disp(Lc),disp(Rc)
        rightOrder = assesPair(Lc,Rc);
    end
end
end

%%
% pairs = cellfun(@fixCells,pairs,UniformOutput=false);
%
%
% ro = cellfun(@isItTheRightOrder,pairs(1:3))
%
% day13puzzle1result = 0;


function out = fixCells(input)
in = input;
if class(in) == "double"
    in = num2cell(in);
    if size(in,2) ~= 2
        in = in';
    end
else
    L = in{1};
    R = in{2};
    if class(R) == "double"
        R = num2cell(R);
    end
    if class(L) == "double"
        L = num2cell(L);
    end
    if numel(L) < numel(R)
        L = [L; repmat({nan},numel(R) - numel(L),1)];
    end
    if numel(R) < numel(L)
        R = [R; repmat({nan},numel(L) - numel(R),1)];
    end
    if size(L,2) ~= 1
        L = L';
    end
    if size(R,2) ~= 1
        R = R';
    end
    in = [L R];
end
out = in;
end

function rightOrder = isItTheRightOrder(pair)
rightOrder = false;
for idx = 1:size(pair,1)
    L = pair{idx,1};
    R = pair{idx,2};
    if class(L) == "double" && class(R) == "double"
        if isnan(L)
            rightOrder = true;
            return
        end
        if isnan(R)
            return
        end
        [L R]
        if L < R
            rightOrder = true
            return
        end
    else
        L,R
        disp(L)
    end
end
end





%%
% pairs = cellfun(@fixCells,pairs,UniformOutput=false);
%
%
% ro = cellfun(@isItTheRightOrder,pairs(1:3))
%
% day13puzzle1result = 0;


function out = fixCells(input)
in = input;
if class(in) == "double"
    in = num2cell(in);
    if size(in,2) ~= 2
        in = in';
    end
else
    L = in{1};
    R = in{2};
    if class(R) == "double"
        R = num2cell(R);
    end
    if class(L) == "double"
        L = num2cell(L);
    end
    if numel(L) < numel(R)
        L = [L; repmat({nan},numel(R) - numel(L),1)];
    end
    if numel(R) < numel(L)
        R = [R; repmat({nan},numel(L) - numel(R),1)];
    end
    if size(L,2) ~= 1
        L = L';
    end
    if size(R,2) ~= 1
        R = R';
    end
    in = [L R];
end
out = in;
end

function rightOrder = isItTheRightOrder(pair)
rightOrder = false;
for idx = 1:size(pair,1)
    L = pair{idx,1};
    R = pair{idx,2};
    if class(L) == "double" && class(R) == "double"
        if isnan(L)
            rightOrder = true;
            return
        end
        if isnan(R)
            return
        end
        [L R]
        if L < R
            rightOrder = true
            return
        end
    else
        L,R
        disp(L)
    end
end
end