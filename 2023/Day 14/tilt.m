function m = tilt(m)
for idx = 1:size(m,2)
    l = m(:,idx);
    cube = [0;find(isnan(l));numel(l)+1];
    for lidx = 1:numel(cube)-1
        if cube(lidx+1) - cube(lidx) < 3
            continue
        end
        ii = cube(lidx)+1:cube(lidx+1)-1;
        s = nnz(l(ii));
        n = numel(ii);
        if s == 0 || s == n
            continue
        end
        l(ii) = 0;
        l(ii(1:s)) = 1;
    end
    m(:,idx) = l;
end
end

