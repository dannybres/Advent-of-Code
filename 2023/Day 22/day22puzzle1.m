%% day22puzzle1 - Daniel Breslan - Advent Of Code 2023\
clc
data = readlines("input.txt").extract(digitsPattern).double;
data = reshape(data,[],3,2);

if ~exist("raisedBlocks","var")
raisedBlocks = makeBlocks(data);
masterBlocks = fallBlocks(raisedBlocks);
end
r = true(size(data,1),1);
iSupport = cell(height(data),1);
supportMe = cell(height(data),1);
for idx = 1:size(data,1)
    thisBlock = masterBlocks(masterBlocks(:,4) == idx,:);
    otherBlocks = masterBlocks(masterBlocks(:,4) ~= idx,:);
    topRow = thisBlock(max(thisBlock(:,3)) == thisBlock(:,3),:);
    supports = topRow;
    supports(:,3) = supports(:,3) + 1;
    [~,midx] = ismember(supports(:,1:3),otherBlocks(:,1:3),"rows");
    midx(midx == 0) = [];
    blocksItSupports = otherBlocks(midx,:);
    [~,uidx] = unique(blocksItSupports(:,4));
    blocksItSupports = blocksItSupports(uidx,:);
    for sidx = 1:height(blocksItSupports)
        supported = blocksItSupports(sidx,:);
        iSupport{idx} = [iSupport{idx} supported(4)];
        supportMe{supported(4)} = [supportMe{supported(4)} idx];
    end
end
%%
r = false(height(iSupport),1);
for idx = 1:numel(iSupport)
    numberOfSups = cellfun(@numel,supportMe(iSupport{idx}))
    r(idx) = all(numberOfSups > 1)
end
sum(r)

function blocks = makeBlocks(data)
numBlocks = sum(diff(data,1,3),"all");
blocks = nan(numBlocks,4);
next = 1;
for idx = 1:height(data)
    from = data(idx,:,1);
    to = data(idx,:,2);
    dimOfChange = find(diff([from;to]) ~= 0);
    for pVal = from(dimOfChange):to(dimOfChange)
        blocks(next,:) = [from idx];
        blocks(next,dimOfChange) = pVal;
        next = next + 1;
    end
end
end

function blocks = fallBlocks(blocks)
done = false(blocks(end),1);
done(~any(blocks(:,4) == 1:blocks(end))) = true;
while any(~done)
    if sum(done) == 0
        toMoveNext = unique(blocks(blocks(:,3) == min(blocks(:,3)),4));
    else
        toMoveNext = ...
            unique(blocks(blocks(:,3) == ...
            min(blocks(all(blocks(:,4) ~= find(done)',2),3)),4));
    end
    for idx = toMoveNext'
        blocksOfPiece = blocks(blocks(:,4)==idx,1:3);
        blocksOfPiece(:,3) = blocksOfPiece(:,3) - 1;
        if any(blocksOfPiece(:,3) < 1)
            done(idx) = true;
            continue
        end
        otherBlocks = blocks(blocks(:,4) ~= idx,1:3);
        canMove = ~any(all(reshape(blocksOfPiece',1,3,[]) == otherBlocks,2),"all");
        while canMove && ~any(blocksOfPiece(:,3) < 1)
            blocks(blocks(:,4)==idx,1:3) = blocksOfPiece;
            blocksOfPiece(:,3) = blocksOfPiece(:,3) - 1;
            canMove = ~any(all(reshape(blocksOfPiece',1,3,[]) == otherBlocks,2),"all");
            % canMove = ~any(ismember(blocksOfPiece,otherBlocks(:,1:3),"rows"));
        end
        done(idx) = true;
    end
    if mod(sum(done),1e3) == 0
        sum(done)
    end
end
end