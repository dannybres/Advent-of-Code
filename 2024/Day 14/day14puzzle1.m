%% day14puzzle1 - Daniel Breslan - Advent Of Code 2024
robotData = readlines("input.txt").erase("p=").replace(" v=",",").split(",").double();
width = 101;
height = 103;
per = reshape([true true; ...
    true false; ...
    false true; ...
    false false]',1 ...
    ,2,[]);
seconds = 100;
location = robotData(:,1:2) + seconds * robotData(:,3:4);
location = mod(location,[width,height]);
location = location(~any(location == [floor(width/2) floor(height/2)],2),:);
location = location < [floor(width/2) floor(height/2)];
num = squeeze(sum(all(location == per,2)));
prod(num) 