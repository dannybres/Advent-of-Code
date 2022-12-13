function out = sortCell(in)
if class(in) == "double"
    out = num2cell(in);
elseif class(in{:}) == "double"
    out = {num2cell(in{:})};
elseif numel(in{:}) > 1
    content = in{:};
    oc = cell(numel(content),1);
    for idx = 1:numel(content)
        oc(idx)  = sortCell(content(idx));
    end
    out = oc;
else
    out = in;
end
if numel(out) == 1
    if class(out{:}) == "double"
        out = {out};
    end
else
    out = {out};
end
end

