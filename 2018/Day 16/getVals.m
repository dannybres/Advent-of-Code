function out = getVals(type,ins,data)
type = type.split("")';
type = type(2:end-1);
out = nan(size(type));
for idx = 1:numel(type)
    if type(idx) == "r"
        out(idx) = data(ins(idx+1)+1);
    elseif type(idx) == "i"
        out(idx) = ins(idx+1);
    else
        error("unknown type")
    end
end
end
