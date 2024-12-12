%% day12puzzle1 - Daniel Breslan - Advent Of Code 2024
m = char(readlines("input.txt"));

types = unique(m)';
day12puzzle1result = 0;
for t = types
    plants = m == t;
    plants = padarray(plants,[1 1]);
    platMeta = bwconncomp(plants,4);
    for idx = 1:numel(platMeta.PixelIdxList)
        region = false(size(plants));
        region(platMeta.PixelIdxList{idx}) = true;
        area = nnz(region);
        n = [0 1 0; 1 0 1; 0 1 0];
        perimeter = sum(conv2(region,n,"same") .* ~region,"all");
        % disp(compose("Plant: %s, Area: %i, Perimeter: %i",t,area,perimeter))
        day12puzzle1result = day12puzzle1result + perimeter * area;
    end
end
day12puzzle1result