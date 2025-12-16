data = readlines("input.txt");
tic
state = (data.extractBefore(" ") == "on") * 2 - 1;
nums = data.extractAfter(" ").split(",").extractAfter(2).split("..").double();

x = squeeze(nums(:,1,:)); y = squeeze(nums(:,2,:)); z = squeeze(nums(:,3,:));

cubes = nan(1e5,7); % xmin xmax ymin ymax zmin zmax sign
cubeIdx = 1;
for idx = 1:height(data)
    nextCube = [x(idx,:), y(idx,:), z(idx,:), state(idx)];
    allIntersects = find(intersects(nextCube,cubes(1:cubeIdx-1,:)));
    intersections = nan(numel(allIntersects),7);
    for iIdx = 1:numel(allIntersects)
        intersections(iIdx,:) = intersection(nextCube,cubes(allIntersects(iIdx),:));
    end
    cubes(cubeIdx:cubeIdx + numel(allIntersects) - 1,:) = intersections;
    cubeIdx = cubeIdx + numel(allIntersects);
    if nextCube(7) == 1
        cubes(cubeIdx,:) = nextCube;
        cubeIdx = cubeIdx + 1;
    end
end
day22puzzle2result = sum(...
    (cubes(1:cubeIdx-1,2) - cubes(1:cubeIdx-1,1) + 1) .* ...
    (cubes(1:cubeIdx-1,4) - cubes(1:cubeIdx-1,3) + 1) .* ...
    (cubes(1:cubeIdx-1,6) - cubes(1:cubeIdx-1,5) + 1) .* ...
    cubes(1:cubeIdx-1,7))
toc

function bool = intersects(A,B)
    if isempty(B)
        bool = false;
        return
    end
    bool = A(1) <= B(:,2) & A(2) >= B(:,1) & ...
           A(3) <= B(:,4) & A(4) >= B(:,3) & ...
           A(5) <= B(:,6) & A(6) >= B(:,5);
end

function intersectCube = intersection(newCube,existingCube)
    minX = max([newCube(1), existingCube(1)]);
    maxX = min([newCube(2), existingCube(2)]);

    minY = max([newCube(3), existingCube(3)]);
    maxY = min([newCube(4), existingCube(4)]);

    minZ = max([newCube(5), existingCube(5)]);
    maxZ = min([newCube(6), existingCube(6)]);

    if newCube(7) == existingCube(7)
        sign = -newCube(7);
    else
        sign = newCube(7);
    end

    intersectCube = [minX, maxX, minY, maxY, minZ, maxZ, sign];
end