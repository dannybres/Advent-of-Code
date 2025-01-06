tic
data = readlines("input.txt");
data(data == "") = [];
titleIdx = find(data.contains("--"));
reports = cell(1,numel(titleIdx));
for idx = 1:numel(titleIdx)
    try
        e = titleIdx(idx + 1) - 1;
    catch
        e = numel(data);
    end
    reports{idx} = data(titleIdx(idx)+1:e).split(",").double();
end

knowBeacons = reports{1};
scannerLocations = nan(numel(titleIdx),3); % x y z, order, flipped
scannerLocations(1,:) = 0;

while any(isnan(scannerLocations(:,1)))
    for baseIdx = find(~isnan(scannerLocations(:,1)))'
        for baseRelativeIdx = 1:height(reports{baseIdx})
            baseReports = reports{baseIdx};
            baseReports = abs(baseReports - baseReports(baseRelativeIdx,:));
            for otherIdx = find(isnan(scannerLocations(:,1)))'
                found = false;
                if ~couldOverlap(reports,[baseIdx,otherIdx])
                    continue
                end
                for otherRelativeIdx = 1:height(reports{otherIdx}) % other relative
                    otherReports = reports{otherIdx};
                    otherReports = abs(otherReports - otherReports(otherRelativeIdx,:));
                    for pidx = perms(1:3)' % column order
                        if nnz(ismember(otherReports(:,pidx),baseReports,"rows")) == 12
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
        otherMatched(:,axisInversionNeeded) = -otherMatched(:,axisInversionNeeded);
        newScanner = knownBeacons + otherMatched;
        assert(all(newScanner(1,:) == newScanner,'all'));

        scannerLocations(otherIdx,:) = newScanner(1,:);%, pidx', double(~axisInversionNeeded)]

        reports{otherIdx} = reports{otherIdx}(:,pidx);
        reports{otherIdx}(:,~axisInversionNeeded) = -reports{otherIdx}(:,~axisInversionNeeded);
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
height(beacons)

d = 0;
for f = 1:height(scannerLocations)
    for t = 1:height(scannerLocations)
        if f <= t, continue, end
        d = max(d,sum(abs(scannerLocations(f,:) - scannerLocations(t,:))));
    end
end
d
toc

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
a = reports{idx(1)};
hashA = sort(abs([reshape(a(:,1) - a(:,1)',[],1)...
    reshape(a(:,2) - a(:,2)',[],1)...
    reshape(a(:,3) - a(:,3)',[],1)]),2);

a = reports{idx(2)};
hashB = sort(abs([reshape(a(:,1) - a(:,1)',[],1)...
    reshape(a(:,2) - a(:,2)',[],1)...
    reshape(a(:,3) - a(:,3)',[],1)]),2);

could = nnz(any(string(hashB).join(".") == string(hashA).join(".")')) >= nchoosek(12,2);
cache(key) = could;
end