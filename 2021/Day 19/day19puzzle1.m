%% day19 - Daniel Breslan - Advent Of Code 2021
data = readlines("input.txt");
data(data == "") = [];
titleIdx = find(data.contains("--"));
reports = cell(1,numel(titleIdx));
for idx = 1:numel(titleIdx)
    try
        endIdx = titleIdx(idx + 1) - 1;
    catch
        endIdx = numel(data);
    end
    reports{idx} = data(titleIdx(idx)+1:endIdx).split(",").double();
end

knowBeacons = reports{1};
scannerLocations = nan(numel(titleIdx),3); % x y z, order, flipped
scannerLocations(1,:) = 0;

while any(isnan(scannerLocations(:,1)))
    for baseIdx = find(~isnan(scannerLocations(:,1)))'
        for baseRelativeIdx = 1:height(reports{baseIdx})
            baseReports = reports{baseIdx};
            baseReports = abs(baseReports - ...
                baseReports(baseRelativeIdx,:));
            for otherIdx = find(isnan(scannerLocations(:,1)))'
                found = false;
                if ~couldOverlap(reports,[baseIdx,otherIdx])
                    continue
                end
                for otherRelativeIdx = 1:height(reports{otherIdx}) 
                    % other relative
                    otherReports = reports{otherIdx};
                    otherReports = abs(otherReports - ...
                        otherReports(otherRelativeIdx,:));
                    for pidx = perms(1:3)' % column order
                        if nnz(ismember(otherReports(:,pidx), ...
                                baseReports,"rows")) == 12
                            found = true;
                            break
                        end
                    end
                    if found
                        break
                    end
                end
                if found
                    break
                end
            end
            if found
                break
            end
        end
        if ~found, continue, end

        [Lia,Locb] = ismember(baseReports,otherReports(:,pidx),"rows");

        baseMatched = reports{baseIdx}(Lia,:);
        Locb(Locb == 0) = [];
        otherMatched = reports{otherIdx}(Locb,pidx);

        knownBeacons = scannerLocations(baseIdx,:) + baseMatched;

        newScanner = knownBeacons + otherMatched;

        axisInversionNeeded = ~all(newScanner(1,:) == newScanner);
        otherMatched(:,axisInversionNeeded) = ...
            -otherMatched(:,axisInversionNeeded);
        newScanner = knownBeacons + otherMatched;
        assert(all(newScanner(1,:) == newScanner,'all'));

        scannerLocations(otherIdx,:) = newScanner(1,:);

        reports{otherIdx} = reports{otherIdx}(:,pidx);
        reports{otherIdx}(:,~axisInversionNeeded) = ...
            -reports{otherIdx}(:,~axisInversionNeeded);
        if ~any(isnan(scannerLocations(:,1)))
            break
        end
    end
    if ~any(isnan(scannerLocations(:,1)))
        break
    end
end

allbeacons = [];
for idx = 1:height(scannerLocations)
    allbeacons = [allbeacons; scannerLocations(idx,:) + reports{idx}];
end

beacons = unique(allbeacons,"rows");
day19part1result = height(beacons)

day19part2result = 0;
for f = 1:height(scannerLocations)
    for t = 1:height(scannerLocations)
        if f <= t, continue, end
        day19part2result = max(day19part2result,...
            sum(abs(scannerLocations(f,:) - scannerLocations(t,:))));
    end
end
day19part2result

function could = couldOverlap(reports,idx)
idx = sort(idx);
persistent cache
if isempty(cache)
    cache = configureDictionary("string","logical");
end
key = string(idx).join("-");
if isKey(cache,key)
    could = cache(key);
    return
end
hashes = reports{idx(1)};
hashA = sort(abs([reshape(hashes(:,1) - hashes(:,1)',[],1)...
    reshape(hashes(:,2) - hashes(:,2)',[],1)...
    reshape(hashes(:,3) - hashes(:,3)',[],1)]),2);

hashes = reports{idx(2)};
hashB = sort(abs([reshape(hashes(:,1) - hashes(:,1)',[],1)...
    reshape(hashes(:,2) - hashes(:,2)',[],1)...
    reshape(hashes(:,3) - hashes(:,3)',[],1)]),2);

could = nnz(any(string(hashB).join(".") == string(hashA).join(".")')) ...
    >= nchoosek(12,2);
cache(key) = could;
end