%% day7puzzle1 - Daniel Breslan - Advent Of Code 2023
clc
data = readlines("input.txt").split(" "); % load

bids = data(:,2).double; % get bid

hands = data(:,1).split(""); % get hands
hands = hands(:,2:end-1);

[~,idx] = sort(hands.replace(cards',compose("%02i",0:12)).join("").double,1,"descend");
hands = hands(idx,:); % sort hands by rank ready for same results
bids = bids(idx,:); % sort hands by rank ready for same results

cards = "A, K, Q, J, T, 9, 8, 7, 6, 5, 4, 3, 2"; % get cards
cards = cards.split(", ");

phands = permute(hands,3:-1:1); % hand per page
hIdx = phands == cards; % hand to card matrix
n = squeeze(sum(sum(hIdx,2) == (1:5))); % num of each card
[rowIndices, colIndices] = find(n); % find max count of card
bigGroup = accumarray(colIndices, rowIndices, [], @max)';
bigGroup(bigGroup == 2) = ... % deal with 2 pair
    bigGroup(bigGroup == 2) + 0.5 * (n(2,bigGroup == 2) == 2);
bigGroup(bigGroup == 3) = ... % deal with full house
    bigGroup(bigGroup == 3) + n(2,bigGroup == 3) * 0.5;

[~,idx] = sort(bigGroup); % sort and score
day7puzzle2result = sum(bids(idx,:) .* (1:numel(bids))') %#ok<NOPTS> 