%% day9puzzle10 - Daniel Breslan - Advent Of Code 2020
data = readmatrix("input.txt");
lead = 25;

q = data(((1:lead) + (0:numel(data)-lead-1)')');
q = reshape(q,1,[],size(q,2)) + pagetranspose(reshape(q,1,[],size(q,2)));
value = data(circshift(~any(q == reshape(data(lead+1:end),1,1,[]),[1 2]),lead));

for idx = 2:numel(data)
    q = data(((1:idx) + (0:numel(data)-idx-1)')');
    if any(sum(q) == value);
        break
    end
end

q = sort(q(:,sum(q) == value));
min(q) + max(q)