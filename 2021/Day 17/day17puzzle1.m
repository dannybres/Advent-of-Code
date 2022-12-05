%% day17puzzle1 - Daniel Breslan - Advent Of Code 2021
data = readlines("input.txt").erase(["target area: x="," y="]).replace("..",",").split(",").double();
close all
goes = 200;
withinBounds = false(goes*2+1);
maxHeight = zeros(goes*2+1);
for x = -goes:goes
    for y = -goes:goes
        iV = [x,y];
        [withinBounds(x+goes+1,y+goes+1), maxHeight(x+goes+1,y+goes+1)]...
            = simulation(iV, data);
    end
end


numel(maxHeight(withinBounds))

function [withinBounds, maxHeight] = simulation(iV,boundingBox, showgraph)
if ~exist('showgraph','var')
    showgraph = false;
end
t = 400;
y = [0; cumsum(cumsum([iV(2); repelem(-1,t,1)]))];
x = cumsum([iV(1); repelem(-1,t,1)]);
x(x<0) = 0;
x = [0; cumsum(x)];
idx = x>=boundingBox(1) & x<=boundingBox(2) & y>=boundingBox(3) & ...
    y<=boundingBox(4);
withinBounds = any(idx);
maxHeight = max(y);
if showgraph
    rectangle('Position',[boundingBox(1) boundingBox(3) ...
        abs(diff(boundingBox(1:2))) abs(diff(boundingBox(3:4)))])
    hold on
    plot(x,y,'x-')
    plot(x(idx),y(idx),'x')
end
end