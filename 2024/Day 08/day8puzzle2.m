%% day8puzzle2 - Daniel Breslan - Advent Of Code 2024
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
          theseAntiNodesLocs(li + (0:49),:) = [r(aii) - dr * (0:49)',...
              c(aii) - dc * (0:49)']; %#ok<*SAGROW>
          theseAntiNodesLocs(li + (50:99),:) = [r(ai) + dr * (0:49)',...
              c(ai) + dc * (0:49)'];
          li = li + 100;
        end
    end
    antiNodeLocs = unique([antiNodeLocs;theseAntiNodesLocs(...
        theseAntiNodesLocs(:,1) > 0 &...
        theseAntiNodesLocs(:,1) <= size(map,1) &...
        theseAntiNodesLocs(:,2) > 0 &...
        theseAntiNodesLocs(:,2) <= size(map,2),:)],...
        "rows");
end
day8puzzle2result = height(antiNodeLocs)
