%% day9puzzle2 - Daniel Breslan - Advent Of Code 2025
data = readlines("input.txt").split(",").double;
originalData = data;

% add extra red tiles in big steps to capture cut ins (only considered big
% x cuts ins)
for idx = 1:2
    while true
        b = find(abs(diff(data(:,idx))) > 2000);
        if isempty(b)
            break
        end
        splitAfter = b(1);
        sp = 1500;
        if data(splitAfter,idx) > data(splitAfter+1,idx)
            sp = -sp;
        end
        n = data(splitAfter,idx):sp:data(splitAfter+1,idx);
        if idx == 1
            n = [n',repmat(data(splitAfter,2),numel(n),1)];
        else
            n = [repmat(data(splitAfter,1),numel(n),1),n'];
        end
        data = [data(1:splitAfter-1,:);n;data(splitAfter+1:end,:)];
    end
end

% get all corner indexes and rank descensing by area
A = triu(abs(data(:,1) - data(:,1)' + 1) .* abs(data(:,2) - data(:,2)' + 1));
A(A == 0) = 0;
[~, linearIdx] = sort(A(:),'descend');
[rowIdx, colIdx] = ind2sub(size(A), linearIdx);
links = {[rowIdx(1),colIdx(1)]};

% find a valild rectangle (no containing reds (inside)) and corners are in
% original data
for idx = 1:height(rowIdx)
    a = data(rowIdx(idx),:);
    b = data(colIdx(idx),:);

    if nnz(data(:,1) > min([a(1),b(1)]) & data(:,1) < max([a(1),b(1)]) &...
            data(:,2) > min([a(2),b(2)]) & data(:,2) < max([a(2),b(2)]))
        continue
    end

    if ismember(a,originalData,"rows") && ismember(b,originalData,"rows")
        break
    end
end
day9puzzle2result = (abs(a(1)-b(1)) + 1) * (abs(a(2)-b(2)) + 1)

plot([originalData(:,1);originalData(1,1)],[originalData(:,2);originalData(1,2)],'o-',MarkerFaceColor='g',Color='g',MarkerSize=2)
hold on
patch([a(1) a(1) b(1) b(1)],[a(2) b(2) b(2) a(2)],'r')
plot(a(1),a(2),'o',MarkerSize=10,MarkerFaceColor='y')
plot(b(1),b(2),'o',MarkerSize=10,MarkerFaceColor='b')