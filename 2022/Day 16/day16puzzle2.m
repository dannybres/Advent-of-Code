%% day16puzzle1 - Daniel Breslan - Advent Of Code 2022
[vlu,dlu,allVals] = getData("inputDemo.txt");
% allVals = (1:4)'
pathsMe = [repelem(allVals(1),numel(allVals).^2,1) repelem(allVals,numel(allVals),1)]; %make path to V1
pathsEle = [repelem(allVals(1),numel(allVals).^2,1) repmat(allVals,numel(allVals),1)]; %make path to V1
t = dlu(pathsMe(:,end-1) + pathsMe(:,end)) + 1; % calc t to open v1
pres = (30 - t) .* vlu(pathsMe(:,end)); %calc p from these v1

return

tLimit = 30

maxSoFar = 0; %keep track of Max Pressure
while 1 %loooooooop
    newEle = repmat(allVals,numel(t),1); % new places (all valves)
    pathsMe = repelem(pathsMe,numel(allVals),1); % suplicate paths for new v
    pathsMe = [pathsMe newEle]; % add lest valve

    t = repelem(t,numel(allVals),1); % duplicate times
    pres = repelem(pres,numel(allVals),1);  % duplicate press

    t = t + dlu(pathsMe(:,end-1) + pathsMe(:,end)) + 1; % calc new time
    pres = pres + (30 - t) .* vlu(pathsMe(:,end)); % calc new P

    keep =  false(size(pathsMe,1),1); % remove duplicates of V
    for iidx = 1:size(pathsMe,1)
        if(numel(unique(pathsMe(iidx,:))) == size(pathsMe,2))
            keep(iidx) = true;
        end
    end

    keep = keep & pres >= max(pres) * .7; % remove bottom 75% of pressure

    pathsMe = pathsMe(keep,:); %trim
    t = t(keep,:);
    pres = pres(keep,:);

    pathsMe = pathsMe(t<tLimit,:); %remove paths over limit
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
