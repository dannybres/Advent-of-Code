garden = char(padarray(double(char(readlines("input.txt"))), ...
    [1 1],double(' ')));

seen = false(size(garden));
rows = height(garden);
cols = width(garden);

plots = [];
for r = 1:rows % flood fill
    for c = 1:cols
        if garden(r,c) == ' ',continue,end
        if seen(r,c), continue, end
        crop = garden(r,c);
        q = [r c];
        plot = [];
        while q
            cl = q(1,:); q(1,:) = [];
            if seen(cl(1),cl(2)), continue, end
            plot = [plot; cl];
            seen(cl(1),cl(2)) = true;
            for dir = [-1 0;1 0;0 -1;0 1]'
                nl = cl + dir';
                if any(nl < 1) || nl(1) > rows || nl(2) > cols || ...
                        seen(nl(1),nl(2)), continue, end
                if garden(nl(1),nl(2)) == crop
                    q = [q;nl];
                end
            end
        end
        plots = [plots {plot}]; %#ok<*AGROW>
    end
end

perimeters = nan(1,numel(plots));
corners = zeros(1,numel(plots));
areas = nan(1,numel(plots));
for pidx = 1:numel(plots)
    plot = plots{pidx};
    perimeters(pidx) = 0;
    areas(pidx) = height(plot);
    for idx = 1:height(plot)
        loc = plot(idx,:);
        for dir = [-1 0;1 0;0 -1;0 1]' % adj is not in plot, it is an edge
            adj = loc + dir';
            if ~ismember(adj,plot,"rows")
                perimeters(pidx) = perimeters(pidx) + 1;
            end
        end

        adj = (loc' + [-1 0;-1 1;0 1;1 1;1 0;1 -1;0 -1;-1 -1]')';
        adjCropInGarden = garden(sub2ind(size(garden), ...
            adj(:,1),adj(:,2)))' == garden(loc(1),loc(2));
        orthCropInGarden = adjCropInGarden(1:2:end);
        corners(pidx) = corners(pidx) ...
            + all(orthCropInGarden(1:2) == 0) ...
            + all(orthCropInGarden(2:3) == 0) ...
            + all(orthCropInGarden(3:4) == 0) ...
            + all(orthCropInGarden([4 1]) == 0); % convex corner has 
        % consecutive values outside the garden when considering 
        % all orthogonal direction clockwise or counter clockwise.
        corners(pidx) = corners(pidx) ...
            + all(adjCropInGarden(1:3) == [1 0 1]) ...
            + all(adjCropInGarden(3:5) == [1 0 1]) ...
            + all(adjCropInGarden(5:7) == [1 0 1]) ...
            + all(adjCropInGarden([7 8 1]) == [1 0 1]); % concave corner
        % is inside outside inside, starting at each orthogonal dir
        
    end
end


p1 = sum(perimeters .* areas)
p2 = sum(corners .* areas)