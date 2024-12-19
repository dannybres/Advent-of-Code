%% 
% READ INPUT --------------------------
lines = readlines("inputDemo.txt");
% lines = readlines("./day_16_basic_alt.txt");
% lines = readlines("./day_16_full.txt");
lines = char(lines);

sz = size(lines);
grid = lines ~= '#';
non_walls = find(lines ~= '#');

start = find(lines == 'S');
start_idx = find(non_walls == start);
exit = find(lines == 'E');
exit_idx = find(non_walls == exit);

kernel = zeros(3,3);
kernel(2:2:8) = 1;

curr = zeros(sz);

T = table(non_walls);
[rows, cols ] = ind2sub(sz, non_walls);
T.rows = rows;
T.cols = cols;
T.Name = "(" + T.rows + "," + T.cols + ")";

% THIS WORKS FOR SMALLER MAZE (out of memory for big maze)
adj = zeros(numel(non_walls), numel(non_walls));
for node_num = 1:numel(non_walls)
    node = non_walls(node_num);
    curr(node) = 1;
    nabaz = find(conv2(curr, kernel, 'same') > 0);
    nabaz = nabaz(grid(nabaz));
    adj(node, nabaz) = 1;
    adj(nabaz, node) = 1;
    curr(:) = 0;
end

dirs = [[-1; 0], [1; 0], [0; -1], [0; 1]];
edges = zeros(0,2);

for t = 1:height(T)
    node = T.non_walls(t);
    [nr, nc] = ind2sub(sz, node);
    loc = [nr; nc];

    cands = loc + dirs;
    cands = sub2ind(sz, cands(1,:), cands(2,:));
    cands = cands(ismember(cands, non_walls));
    for cand = cands
        edges(end+1, :) = [node, cand];
    end
end

E = table(edges, 'VariableNames', {'EndNodes'});
TT = table([1:209]', 'VariableNames', {'non_walls'});
Nodes = outerjoin(TT, T);
Nodes.Name = fillmissing(Nodes.Name, 'constant', "");
Nodes.Name = Nodes.non_walls_TT + Nodes.Name;

g = graph(E, Nodes);
walls = degree(g) == 0;
g = rmnode(g, find(walls));

%% THIS WORKS FINE (even though it still lacks the punishment for turning)
shortestpath(g, start_idx, exit_idx)
%% CAUSES OUT-OF-MEMORY ERROR!!
%% allpaths(g, start_idx, exit_idx);


%% 
% SECTION --------------------------



%% 
% SECTION --------------------------



%% 
% SECTION --------------------------


%% 
% SECTION --------------------------


%%
% SECTION ------------------------------
% NAKEDLY STOLEN FROM GITHUB AFTER THE ABOVE FAILED MISERABLEY
% https://github.com/dannybres/Advent-of-Code/blob/main/2024/Day%2016/day16puzzle1.m

%% day16puzzle1 - Daniel Breslan - Advent Of Code 2024
% m = char(readlines("input.txt"));
% m = char(lines);
% lines = char(lines);
% rd = [0 1];
% [cr,cc] = find(m == 'S');
% [tr,tc] = find(m == 'E');
% n = 1e3;
% q = nan(n,6);
% q(1,:) = [0 cr cc rd nan];
% qidx = 1;
% reachTarget = false;
% while true
%     toProcessIdx = find(q(1:qidx,1) == min(q(1:qidx,1)));
%     for idx = 1:height(toProcessIdx)
%         item = q(toProcessIdx(idx),:);
%         ccost = item(1);
%         cr = item(2);
%         cc = item(3);
%         cdir = item(4:5);
%         for d = [-1 0;1 0;0 -1;0 1]'
%             nr = cr + d(1);
%             nc = cc + d(2);
%             if m(nr,nc) == '#', continue, end
%             if all(cdir == -d'), continue, end
%             if all([nr nc] == [tr tc])
%                 reachTarget = true;
%                 day16puzzle1result = ccost + 1;
%                 break
%             end
%             if any(all([nr,nc,d']==q(1:qidx-1,2:5),2)),break,end
%             qidx = qidx + 1;
%             if all(d' == cdir)
%                 q(qidx,:) = [ccost+1,nr,nc,d',toProcessIdx(idx)];
%             else
% 
%                 q(qidx,:) = [ccost+1001,nr,nc,d',toProcessIdx(idx)];
%             end
%         end
%     end
%     if reachTarget, break, end
%     q(toProcessIdx,1) = inf;
%     for x = q(toProcessIdx,2:3)'; lines(x(1), x(2)) = 'x'; end
% end
% 
% day16puzzle1result
