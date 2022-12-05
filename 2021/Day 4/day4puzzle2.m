%% day4puzzle2 - Daniel Breslan - Advent Of Code 2021
fn = "input.txt";
data = readlines(fn);

% assemble calls
calls = double(data(1).split(","));

% assemble cards
cards = readmatrix(fn);
cards = reshape(cards',5,5,[]);
cards = pagetranspose(cards);

% play the game
found = zeros(size(cards));
boardCompleted = zeros(1,size(cards,3));
for idx = 1:numel(calls)
    call = calls(idx);
    found = found + double(cards == call);
    rowSum = squeeze(sum(found) == 5);
    colSum = squeeze(sum(found,2) == 5);
    if any(rowSum,"all")
        [~,c] = find(rowSum);
    end
    if any(colSum,"all")
        [~,c] = find(colSum);
    end
    if exist('c','var')
        if (boardCompleted(c) == 0)
            boardCompleted(c) = idx;
            if sum(boardCompleted == 0) == 0;
                finalHand = c;
                break;
            end 
            found(:,:,c) = NaN;
        end
    end
    clear c
end
% calc result
card = cards(:,:,c);
card(logical(found(:,:,c))) = 0;
day4puzzle1result = sum(card,"all") * calls(idx)