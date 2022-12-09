%% day9puzzle1 - Daniel Breslan - Advent Of Code 2022
data = readlines("input.txt").replace(["U","D","L","R"],string(1:4))...
    .split(" ").double(); % load with UDLR as 1 2 3 4 m-x-2 matrix

dirs = [...
    0  1;...   % U - Define direction moves
    0  -1;...  % D
    -1 0;...   % L
    1  0       % R
    ];

hlocations = [0 0;cumsum(dirs(repelem(data(:,1),data(:,2),1),:))]; 
% calculate the head locations, index dir with data, rep it and cumsum
tlocations = zeros(size(hlocations)); % make array for tail

for idx = 2:size(tlocations,1)
    posDelta = diff([tlocations(idx - 1,:); hlocations(idx,:)]); 
    % get diff of new head and old tail
    if all(abs(posDelta) < 2) % no move needed
        tlocations(idx,:) = tlocations(idx - 1,:);
    else % need to move
        tlocations(idx,:) = tlocations(idx - 1,:) + sign(posDelta);
    end
end

day9puzzle1result = size(unique(tlocations,'rows'),1) %#ok<NOPTS> 