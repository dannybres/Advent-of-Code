function m = tilt(m,dir)
switch dir
    case 'N'
        dimToPro = 2;
        sortOrder = "descend";
    case 'W'
        dimToPro = 1;
        sortOrder = "descend";
    case 'S'
        dimToPro = 2;
        sortOrder = "ascend";
    case 'E'
        dimToPro = 1;
        sortOrder = "ascend";
end

for idx = 1:size(m,dimToPro)
    if dimToPro == 2
        l = m(:,idx);
    else
        l = m(idx,:)';
    end
    cube = unique([0;find(l == '#');numel(l)+1]);
    for lidx = 1:numel(cube)-1
        if cube(lidx+1) - cube(lidx) < 3
            continue
        end
        l(cube(lidx)+1:cube(lidx+1)-1) = ...
            sort(l(cube(lidx)+1:cube(lidx+1)-1),1,sortOrder);
    end
    if dimToPro == 2
        m(:,idx) = l;
    else
        m(idx,:) = l';
    end
end
end

