data = readlines("input.txt");

mid = find(data == "");

ins = data(1:mid-1).split(": ").erase([""""]).replace(" ",",");
ins(:,2) = "," + ins(:,2) + ",";

done = false(size(ins,1),1);

words = data(mid+1:end);

% for dan = 1:5
while ~all(done)
noNums = ~cellfun(@isempty,regexp(ins(:,2),"^[ab,|]+$")) | done;

for widx = find(~noNums)'
    for ridx = find(noNums)'
        repStr = ins(ridx,2).split("|");
        tempIns = repmat(ins(widx,2).split("|"),1,numel(ins(ridx,2).split("|")));
        for nsIdx = 1:numel(repStr)
            tempIns(:,nsIdx) = tempIns(:,nsIdx).replace("," + ins(ridx,1) + ",", repStr(nsIdx));
        end
        ins = ins.replace(",,",",").replace(",,",",").replace(",,",",").replace(",,",",").replace(",,",",");
        tempIns = unique(tempIns(:)).join("|");
        ins(widx,2) = tempIns;
    end
end
done = done | noNums;
ins;
end

sum(any(ins(ins(:,1) == "0",2).erase(",").split("|") == words'))