%% day8puzzle1 - Daniel Breslan - Advent Of Code 2024
map = char(readlines("input.txt"));
antennaTypes = unique(map);
antennaTypes(antennaTypes=='.') = [];
antiNodeLocs = [];
for idx = 1:numel(antennaTypes)
    thisAntennaType = antennaTypes(idx);
    [r,c] = find(map == thisAntennaType);
    theseAntiNodesLocs = [];
    li = 1;
    for ai = 1:numel(r)
        for aii = (ai+1):numel(r)
          dr = r(ai) - r(aii);
          dc = c(ai) - c(aii);
          cd = gcd(dr,dc);
          dr = dr / cd;
          dc = dc / cd;
          theseAntiNodesLocs(li,:) = [r(aii) - dr,...
              c(aii) - dc]; %#ok<*SAGROW>
          theseAntiNodesLocs(li + 1,:) = [r(ai) + dr,...
              c(ai) + dc];
          li = li + 2;
        end
    end
    antiNodeLocs = unique([antiNodeLocs;theseAntiNodesLocs(...
        theseAntiNodesLocs(:,1) > 0 &...
        theseAntiNodesLocs(:,1) <= size(map,1) &...
        theseAntiNodesLocs(:,2) > 0 &...
        theseAntiNodesLocs(:,2) <= size(map,2),:)],...
        "rows");
end
day8puzzle1result = height(antiNodeLocs)
