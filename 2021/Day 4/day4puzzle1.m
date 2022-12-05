%% day4puzzle1 - Daniel Breslan - Advent Of Code 2021
fn = "inputDemo.txt"
data = readlines(fn);

% assemble calls
calls = double(data(1).split(","));

% assemble cards
cards = readmatrix(fn)
cards = reshape(cards',5,5,[]);
cards = pagetranspose(cards);

% play the game
found = false(size(cards));
for idx = 1:numel(calls)
    call = calls(idx);
    found = found | cards == call;
    rowSum = squeeze(sum(found) == 5);
    colSum = squeeze(sum(found,2) == 5);
    if any(rowSum,"all")
        [~,c] = find(colSum)
        break
    end
    if any(colSum,"all")
        [~,c] = find(colSum)
        break
    end
end

% calc result
card = cards(:,:,c);
card(found(:,:,c)) = 0;
day4puzzle1result = sum(card,"all") * calls(idx)