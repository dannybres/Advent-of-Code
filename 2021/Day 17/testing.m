%% day17puzzle1 - Daniel Breslan - Advent Of Code 2021
boundingBox = readlines("inputDemo.txt").erase(["target area: x="," y="]).replace("..",",").split(",").double();
goes = 200;
t = 400;
y = [repelem(0,1,size(iV,1)); cumsum(cumsum([iV(:,2)'; repelem(-1,t,size(iV,1))]))];
x = cumsum([iV(:,1)'; repelem(-1,t,size(iV,1))]);
x(x<0) = 0;
x = [repelem(0,1,size(iV,1)); cumsum(x)];
idx = x>=boundingBox(1) & x<=boundingBox(2) & y>=boundingBox(3) & y<=boundingBox(4);
withinBounds = any(idx);
maxHeight = max(y);

resultPart1 = max(maxHeight(withinBounds))
resultPart2 = numel(maxHeight(withinBounds))