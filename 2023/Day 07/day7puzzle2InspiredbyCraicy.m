%% day7puzzle2 - Daniel Breslan - Advent Of Code 2023
% https://discord.com/channels/315631984489791488/452325884955852800/1182287218128212008
data = readlines("input.txt").split(" ").replace(["J" "T" "Q" "K" "A"],["1" "W" "X" "Y" "Z"]); % change characters to make it sort in asci T Q K A = W X Y Z and J = 1
[~,idx] = sortrows(char(data(:,1))); % sort hands
data = data(idx,:); %reorder hands and bids
hands = double(char(data(:,1))); % build matrix of hands in ascii nums
hands(hands == double('1')) = nan; % nan all jokers (need to be replaces with mode)
r = mode(hands,2);  % find mode
r(isnan(r)) = 2; % all jokers = mode is nan, so change to any card (will be 5 of a kind regardless) and already sorted to the bottom as it was 11111
[row,~] = ind2sub(size(hands),find(isnan(hands))); % get row index of all nans to pick which mode to use
hands(isnan(hands)) = r(row); % replace nans with mode value
hands = reshape(hands',1,5,[]); % make 3D, 1 hand per page
s = squeeze(sum(hands == pagetranspose(hands),[1 2])); % compare with transpose and sum, 5oak will summ to 25 and all match all, FH will sum to 13 as 3x3 will match and 2x2 will match = 13
[~,idx] = sort(s); % Sort on score (25, 17, 13, 11, 9, 7, 5)
day7puzzle2result = sum(data(idx,2).double() .* (1:height(data))') %#ok<NOPTS> % sum product of bid and rank