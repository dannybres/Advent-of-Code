%% day5puzzle2 - Daniel Breslan - Advent Of Code 2022
data = readlines("input.txt");

numberIdx = find(data.contains("  ") & ~data.contains("[")); % find line 
% with " 1   2   3 ..."

positions = char(data(1:numberIdx - 1)); % get the positions of the creates 
% before numbers

positions = string(rot90(positions(:,2:4:end),3)).erase(" ") %turns the 
% positsions into strings rotated clock wise so stack 1 is first index etc.

for idx = 1:size(instructions,1) % loop through instuctions
    stringToMove = positions(instructions(idx,2))...
        .extractAfter(strlength(positions(instructions(idx,2))) - ...
        instructions(idx,1)); % find crates to move
    positions(instructions(idx,2)) = positions(instructions(idx,2))...
        .extractBefore(strlength(positions(instructions(idx,2))) - ...
        instructions(idx,1)+1); % remove crates from stack (remove from 
    % string)
    positions(instructions(idx,3)) = positions(instructions(idx,3))...
        .append(stringToMove); % add crates to other stack (append to 
    % string)
end

day5puzzle2result = positions.extractAfter(strlength(positions)-1)...
    .join("") % get all the last elements of the stacks.

