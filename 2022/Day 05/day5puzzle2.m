%% day5puzzle2 - Daniel Breslan - Advent Of Code 2022
data = readlines("input.txt");

numberIdx = find(data.contains("  ") & ~data.contains("["));

positions = char(data(1:numberIdx - 1));
instructions = data(numberIdx + 2:end).erase(["move ","from ","to "])...
    .split(" ").double();

positions = string(rot90(positions(:,2:4:end),3)).erase(" ");

for idx = 1:size(instructions,1)
    stringToMove = positions(instructions(idx,2))...
        .extractAfter(strlength(positions(instructions(idx,2))) - ...
        instructions(idx,1));
    positions(instructions(idx,2)) = positions(instructions(idx,2))...
        .extractBefore(strlength(positions(instructions(idx,2))) - ...
        instructions(idx,1)+1);
    positions(instructions(idx,3)) = positions(instructions(idx,3))...
        .append(stringToMove);
end

day5puzzle2result = positions.extractAfter(strlength(positions)-1).join("")
