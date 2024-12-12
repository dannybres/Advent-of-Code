%% day12puzzle2 - Daniel Breslan - Advent Of Code 2024
m = char(readlines("input.txt"));

types = unique(m)';
day12puzzle2result = 0;
ns = {[0 0 1],[1 0 0],[0;0;1],[1;0;0]};

for t = types
    plants = m == t;
    plants = padarray(plants,[1 1]);
    platMeta = bwconncomp(plants,4);
    for idx = 1:numel(platMeta.PixelIdxList)
        region = false(size(plants));
        region(platMeta.PixelIdxList{idx}) = true;
        area = nnz(region);

        sides = 0;
        for nidx = 1:numel(ns)
            n = ns{nidx};
            md = bwconncomp(conv2(region,n,'same') .* ~region,4);
            sides = sides + numel(md.PixelIdxList);
        end
        % disp(compose("Plant: %s, Area: %i, Sides: %i",t,area,sides))
        day12puzzle2result = day12puzzle2result + area * sides;
    end
end
day12puzzle2result
