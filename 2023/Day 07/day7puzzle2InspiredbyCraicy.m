%% day7puzzle2 - Daniel Breslan - Advent Of Code 2023
% https://discord.com/channels/315631984489791488/452325884955852800/1182287218128212008
data = readlines("input.txt").split(" ").replace(["J" "T" "Q" "K" "A"],["1" "W" "X" "Y" "Z"]);
[~,idx] = sortrows(char(data(:,1)));
data = data(idx,:);
hands = double(char(data(:,1)));
hands(hands == double('1')) = nan;
r = mode(hands,2);
r(isnan(r)) = 2;
[row,~] = ind2sub(size(hands),find(isnan(hands)));
hands(isnan(hands)) = r(row);
hands = reshape(hands',1,5,[]);
s = squeeze(sum(hands == pagetranspose(hands),[1 2]));
[~,idx] = sort(s);
day7puzzle2result = sum(data(idx,2).double() .* (1:height(data))') %#ok<NOPTS> 