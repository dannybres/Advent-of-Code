%% day7puzzle2 - Daniel Breslan - Advent Of Code 2023
data = readlines("input.txt").split(" "); % load

% get bids
bids = data(:,2).double; 

% get hands
hands = data(:,1).split(""); 
hands = hands(:,2:end-1);

% get cards
cards = "A, K, Q, T, 9, 8, 7, 6, 5, 4, 3, 2, J"; 
cards = cards.split(", ");

% sort hands by rank ready for same results
[~,idx] = sort(hands.replace(cards',...
    compose("%02i",0:12)).join("").double,1,"descend");
hands = hands(idx,:); 
bids = bids(idx,:); % sort hands by rank ready for same results

% create matrix of number same card per hand ex J and num of J
phands = permute(hands,3:-1:1); % hand per page
hIdx = phands == cards(1:12); % hand to card matrix
n = squeeze(sum(sum(hIdx,2) == (1:5))); % num of each card ex J
hjIdx = phands == cards(13); % hand to J matrix
nj = squeeze(sum(hjIdx,2))'; % num of J

% deal with all jokers - 5oak and no jokers
alljidx = sum(n) == 0;
nj(alljidx) = 0; 
n(5,alljidx) = 1;

% find max count of card
[rowIndices, colIndices] = find(n); 
bigGroup = accumarray(colIndices, rowIndices, [], @max)';

% apply jokers
n(sub2ind(size(n),bigGroup+nj,1:numel(bigGroup))) = ...
    n(sub2ind(size(n),bigGroup+nj,1:numel(bigGroup)))+double(nj>0);
n(sub2ind(size(n),bigGroup,1:numel(bigGroup))) = ...
    n(sub2ind(size(n),bigGroup,1:numel(bigGroup))) -  ...
    double(nj ~= 0);

% find max count of card (after jokers)
[rowIndices, colIndices] = find(n); 
bigGroup = accumarray(colIndices, rowIndices, [], @max)';

% deal with 2 pair and full house
bigGroup(bigGroup == 2) = ...
    bigGroup(bigGroup == 2) + 0.5 * (n(2,bigGroup == 2) == 2);
bigGroup(bigGroup == 3) = ...
    bigGroup(bigGroup == 3) + n(2,bigGroup == 3) * 0.5;

[~,idx] = sort(bigGroup);
day7puzzle2result = sum(bids(idx,:) .* (1:numel(bids))') %#ok<NOPTS> 