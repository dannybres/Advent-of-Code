%% day16puzzle1 - Daniel Breslan - Advent Of Code 2022
[vlu,dlu,allVals] = getData("inputDemo.txt");
tLimit = 30;

pathsMe = [repelem(allVals(1),numel(allVals).^2,1) repelem(allVals,numel(allVals),1)]; %make path to V1
pathsEle = [repelem(allVals(1),numel(allVals).^2,1) repmat(allVals,numel(allVals),1)]; %make path to V1

combo = [pathsMe pathsEle(:, 2:end)]

keep = false(numel(combo),1);
for idx = 1:size(combo,1)
	keep(idx) = numel(unique(combo(idx,:))) == 2 * size(pathsMe,2) - 1;
end

pathsMe = pathsMe(keep,:);
pathsEle  = pathsEle(keep,:);


tMe = dlu(pathsMe(:,end-1) + pathsMe(:,end)) + 1; % calc t to open v1
presMe = (30 - tMe) .* vlu(pathsMe(:,end)); %calc p from these v1

tEle = dlu(pathsEle(:,end-1) + pathsEle(:,end)) + 1; % calc t to open v1
presEle = (30 - tEle) .* vlu(pathsEle(:,end)); %calc p from these v1


tpresIdx = presMe + presEle > max(presMe + presEle) * .75;

pathsMe = pathsMe(tpresIdx, :);
tMe = tMe(tpresIdx);
presMe = presMe(tpresIdx);

pathsEle = pathsEle(tpresIdx, :);
tEle = tEle(tpresIdx);
presEle = presEle(tpresIdx);




maxSoFar = 0; %keep track of Max Pressure
% while 1 %loooooooop
newMe = repmat(repmat(allVals,numel(allVals),1),size(pathsMe,1),1);
newEle = repmat(repelem(allVals,numel(allVals),1),size(pathsMe,1),1);
pathsMe = [repelem(pathsMe,numel(allVals).^2,1) newMe];
pathsEle = [repelem(pathsEle,numel(allVals).^2,1) newEle];

tMe = repelem(tMe,numel(allVals).^2,1);
presMe = repelem(presMe,numel(allVals).^2,1);
tEle = repelem(tEle,numel(allVals).^2,1);
presEle = repelem(presEle,numel(allVals).^2,1);
combo = [pathsMe pathsEle(:, 2:end)];

keep = false(numel(combo),1);
for idx = 1:size(combo,1)
	keep(idx) = numel(unique(combo(idx,:))) == 2 * size(pathsMe,2) - 1;
end

pathsMe = pathsMe(keep, :);
tMe = tMe(keep);
presMe = presMe(keep);

pathsEle = pathsEle(keep, :);
tEle = tEle(keep);
presEle = presEle(keep);

tMe = tMe + dlu(pathsMe(:,end-1) + pathsMe(:,end)) + 1; % calc t to open v1
presMe = presMe + (30 - tMe) .* vlu(pathsMe(:,end)); %calc p from these v1

tEle = tEle + dlu(pathsEle(:,end-1) + pathsEle(:,end)) + 1; % calc t to open v1
presEle = presEle + (30 - tEle) .* vlu(pathsEle(:,end)); %calc p from these v1

tpresIdx = presMe + presEle > max(presMe + presEle) * .75;

pathsMe = pathsMe(tpresIdx, :);
tMe = tMe(tpresIdx);
presMe = presMe(tpresIdx);

pathsEle = pathsEle(tpresIdx, :);
tEle = tEle(tpresIdx);
presEle = presEle(tpresIdx);

pathsEle(presMe + presEle == max(presMe + presEle),:)

return

tpresIdx = presMe + presEle > max(presMe + presEle) * .75;

return
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
%         break
    else
        maxSoFar = max(maxSoFar, mmm);
    end
% end
day16puzzle1result = maxSoFar %#ok<NOPTS>
