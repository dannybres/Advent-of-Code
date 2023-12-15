%% day15puzzle2 - Daniel Breslan - Advent Of Code 2023
clc
data = readlines("input.txt").split(",");
l = repmat("",9,255);
for idx = 1:numel(data)
    instr = data(idx);
    label = instr.extractBefore("-");
    if ismissing(label)
        label = instr.extractBefore("=");
    end
    box = hash(label) + 1;
    if instr.contains("=")
        existIdx = l(:,box).contains(label);
        if any(existIdx)
            l(existIdx,box) = instr.replace("="," ");
        else
            l(find(l(:,box) == "",1),box) = instr.replace("="," ");
        end
    else
        ll = find(l(:,box).contains(label));
        if ~isempty(ll)
            r = [l(:,box);""];
            r(ll) = [];
            l(:,box) = r;
        end
    end
end
[slotN,boxN] = find(l~="");
day15puzzle2result = sum(slotN .* boxN .* l(l~="").extractAfter(" ").double)

function h = hash(i)
h = 0;
s = char(i);
for c = s
    h = mod((h + double(c))*17,256);
end
end
