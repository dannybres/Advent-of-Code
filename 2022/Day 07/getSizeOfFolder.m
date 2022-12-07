function sizeOfFolder = getSizeOfFolder(G,folder)
    folderContent = G.Edges(outedges(G,folder),:);
    directoriesInContent = string(folderContent.EndNodes(...
        folderContent.Weight == 0,2));
    for idx = 1:numel(directoriesInContent)
	    subfolderSize = getSizeOfFolder(G,directoriesInContent(idx));
        folderContent.Weight(string(folderContent.EndNodes(:,2)) == ...
            directoriesInContent(idx)) = subfolderSize;
    end
    sizeOfFolder = sum(folderContent.Weight);
end

