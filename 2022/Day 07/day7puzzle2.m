%% day7puzzle2 - Daniel Breslan - Advent Of Code 2022
data = readlines("input.txt");
data = data.join(",").replace("$","$%$%$").split(",$%$%");
data = data(2:end);

currentDir = "/";

G = digraph;
G = addnode(G,currentDir);

for idx = 1:numel(data)
    instruction = data(idx).split(",");
    instruction = instruction(strlength(instruction) ~= 0);
    if instruction(1) == "$ ls"
        dirContent = instruction(2:end).split(" ");
        if size(dirContent,2) == 1
            dirContent = dirContent';
        end
        dirContent(dirContent(:,1) == "dir") = "0";
        dirContent(:,2) = currentDir + dirContent(:,2);
        G = addnode(G, dirContent(:,2));
        G = addedge(G,currentDir,dirContent(:,2),dirContent(:,1).double());
    elseif instruction(1) == "$ cd .."
        currentDir = string(G.Edges.EndNodes(...
            string(G.Edges.EndNodes(:,2)) == currentDir,1));
    elseif instruction(1).startsWith("$ cd ")
        currentDir = currentDir + instruction(1).extractAfter("$ cd ");
    end
end

folderSize = zeros(numel(allFolders),1);
for idx = 1:numel(allFolders)
    folderSize(idx) = getSizeOfFolder(G,allFolders(idx));
end
folderSize = sort(folderSize);
options = folderSize(folderSize >= 30000000 - 70000000 + folderSize(end),:);

day7puzzle2result = options(1) %#ok<NOPTS> 

