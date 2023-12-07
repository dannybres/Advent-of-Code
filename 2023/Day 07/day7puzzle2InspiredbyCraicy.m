%% day7puzzle2 - Daniel Breslan - Advent Of Code 2023
% https://discord.com/channels/315631984489791488/452325884955852800/1182287218128212008

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

hands = double(squeeze(char(hands)));
hands(hands == double('J')) = nan;
r = mode(hands,2);
[row,~] = ind2sub(size(hands),find(isnan(hands)));
hands(isnan(hands)) = r(row);
hands(isnan(hands)) = 2;
hands = reshape(hands',1,5,[]);
s = squeeze(sum(hands == pagetranspose(hands),[1 2]));
[~,idx] = sort(s);
day7puzzle2result = sum(bids(idx,:) .* (1:numel(bids))');