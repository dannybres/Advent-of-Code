%% day16puzzle1 - Daniel Breslan - Advent Of Code 2022
[vlu,dlu,allVals] = getData("input.txt")

paths = [repelem(allVals(1),numel(allVals),1) allVals]; %make path to V1
t = dlu(paths(:,end-1) + paths(:,end)) + 1; % calc t to open v1
pres = (30 - t) .* vlu(paths(:,end)); %calc p from these v1

tLimit = 30;

maxSoFar = 0; %keep track of Max Pressure
while 1 %loooooooop
    newEle = repmat(allVals,numel(t),1); % new places (all valves)
    paths = repelem(paths,numel(allVals),1); % suplicate paths for new v
    paths = [paths newEle]; % add lest valve

    t = repelem(t,numel(allVals),1); % duplicate times
    pres = repelem(pres,numel(allVals),1);  % duplicate press

    t = t + dlu(paths(:,end-1) + paths(:,end)) + 1; % calc new time
    pres = pres + (30 - t) .* vlu(paths(:,end)); % calc new P

    keep =  false(size(paths,1),1); % remove duplicates of V
    for iidx = 1:size(paths,1)
        if(numel(unique(paths(iidx,:))) == size(paths,2))
            keep(iidx) = true;
        end
    end

    keep = keep & pres >= max(pres) * .7; % remove bottom 75% of pressure

    paths = paths(keep,:); %trim
    t = t(keep,:);
    pres = pres(keep,:);

    paths = paths(t<tLimit,:); %remove paths over limit
    pres = pres(t<tLimit,:);
    t = t(t<tLimit,:);

    mmm = pres(pres == max(pres) & t <=30); %update max pressure
    if isempty(mmm)
        break
    else
        maxSoFar = max(maxSoFar, mmm);
    end
end
day16puzzle1result = maxSoFar %#ok<NOPTS>
