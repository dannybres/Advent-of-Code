
%%
S = readlines("inputDemo.txt");
 
n = (numel(S)+1)/3;


%%
data = data(1:2);

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
    idx
    L = pairs{idx};
    R = pairs{idx+1};
    rightOrder((idx-1)/2+1) = assesPair(L,R);
end
sum(find(rightOrder))

function rightOrder = assesPair(L,R)
rightOrder = false;
for cidx = 1:max(numel(L),numel(R))
    if cidx > numel(L) || isempty(vertcat(L{:}))
        rightOrder = true;
        return
    elseif cidx > numel(R) || isempty(vertcat(R{:}))
        return
    end
    Lc = L{cidx};
    Rc = R{cidx};
    numel(Lc)
    numel(Rc)
    if isscalar(Lc) && isscalar(Rc)
        if ~(isnumeric(Lc) && isnumeric(Rc))
            Lc = Lc{1};
            Rc = Rc{1};
        end
        if Lc < Rc
            rightOrder = true;
            return
        elseif Lc > Rc
            return
        end
    else
        rightOrder = assesPair(Lc,Rc);
        if rightOrder
            return
        end
    end
end
end