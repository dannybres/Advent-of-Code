%% day24puzzle2 - Daniel Breslan - Advent Of Code 2023
tic
data = readlines("input.txt").replace(" @",",").split(", ").double;

syms xr yr zr vxr vyr vzr

eq = [];
for idx = 1:size(data,1)
    xh = data(idx,1);
    yh = data(idx,2);
    zh = data(idx,3);
    vxh = data(idx,4);
    vyh = data(idx,5);
    vzh = data(idx,6);
    e1 = (zr - zh) * (vyh - vyr) == (yr - yh) * (vzh - vzr);
    e2 = (xr - xh) * (vzh - vzr) == (zr - zh) * (vxh - vxr);
    eq = [eq; e1; e2];
    if numel(eq) < 4
        continue
    end
    sln = solve(eq);
    if numel(fieldnames(sln)) == 6
        idxOfIntRes = find(mod(double(sln.xr),1) == 0);
        if numel(idxOfIntRes) == 1
            break
        end
    end
end
day24puzzle2result = sln.xr(idxOfIntRes) + ...
    sln.yr(idxOfIntRes) + ...
    sln.zr(idxOfIntRes) %#ok<NOPTS>
toc